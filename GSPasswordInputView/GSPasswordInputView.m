//
//  GSPasswordInputView.m
//  PasswordInput
//
//  Created by Aren on 15/10/18.
//  Copyright © 2015年 Aren. All rights reserved.
//

#import "GSPasswordInputView.h"
#import "GSNoSelectionTextField.h"

static const NSInteger kDefaultNumberOfDigit = 6;
static const NSInteger kDefaultFontSize = 40;

@interface GSPasswordInputView()<UITextFieldDelegate>
@property (strong, nonatomic) GSNoSelectionTextField *inputTextField;
@property (strong, nonatomic) NSArray *numberLabels;
@end

@implementation GSPasswordInputView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initNumberViewWithNumberOfDigit:kDefaultNumberOfDigit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initNumberViewWithNumberOfDigit:kDefaultNumberOfDigit];
        
    }
    return self;
}

- (void)setNumberOfDigit:(NSInteger)numberOfDigit
{
    if (_numberOfDigit!=numberOfDigit) {
        _numberOfDigit = numberOfDigit;
        [self initNumberViewWithNumberOfDigit:numberOfDigit];
    }
}

- (void)setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
    self.layer.borderColor = _borderColor.CGColor;
    for (UILabel *label in self.numberLabels) {
        label.layer.borderColor = _borderColor.CGColor;
    }
}

- (void)setFontSize:(NSInteger)fontSize
{
    _fontSize = fontSize;
    for (UILabel *label in self.numberLabels) {
        label.font = [UIFont systemFontOfSize:_fontSize];
    }
}

- (void)initNumberViewWithNumberOfDigit:(NSInteger)aNumber
{
    _fontSize = kDefaultFontSize;
    self.borderColor = [UIColor colorWithRed:223.0/255 green:223.0/255 blue:223.0/255 alpha:1];
    if (!self.inputTextField) {
        self.inputTextField = [[GSNoSelectionTextField alloc] initWithFrame:self.bounds];
        [self addSubview:self.inputTextField];
        self.inputTextField.tintColor = [UIColor clearColor];
        self.inputTextField.keyboardType = UIKeyboardTypeNumberPad;
        
        [self.inputTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self.inputTextField setTextColor:[UIColor clearColor]];
        NSDictionary *views = NSDictionaryOfVariableBindings(_inputTextField);
        [self.inputTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_inputTextField]-0-|" options:0   metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_inputTextField]-0-|" options:0   metrics:nil views:views]];
        self.inputTextField.borderStyle = UITextBorderStyleNone;
        self.inputTextField.delegate = self;
        
        self.layer.borderWidth = 1;
        self.layer.borderColor = self.borderColor.CGColor;
    }
    
    
    for (UILabel *label in self.numberLabels) {
        [label removeFromSuperview];
    }
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    CGFloat width = self.frame.size.width/aNumber;
    CGFloat height = self.frame.size.height;
    UILabel *preLabel = nil;
    for (int i=0; i<aNumber; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(width*i, 0, width, height)];
        [label setTextAlignment:NSTextAlignmentCenter];
//        label.backgroundColor = [UIColor greenColor];
        label.font = [UIFont systemFontOfSize:self.fontSize];
        [tempArray addObject:label];
        
        [self addSubview:label];
        label.layer.borderWidth = 0.5;
        label.layer.borderColor = self.borderColor.CGColor;
        [label setTranslatesAutoresizingMaskIntoConstraints:NO];
        // left
        if (i == 0) {
            [self addConstraint: [NSLayoutConstraint
                                  constraintWithItem:self
                                  attribute:NSLayoutAttributeLeading
                                  relatedBy:NSLayoutRelationEqual
                                  toItem:label
                                  attribute:NSLayoutAttributeLeading
                                  multiplier:1.0
                                  constant:0.0f]];
        } else {
            [self addConstraint: [NSLayoutConstraint
                                  constraintWithItem:preLabel
                                  attribute:NSLayoutAttributeTrailing
                                  relatedBy:NSLayoutRelationEqual
                                  toItem:label
                                  attribute:NSLayoutAttributeLeading
                                  multiplier:1.0
                                  constant:0.0f]];
            
            [self addConstraint: [NSLayoutConstraint
                                  constraintWithItem:preLabel
                                  attribute:NSLayoutAttributeWidth
                                  relatedBy:NSLayoutRelationEqual
                                  toItem:label
                                  attribute:NSLayoutAttributeWidth
                                  multiplier:1.0
                                  constant:0.0f]];
            if (i == aNumber-1) {
                [self addConstraint: [NSLayoutConstraint
                                      constraintWithItem:self
                                      attribute:NSLayoutAttributeTrailing
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:label
                                      attribute:NSLayoutAttributeTrailing
                                      multiplier:1.0
                                      constant:0.0f]];
            }
        }


        // top
        [self addConstraint: [NSLayoutConstraint
                              constraintWithItem:self
                              attribute:NSLayoutAttributeTop
                              relatedBy:NSLayoutRelationEqual
                              toItem:label
                              attribute:NSLayoutAttributeTop
                              multiplier:1.0
                              constant:0.0f]];
        
        // bottom
        [self addConstraint: [NSLayoutConstraint
                              constraintWithItem:self
                              attribute:NSLayoutAttributeBottom
                              relatedBy:NSLayoutRelationEqual
                              toItem:label
                              attribute:NSLayoutAttributeBottom
                              multiplier:1.0
                              constant:0.0f]];
        
        preLabel = label;
    }
    self.numberLabels = tempArray;
}


- (void)updateLabels
{
    NSString *numberText = self.inputTextField.text;
    NSInteger minLength = MIN(numberText.length, self.numberOfDigit);
    for(int i=0; i<self.numberOfDigit; i++){
        UILabel *label = [self.numberLabels objectAtIndex:i];
        if (i<minLength) {
            label.text = @"●";
        } else {
            label.text = nil;
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

- (void)textFieldDidChange:(UITextField *)textField
{
    [self updateLabels];
    if (textField.text.length >= self.numberOfDigit) {
        if ([self.delegate respondsToSelector:@selector(didFinishEditingWithInputView:text:)]) {
            [self.delegate didFinishEditingWithInputView:self text:textField.text];
        }
    }
}


//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    UIView *view = [super hitTest:point withEvent:event];
//    return view;
//}
@end
