//
//  ShowLargePicViewController.m
//  YXAnimationSample
//
//  Created by yexingxing on 2017/2/26.
//  Copyright © 2017年 叶星星. All rights reserved.
//

#import "ShowLargePicViewController.h"
#import "Animator.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ShowLargePicViewController ()

@property (nonatomic,strong)UIImage *largeImage;

@property (nonatomic,copy) UIImageView *(^tapHandle)();

@end

@implementation ShowLargePicViewController

-(instancetype)initWithLargeImage:(UIImage *)largeImage tapHandle:(UIImageView * (^)())tapHandle
{
    if (self = [super init]) {
        
        self.largeImage = largeImage;
        
        self.tapHandle = tapHandle;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    [self setupImageView];
}

- (void)setupImageView
{
    UIImageView *iv = [[UIImageView alloc] initWithImage:self.largeImage];
    
    CGFloat height = self.largeImage.size.height / self.largeImage.size.width * SCREEN_WIDTH;
    CGSize size = CGSizeMake(SCREEN_WIDTH, height);
    
    CGRect rect = {CGPointMake(0, 0),size};
    iv.frame = rect;
    
    iv.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);
    
    self.resultIv = iv;
    
    [self.view addSubview:iv];
}

#pragma mark - UINavigationControllerDelegate

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush) {
        
        return [[Animator alloc] initWithNaviTransitionType:NaviTransitionTypePush tapHandle:self.tapHandle];
        
    } else {
        
        return [[Animator alloc] initWithNaviTransitionType:NaviTransitionTypePop tapHandle:self.tapHandle];
    }
}
@end
