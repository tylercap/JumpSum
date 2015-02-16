//
//  HowToViewController.m
//  jumpsum
//
//  Created by Tyler Cap on 2/16/15.
//  Copyright (c) 2015 Tyler Cap. All rights reserved.
//

#import "HowToViewController.h"

@implementation HowToViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0.0, 20.0, size.width, 44.0)];
    navBar.barStyle = UIBarStyleDefault;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(Back)];
    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@"How To"];
    item.leftBarButtonItem = backButton;
    item.hidesBackButton = YES;
    [navBar pushNavigationItem:item animated:NO];
    
    [self.view addSubview:navBar];
}

/*
- (void)updateViewConstraints
{
    [super updateViewConstraints];
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    NSString *format = [NSString stringWithFormat:@"H:[layer(==%f)]", size.width];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:nil]];

}
 */

- (IBAction)Back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
