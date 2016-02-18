//
//  ViewController.m
//  YSCustomKeyBoard
//
//  Created by chenfenglong on 16/2/17.
//  Copyright © 2016年 YS. All rights reserved.
//

#import "ViewController.h"
#import "UITextField+Extension.h"
#import "YSCustomKeyBoardView.h"

@interface ViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.textField.delegate = self;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    __weak typeof(self) _weakSelf = self;
    YSCustomKeyBoardView *keyBoard = [YSCustomKeyBoardView show];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    view.backgroundColor = [UIColor redColor];
    textField.inputView = keyBoard;
    keyBoard.completeBlock = ^(NSString *titleValue,NSInteger tag){
        if (tag == deleteTag) {
            [textField deleteText];
        }
        else if (tag == completeTag)
        {
            [_weakSelf.view endEditing:YES];
        }
        else
        {
            [textField changetext:titleValue];
        }
    };
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


@end
