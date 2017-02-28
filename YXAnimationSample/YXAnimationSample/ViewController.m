//
//  ViewController.m
//  YXAnimationSample
//
//  Created by yexingxing on 2017/2/25.
//  Copyright © 2017年 叶星星. All rights reserved.
//

#import "ViewController.h"
#import "ReceiverTableViewCell.h"
#import "SenderTableViewCell.h"
#import "ShowLargePicViewController.h"
#import "RootTableViewCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark -UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RootTableViewCell *cell ;
    
    if (indexPath.row % 2 == 0) {
        
        cell = (SenderTableViewCell * )[tableView dequeueReusableCellWithIdentifier:@"sender" forIndexPath:indexPath];
        
    }else{
        
         cell = (ReceiverTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"receiver" forIndexPath:indexPath];
        
        
    }
    cell.tapCallBack = ^(UIImage *image){
        
        ShowLargePicViewController *largePicVC = [[ShowLargePicViewController alloc] initWithLargeImage:image tapHandle:^UIImageView *{
            
            SenderTableViewCell * currentCell = [tableView cellForRowAtIndexPath:indexPath];
            
            return currentCell.showingImageView;
        }];
        
        self.navigationController.delegate = largePicVC;
        
        [self.navigationController pushViewController:largePicVC animated:true];
    };

    
    return cell;
}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
@end
