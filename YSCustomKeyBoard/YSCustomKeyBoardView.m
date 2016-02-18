//
//  YSCustomKeyBoardView.m
//  YSCustomKeyBoard
//
//  Created by chenfenglong on 16/2/17.
//  Copyright © 2016年 YS. All rights reserved.
//

#import "YSCustomKeyBoardView.h"
#define screenH  [UIScreen mainScreen].bounds.size.height
#define screenW  [UIScreen mainScreen].bounds.size.width
#define keyBoardH 275

const NSInteger deleteTag = 110;
const NSInteger completeTag = 111;

@implementation YSCustomKeyBoardView


+ (instancetype)show
{
    YSCustomKeyBoardView *keyBoard = [[YSCustomKeyBoardView alloc] initWithFrame:CGRectMake(0, 0, screenW, keyBoardH)];
    
    //所有按钮
    NSArray *arrayNumber = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:arrayNumber];
    
    //键盘一共四行、三列
    CGFloat rowCount = 4;
    CGFloat columnCount = 3;
    CGFloat buttonW = screenW / columnCount;
    CGFloat buttonH = keyBoardH / rowCount;
    
    UIImage *lightGrayImage = [keyBoard setImageWithColor:[UIColor lightGrayColor]];
    UIImage *whiteImage = [keyBoard setImageWithColor:[UIColor whiteColor]];
    
    for (int row = 0; row < rowCount; row++)
    {
        for (int column = 0; column < columnCount; column++)
        {
            CGFloat buttonX = column * buttonW;
            CGFloat buttonY = row * buttonH;
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
            button.titleLabel.textColor = [UIColor blackColor];
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            [button addTarget:keyBoard action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [keyBoard addSubview:button];
            
            //开始设置按钮点击态颜色
            [button setBackgroundImage:lightGrayImage forState:UIControlStateNormal];
            [button setBackgroundImage:whiteImage forState:UIControlStateHighlighted];
            
            //开始设置按钮
            if (row == 3 && column == 0)
            {
                button.tag = deleteTag;
                [button setBackgroundColor:[UIColor lightGrayColor]];
                [button setTitle:@"删除" forState:UIControlStateNormal];
            }
            else if (row == 3 && column == 2)
            {
                button.tag = completeTag;
                [button setBackgroundColor:[UIColor lightGrayColor]];
                [button setTitle:@"完成" forState:UIControlStateNormal];
            }
            else
            {
                [button setBackgroundImage:whiteImage forState:UIControlStateNormal];
                [button setBackgroundImage:lightGrayImage forState:UIControlStateHighlighted];
                NSInteger index = arc4random_uniform((int)mutableArray.count);
                NSString *value = [mutableArray objectAtIndex:index];
                [mutableArray removeObjectAtIndex:index];
                [button setTitle:value forState:UIControlStateNormal];
            }
            
            
            //由于column的分割线只需要添加一次就好
            if (row == 0 && column != 0 && column != columnCount) {
                CGFloat columnLineX = buttonW * column;
                UIView *columnLine = [[UIView alloc] initWithFrame:CGRectMake(columnLineX, 0, 0.5, keyBoardH)];
                columnLine.backgroundColor = [UIColor blackColor];
                columnLine.layer.zPosition = NSIntegerMax;
                [keyBoard addSubview:columnLine];
            }
        }
        
        if (row != rowCount && row != 0) {
            CGFloat rowLineY = row * buttonH;
            UIView *rowLine = [[UIView alloc] initWithFrame:CGRectMake(0, rowLineY, screenW, 0.5)];
            rowLine.backgroundColor = [UIColor blackColor];
            rowLine.layer.zPosition = NSIntegerMax;
            [keyBoard addSubview:rowLine];
        }
    }
    return keyBoard;
}

- (void)buttonClick:(UIButton *)button
{
    NSString *buttonString = [button titleForState:UIControlStateNormal];
    NSLog(@"%@",buttonString);
    if (self.completeBlock) {
        self.completeBlock(buttonString,button.tag);
    }

}

- (UIImage *)setImageWithColor:(UIColor *)originColor
{
    CGRect rect = CGRectMake(0, 0, 10.0, 10.0);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef contentRef = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(contentRef, [originColor CGColor]);
    CGContextFillRect(contentRef, rect);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


@end
