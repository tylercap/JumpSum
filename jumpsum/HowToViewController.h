//
//  HowToViewController.h
//  jumpsum
//
//  Created by Tyler Cap on 2/16/15.
//  Copyright (c) 2015 Tyler Cap. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HowToChildViewController.h"

@interface HowToViewController : UIViewController <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *pageTextFields;
@property (strong, nonatomic) NSArray *pageImages;

@end
