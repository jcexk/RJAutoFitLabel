# RJAutoFitLabel
xib适配字体字号，快速设置边框圆角
#
在遇到一些简单、业务逻辑不复杂的页面时，我会考虑是否用xib进行开发。

xib的优缺点还是很明显的，如下几点可供参考：
#### 优点：
* 界面可视化开发方式，所见即所得，对于UI层级关系一目了然
* 可轻松拖拽控件快速搭建UI，效率高
* 开发速度快

#### 缺点：
* 易读性差，不利于多人协同开发(约束没有代码直观)
* 需求变更时，修改成本较大，不利于后期维护(可能过阵子开发者本人都不知道控件之间的约束关系了)
* 过多的xib，会影响内存；加载一个XIB到内存的时候，它所有的内容都会载入内存，包括所有的图片。

综上几点，该用代码还是xib，请权衡利弊，我的建议是在迭代周期短、业务逻辑不复杂的页面时，可以考虑用xib开发，否则还是用代码吧。

好了，进入主题，在使用xib过程中，难免会遇到需要设置控件圆角边框这些需求，普通的做法是通过关联在.h.m文件里属性，再用代码来设置；这种做法并不是不可以，只是苹果还提供了`@IBInspectable`关键词，方便开发者给xib控件自定义属性。
### @IBInspectable
`IBInspectable`是iOS8推出的新特性，可以实时渲染在interface builder上，并且直接修改就能发生变化。
因为UIView.layer.borderWidth、borderColor、cornerRadius这些属性在xib上是不能直接设置的，但是@IBDesignable和@IBInspectable利用运行时机制，可以把这些属性映射到xib上，同时还可以映射自定义的属性。
而`IBDesignable`关键字用来声明一个类是可以被设计的，可以实时渲染在interface builder 上。
在xib上的示例图中，可以看到右边直接显示了UIView分类中自定义的IBInspectable属性，直接在xib修改，避免代码改变这些属性。
![-w267](https://github.com/jcexk/jcexk.github.io/blob/master/images/16194586000253.jpg?raw=true)
### xib设置边框、圆角
废话不多说，直接上代码，源码在文末有下载链接，喜欢可以点个star

```
UIView.h
@interface UIView (BorderCircle)

/* 圆角半径 */
@property(nonatomic, assign) IBInspectable CGFloat rjCornerRadius;
/* 边框宽度 */
@property(nonatomic, assign) IBInspectable CGFloat rjBorderWidth;
/* 边框颜色 */
@property(nonatomic, weak)   IBInspectable UIColor *rjBorderColor;
@end


UIView.m

@implementation UIView (XIBTool)

#pragma mark - -- borderColor
-(void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}
-(UIColor *)borderColor
{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}
#pragma mark - -- borderWidth
-(void)setBorderWidth:(CGFloat)borderWidth
{
    self.layer.borderWidth = borderWidth;
}
-(CGFloat)borderWidth
{
    return self.layer.borderWidth;
}
#pragma mark - -- cornerRadius
-(void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.masksToBounds = (cornerRadius>0);
    self.layer.cornerRadius = cornerRadius;
}
-(CGFloat)cornerRadius
{
    return self.layer.cornerRadius;
}
@end
```
### xib+label适配UIFont
在实际开发过程中，不同的屏幕设备需要设置不同的字号，而通过xib创建的UILabel/UIButton/UITextField/UITextView，不可能在大屏设备和5S设备上都是同一个字号。
我们可以利用前面提到的`IBInspectable`关键字，结合`runtime`，来满足xib动态适配字号大小的需求，UILabel示例代码如下，UIButton
/UITextField/UITextView 代码在此:[源码](https://github.com/jcexk/RJAutoFitLabel)
```
@interface UILabel (XIBFont)
/* font 暂不支持富文本*/
@property(nonatomic, assign) IBInspectable BOOL rjAutoFit;
@end

```
.m文件
```
@implementation UILabel (XIBFont)

#pragma mark - -- setRjAutoFit
-(void)setRjAutoFit:(BOOL)rjAutoFit
{
    if (rjAutoFit) {
        UIFont *orFont = self.font;
        self.font = [UIFont fontWithDescriptor:orFont.fontDescriptor size:orFont.pointSize*rjRATIO];
    }
    objc_setAssociatedObject(self, &RJLabelAutoFitKey, RJLabelAutoFitKey, OBJC_ASSOCIATION_ASSIGN);
}
-(BOOL)rjAutoFit
{
    return objc_getAssociatedObject(self, &RJLabelAutoFitKey);;
}
@end
```
[GitHub地址，喜欢请给个star](https://github.com/jcexk/RJAutoFitLabel)
