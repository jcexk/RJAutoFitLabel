//
//  UIFont+XIB.h
//  AudioRecordMap
//
//  Created by hudun on 2020/5/14.
//  Copyright © 2020 Ring Ren. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (BorderCircle)

/* 圆角半径 */
@property(nonatomic, assign) IBInspectable CGFloat rjCornerRadius;
/* 边框宽度 */
@property(nonatomic, assign) IBInspectable CGFloat rjBorderWidth;
/* 边框颜色 */
@property(nonatomic, weak)   IBInspectable UIColor *rjBorderColor;

@end

@interface UIButton (XIBFont)
/* font 暂不支持富文本*/
@property(nonatomic, assign) IBInspectable BOOL rjAutoFit;
@end

@interface UITextField (XIBFont)
/* font 暂不支持富文本*/
@property(nonatomic, assign) IBInspectable BOOL rjAutoFit;
@end

@interface UILabel (XIBFont)
/* font 暂不支持富文本*/
@property(nonatomic, assign) IBInspectable BOOL rjAutoFit;
@end

@interface UITextView (XIBFont)
/* font 暂不支持富文本*/
@property(nonatomic, assign) IBInspectable BOOL rjAutoFit;
@end

NS_ASSUME_NONNULL_END
