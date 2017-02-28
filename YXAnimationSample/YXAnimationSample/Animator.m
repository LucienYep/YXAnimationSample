//
//  Animator.m
//  YXAnimationSample
//
//  Created by yexingxing on 2017/2/26.
//  Copyright © 2017年 叶星星. All rights reserved.
//

#import "Animator.h"
#import "ViewController.h"
#import "ShowLargePicViewController.h"

#define DURATION 0.5

@interface Animator ()

@property (nonatomic,assign)NaviTransitionType type;

@property (nonatomic,copy) UIImageView *(^tapHandle)();

@end

@implementation Animator

-(instancetype)initWithNaviTransitionType:(NaviTransitionType)type tapHandle:(UIImageView *(^)())tapHandle
{
    if (self = [super init]) {
        
        self.type = type;
            
        self.tapHandle = tapHandle;
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

/**
 返回动画执行时间

 @param transitionContext 上下文,里面可以获取到很多动画需要的信息
 @return 动画时长
 */
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    return DURATION;
}


/**
 执行动画的具体

 */
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.type == NaviTransitionTypePush) {
        
        //push动画
        [self beginPushAnimationWithTransitionContext:transitionContext];
        
    }else{
        
        //pop动画
        [self beginPopAnimationWithTransitionContext:transitionContext];
    }
}

- (void)beginPushAnimationWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext
{

    ShowLargePicViewController *toVC = (ShowLargePicViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //获取当前点击的View
    UIImageView *animationIv = self.tapHandle();
    
    //生成截图,这句在模拟器上生成的是空白的截图,需要注意
    UIView *snapShotAnimationView = [animationIv snapshotViewAfterScreenUpdates:false];
    
    //动画容器视图,所有动画都在里面执行
    UIView *containerView = [transitionContext containerView];
    
    //原始坐标系转化到container坐标系
    snapShotAnimationView.frame = [animationIv convertRect:animationIv.bounds toView:containerView];
    //假如动画容器中
    [containerView addSubview:toVC.view];
    [containerView addSubview:snapShotAnimationView];
    //设置原始状态
    animationIv.hidden = true;
    toVC.resultIv.hidden = true;
    toVC.view.alpha = 0.0;
    //计算container坐标最终坐标
    CGRect resultRect = [toVC.resultIv convertRect:toVC.resultIv.bounds toView:containerView];
    //执行动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        snapShotAnimationView.frame = resultRect;
        toVC.view.alpha = 1.0;
        
    } completion:^(BOOL finished) {
    
        snapShotAnimationView.hidden = true;
        toVC.resultIv.hidden= false;
        //这个一定要写,避免动画过程中出现未知的bug
        [transitionContext completeTransition:true];
    }];
    
}

- (void)beginPopAnimationWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext
{
    ShowLargePicViewController *fromVC = (ShowLargePicViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    ViewController *toVc = (ViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    // 取出container中的刚才push做动画的截图
    __block UIView *snapShotAnimationView = containerView.subviews.lastObject;
    
    snapShotAnimationView.hidden = false;
    
    CGRect snapShotAnimationViewRect = snapShotAnimationView.bounds;
    
    snapShotAnimationViewRect.size = fromVC.resultIv.bounds.size;
    
    snapShotAnimationView.bounds = snapShotAnimationViewRect;
    //由于是从container中直接取出来的,所以不需要再加进去,直接转换坐标系
    [snapShotAnimationView convertRect:snapShotAnimationView.bounds toView:containerView];
    
    fromVC.resultIv.hidden = true;
    //插入是为了防止挡住执行动画的View
    [containerView insertSubview:toVc.view atIndex:0];
    //获取最终的View
    UIImageView *resultView = self.tapHandle();
    
    CGRect resultRect = [resultView convertRect:resultView.bounds toView:containerView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        snapShotAnimationView.frame = resultRect;
        
        fromVC.view.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        [snapShotAnimationView removeFromSuperview];
        snapShotAnimationView = nil;
        
        resultView.hidden = false;
        //这里也必须执行这句,原因跟上面是一样的
        [transitionContext completeTransition:true];
    }];

}

@end
