//
//  MainViewController.m
//  XMAlertView
//
//  Created by rgshio on 15/8/19.
//  Copyright (c) 2015年 hongyin. All rights reserved.
//

#import "MainViewController.h"
#import "XMAlertView.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)showAlertView:(id)sender
{
    XMAlertView *alertView = [[XMAlertView alloc] initWithTitle:@"demo" message:@"这是一个测试" cancelButtonTitle:@"取消" otherButtonTitles:@"确定"];
    [alertView show];
    
    alertView.actionBlock = ^(NSInteger buttonIndex) {
        NSLog(@"buttonIndex = %ld", buttonIndex);
    };
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
