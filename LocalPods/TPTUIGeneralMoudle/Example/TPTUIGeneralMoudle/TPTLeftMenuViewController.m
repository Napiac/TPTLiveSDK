//
//  TPTContentViewController.m
//  TPTUIGeneralMoudle_Example
//
//  Created by Napiac on 2023/3/31.
//  Copyright © 2023 Napiac. All rights reserved.
//

#import "TPTLeftMenuViewController.h"
#import <TPTUIGeneralMoudle/UIViewController+DrawerMenuController.h>

@interface TPTLeftMenuViewController ()

@end

@implementation TPTLeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor randomColor];
    
    UILabel * textlabel = [UILabel new];
    textlabel.text = @"LEFT";
    textlabel.textAlignment = NSTextAlignmentCenter;
    textlabel.textColor = [UIColor randomColor];
    textlabel.frame = CGRectMake(0, 200, self.view.width, 20.f);
    textlabel.font = [UIFont systemFontOfSize:18.f weight:UIFontWeightMedium];
    [self.view addSubview:textlabel];
    
    
    // Do any additional setup after loading the view.
}
//
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.drawerMenuController openDrawerSide:DrawerMenuSideRight animated:YES completion:^(BOOL finished) {
//        
//    }];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
