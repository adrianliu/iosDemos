//
//  MainViewController.m
//  AddressBookDemo
//
//  Created by xiaopeng liu on 16/11/14.
//  Copyright (c) 2014 iOSCreator. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)showContacts:(id)sender {
    ViewController *contactViewController=[[ViewController alloc] init];
    UINavigationController *navController=[[UINavigationController alloc] initWithRootViewController:contactViewController];
    [self presentModalViewController:navController animated:YES];
}
@end




















