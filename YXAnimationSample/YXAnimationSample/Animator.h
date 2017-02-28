//
//  Animator.h
//  YXAnimationSample
//
//  Created by yexingxing on 2017/2/26.
//  Copyright © 2017年 叶星星. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(int, NaviTransitionType) {
    NaviTransitionTypePush = 0,
    NaviTransitionTypePop
};


@interface Animator : NSObject <UIViewControllerAnimatedTransitioning>

- (instancetype)initWithNaviTransitionType:(NaviTransitionType)type tapHandle:(UIImageView * (^)())tapHandle;

@end
