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
    self.alView=[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.alView.backgroundColor=[UIColor redColor];
    [self.view addSubview:self.alView];
    
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


-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        //code
        [self.alView removeFromSuperview];
        NSLog(@"width is: %f",size.width);
        NSLog(@"height is: %f",size.height);
        self.alView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        self.alView.backgroundColor=[UIColor yellowColor];
        [self.view addSubview:self.alView];

    } completion:nil];
    
}


@end









































