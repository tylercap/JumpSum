//
//  HowToChildViewController.m
//  jumpsum
//
//  Created by Tyler Cap on 2/19/15.
//  Copyright (c) 2015 Tyler Cap. All rights reserved.
//

#import "HowToChildViewController.h"

@implementation HowToChildViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0.0, size.width, 44.0)];
    navBar.barStyle = UIBarStyleDefault;
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(Done)];
    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:self.titleValue];
    item.rightBarButtonItem = doneButton;
    item.hidesBackButton = YES;
    [navBar pushNavigationItem:item animated:NO];
    
    [self.view addSubview:navBar];
    
    self.textField.text = self.textValue;
    //[self.textField sizeToFit];
    
    self.imageField.image = [UIImage imageNamed:self.imageFile];
    
    self.imageField.contentMode = UIViewContentModeScaleAspectFit;
}

- (IBAction)Done
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
