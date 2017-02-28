//
//  SenderTableViewCell.m
//  YXAnimationSample
//
//  Created by yexingxing on 2017/2/25.
//  Copyright © 2017年 叶星星. All rights reserved.
//

#import "SenderTableViewCell.h"

@implementation SenderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle:)];
    
    [self.showingImageView addGestureRecognizer:tap];
}

- (void)tapHandle:(UITapGestureRecognizer *)rec
{
    UIImageView *tapImageView = (UIImageView *) rec.view;
    UIImage *image = tapImageView.image;
    
    if (self.tapCallBack) {
        self.tapCallBack (image);
    }
}

@end
