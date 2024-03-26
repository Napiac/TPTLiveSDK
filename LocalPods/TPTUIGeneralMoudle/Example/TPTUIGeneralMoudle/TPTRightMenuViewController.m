//
//  TPTRightMenuViewController.m
//  TPTUIGeneralMoudle_Example
//
//  Created by Napiac on 2023/3/31.
//  Copyright © 2023 Napiac. All rights reserved.
//

#import "TPTRightMenuViewController.h"

@interface TPTRightMenuViewController ()

@end

@implementation TPTRightMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel * textlabel = [UILabel new];
    textlabel.text = @"RIGHT";
    textlabel.textAlignment = NSTextAlignmentCenter;
    textlabel.textColor = [UIColor randomColor];
    textlabel.frame = CGRectMake(0, 200, self.view.width, 20.f);
    textlabel.font = [UIFont systemFontOfSize:18.f weight:UIFontWeightMedium];
    [self.view addSubview:textlabel];
    self.view.backgroundColor = [UIColor randomColor];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
