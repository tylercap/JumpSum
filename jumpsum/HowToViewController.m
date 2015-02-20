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
    
    _pageTitles = @[@"Objective", @"Gameplay", @"Scoring", @"Example 1", @"Example 2", @"Example 3", @"Example 4"];
    _pageImages = @[@"", @"", @"", @"example1.png", @"example2.png", @"example3.png", @"example4.png"];
    _pageTextFields = [self getTextValues];
    
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    HowToChildViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(HowToChildViewController *)viewController index];
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(HowToChildViewController *)viewController index];
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageTitles count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
    
}

- (HowToChildViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    HowToChildViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HowToChildPage"];
    pageContentViewController.imageFile = self.pageImages[index];
    pageContentViewController.titleValue = self.pageTitles[index];
    pageContentViewController.textValue = self.pageTextFields[index];
    
    pageContentViewController.index = index;
    
    return pageContentViewController;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    // The number of items reflected in the page indicator.
    return [self.pageTitles count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    // The selected item reflected in the page indicator.
    return 0;
}

- (NSArray *)getTextValues
{
    NSString *objective = @"The objective of the game is to jump the tiles over one another to achieve the highest total on a single tile.  The maximum score achievable is 100.";
    
    NSString *gameplay = @"Tiles can be moved by dragging and dropping them.  A numbered tile can only be moved under the following circumstances.  The tile must be two spaces away from an open space, and there must be another numbered tile in between the first numbered tile and the open space.  When one numbered tile jumps over another, the numbers on the tiles are added together, and the result is placed in the space that was originally open.  Let\'s say tiles A, B, and C are laid out in a row.  If tile A is currently 7, tile B is currently 4, and tile C is currently open, tile A could be moved over tile B.  Afterwards, tile C would become 11, and tiles A and B would both be open.  The game is over once there are no valid moves remaining.";
    
    NSString *scoring = @"The score is equal to the highest value on any of the tiles.";
    
    NSString *example1 = @"The gameboard seen here will be used as an example. The 3 in the first row can be moved over the 2.";
    NSString *example2 = @"Then the 20 can be moved over the 5 in the first row as well.";
    NSString *example3 = @"Then the 25 can be moved over the 4 in the second column.";
    NSString *example4 = @"There are still remaining moves that can be made, but the current score for this example would be 29.";
    
    return @[objective, gameplay, scoring, example1, example2, example3, example4];
}

@end
