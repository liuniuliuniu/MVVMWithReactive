//
//  detailVC.m
//  Reactive Demo
//
//  Created by liushaohua on 2017/1/2.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import "detailVC.h"

@interface detailVC ()

@property (weak, nonatomic) IBOutlet UILabel *accountInfo;

@end



@implementation detailVC
- (IBAction)btnClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.accountInfo.text = [NSString stringWithFormat:@"账号:%@, 密码:%@",self.userName,self.password];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
