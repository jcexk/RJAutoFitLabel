//
//  UIView+XIBTool.m
//  RJAutoFitLabel
//
//  Created by 江其 on 2021/4/26.
//

#import "UIView+XIBTool.h"
#import <objc/runtime.h>

//假设以屏宽414pt为准，参数可改
#define rjRATIO (UIScreen.mainScreen.bounds.size.width / 414.0)

static NSString * const RJButtonAutoFitKey     = @"rjButtonAutoFit";
static NSString * const RJTextFieldAutoFitKey  = @"rjTextFieldAutoFit";
static NSString * const RJLabelAutoFitKey      = @"rjLabelAutoFit";
static NSString * const RJTextViewAutoFitKey   = @"rjTextViewAutoFitKey";

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

@implementation UIButton (XIBFont)
#pragma mark - -- setJqNormal
-(void)setRjAutoFit:(BOOL)rjAutoFit
{
    if (rjAutoFit) {
        UIFont *orFont = self.titleLabel.font;
        self.titleLabel.font = [UIFont fontWithDescriptor:orFont.fontDescriptor size:orFont.pointSize*rjRATIO];
    }
    objc_setAssociatedObject(self, &RJButtonAutoFitKey, RJButtonAutoFitKey, OBJC_ASSOCIATION_ASSIGN);
}
-(BOOL)rjAutoFit
{
    return objc_getAssociatedObject(self, &RJButtonAutoFitKey);;
}
@end

@implementation UITextField (XIBFont)
@dynamic rjAutoFit;
#pragma mark - -- setJqNormal
-(void)setRjAutoFit:(BOOL)rjAutoFit
{
    if (rjAutoFit) {
        UIFont *orFont = self.font;
        self.font = [UIFont fontWithDescriptor:orFont.fontDescriptor size:orFont.pointSize*rjRATIO];
    }
    objc_setAssociatedObject(self, &RJTextFieldAutoFitKey, RJTextFieldAutoFitKey, OBJC_ASSOCIATION_ASSIGN);
}
-(BOOL)rjAutoFit
{
    return objc_getAssociatedObject(self, &RJTextFieldAutoFitKey);;
}
@end

@implementation UILabel (XIBFont)

#pragma mark - -- setJqNormal
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

@implementation UITextView (XIBFont)
#pragma mark - -- setJqNormal
-(void)setRjAutoFit:(BOOL)rjAutoFit
{
    if (rjAutoFit) {
        UIFont *orFont = self.font;
        self.font = [UIFont fontWithDescriptor:orFont.fontDescriptor size:orFont.pointSize*rjRATIO];
    }
    objc_setAssociatedObject(self, &RJTextViewAutoFitKey, RJTextViewAutoFitKey, OBJC_ASSOCIATION_ASSIGN);
}
-(BOOL)rjAutoFit
{
    return objc_getAssociatedObject(self, &RJTextViewAutoFitKey);;
}
@end

