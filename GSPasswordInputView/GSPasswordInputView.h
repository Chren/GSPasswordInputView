//
//  GSPasswordInputView.h
//  PasswordInput
//
//  Created by Aren on 15/10/18.
//  Copyright © 2015年 Aren. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GSPasswordInputView;
@protocol GSPasswordInputViewDelegate<NSObject>
@optional
- (void)didFinishEditingWithInputView:(GSPasswordInputView *)anInputView text:(NSString *)aText;

@end

@interface GSPasswordInputView : UIView
@property (readonly, nonatomic) UITextField *inputTextField;
@property (assign, nonatomic) NSInteger numberOfDigit;
@property (assign, nonatomic) NSInteger fontSize;
@property (assign, nonatomic) id<GSPasswordInputViewDelegate> delegate;
@property (strong, nonatomic) UIColor *borderColor;
@end
