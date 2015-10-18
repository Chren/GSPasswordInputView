//
//  GSNoSelectionTextField.m
//  PasswordInput
//
//  Created by Aren on 15/10/18.
//  Copyright © 2015年 Aren. All rights reserved.
//

#import "GSNoSelectionTextField.h"

@implementation GSNoSelectionTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return false;
}

@end
