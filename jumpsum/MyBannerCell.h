//
//  MyBannerCell.h
//  jumpsum
//
//  Created by Tyler Cap on 2/11/15.
//  Copyright (c) 2015 Tyler Cap. All rights reserved.
//

@import GoogleMobileAds;

#import <UIKit/UIKit.h>

@interface MyBannerCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet GADBannerView *bannerAd;

@end
