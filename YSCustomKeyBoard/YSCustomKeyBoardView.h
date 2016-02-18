//
//  YSCustomKeyBoardView.h
//  YSCustomKeyBoard
//
//  Created by chenfenglong on 16/2/17.
//  Copyright © 2016年 YS. All rights reserved.
//

#import <UIKit/UIKit.h>


extern const NSInteger deleteTag;
extern const NSInteger completeTag;

typedef void(^CompleteBlock)(NSString *titleValue,NSInteger tag);
@interface YSCustomKeyBoardView : UIView

+ (instancetype)show;

@property (nonatomic,copy) CompleteBlock completeBlock;

@end
