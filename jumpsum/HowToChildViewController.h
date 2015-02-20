//
//  HowToChildViewController.h
//  jumpsum
//
//  Created by Tyler Cap on 2/19/15.
//  Copyright (c) 2015 Tyler Cap. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HowToChildViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageField;
@property (weak, nonatomic) IBOutlet UILabel *textField;

@property (assign, nonatomic) NSInteger index;
@property NSString *titleValue;
@property NSString *textValue;
@property NSString *imageFile;

@end
