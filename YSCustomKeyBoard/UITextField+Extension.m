//
//  UITextField+Extension.m
//  YSCustomKeyBoard
//
//  Created by chenfenglong on 16/2/17.
//  Copyright © 2016年 YS. All rights reserved.
//

#import "UITextField+Extension.h"

@implementation UITextField (Extension)

- (void)changetext:(NSString *)text
{
    UITextPosition *beginning = self.beginningOfDocument;
    UITextPosition *start = self.selectedTextRange.start;
    UITextPosition *end = self.selectedTextRange.end;
    NSInteger startIndex = [self offsetFromPosition:beginning toPosition:start];
    NSInteger endIndex = [self offsetFromPosition:beginning toPosition:end];
    NSString *originText = self.text;
    NSString *firstPart = [originText substringToIndex:startIndex];
    NSString *secondPart = [originText substringFromIndex:endIndex];
    
    NSInteger offset;
    
    if (![text isEqualToString:@""])
    {
        offset = text.length;
    }
    else
    {
        if (startIndex == endIndex)
        {
            if (startIndex == 0)
            {
                return;
            }
            offset = -1;
            firstPart = [firstPart substringToIndex:(firstPart.length - 1)];
        }
        else
        {
            offset = 0;
        }
    }
    
    NSString *newText = [NSString stringWithFormat:@"%@%@%@", firstPart, secondPart, text];
    newText = [NSString stringWithFormat:@"%@%@%@",firstPart,text,secondPart];
    self.text = newText;
    UITextPosition *now = [self positionFromPosition:start offset:offset];
    UITextRange *range = [self textRangeFromPosition:now toPosition:now];
    self.selectedTextRange = range;
}

- (void)deleteText
{
    UITextPosition *begining = self.beginningOfDocument;
    UITextPosition *start = self.selectedTextRange.start;
    UITextPosition *end = self.selectedTextRange.end;
    NSInteger startIndex = [self offsetFromPosition:begining toPosition:start];
    NSInteger endIndex = [self offsetFromPosition:begining toPosition:end];
    NSString *originText = self.text;
    NSString *firstPart = [originText substringToIndex:startIndex];
    NSString *secondPart = [originText substringFromIndex:endIndex];
    
    //分为两种情况了
    /*
     1、startIndex == endIndex ；代表是没有选中多余的字符
     2、startIndex != endIndex ；代表是选中多个字符
     */
    NSInteger offset;
    if (startIndex == endIndex)
    {
        if (startIndex == 0) {
            return;
        }
        offset = - 1;
        firstPart = [firstPart substringToIndex:(firstPart.length - 1)];
    }
    else
    {
        offset = 0;
    }
    
    NSString *newText = [NSString stringWithFormat:@"%@%@%@", firstPart, secondPart, @""];
    newText = [NSString stringWithFormat:@"%@%@%@",firstPart,@"",secondPart];
    self.text = newText;
    UITextPosition *now = [self positionFromPosition:start offset:offset];
    UITextRange *range = [self textRangeFromPosition:now toPosition:now];
    self.selectedTextRange = range;
}

@end
