//
//  RootTableViewCell.h
//  YXAnimationSample
//
//  Created by yexingxing on 2017/2/27.
//  Copyright © 2017年 叶星星. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootTableViewCell : UITableViewCell

@property (nonatomic,copy)void (^tapCallBack)(UIImage *image);

@end
