//
//  ShowLargePicViewController.h
//  YXAnimationSample
//
//  Created by yexingxing on 2017/2/26.
//  Copyright © 2017年 叶星星. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowLargePicViewController : UIViewController<UINavigationControllerDelegate>

- (instancetype)initWithLargeImage:(UIImage *)largeImage tapHandle: (UIImageView * (^)())tapHandle;

@property (nonatomic,strong)UIImageView *resultIv;

@end
