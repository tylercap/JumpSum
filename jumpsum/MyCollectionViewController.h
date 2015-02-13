//
//  MyCollectionViewController.h
//  jumpsum
//
//  Created by Tyler Cap on 2/5/15.
//  Copyright (c) 2015 Tyler Cap. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCollectionViewCell.h"
#import "Gameboard.h"
#import "GameboardL1.h"
#import "MyCollectionViewLayout.h"
#import "MyButtonCell.h"
#import "MyLabelCell.h"
#import "CellPair.h"
#import "MyBannerCell.h"
#import <GooglePlayGames/GooglePlayGames.h>

@interface MyCollectionViewController : UICollectionViewController
<UICollectionViewDataSource, GADInterstitialDelegate, GPGStatusDelegate>

@property (nonatomic, weak) IBOutlet MyCollectionViewLayout *layout;
@property(strong, nonatomic) Gameboard *gameboard;
@property(strong, nonatomic) NSMutableArray *tiles;

@property (strong, nonatomic) GADInterstitial *interstitial;
@property (nonatomic) Boolean signedIn;
@property (nonatomic) Boolean silentlySigningIn;

@property (nonatomic) NSInteger headerSections;
@property (nonatomic) NSInteger footerSections;

@property (weak, nonatomic) MyButtonCell *restartGame;
@property (weak, nonatomic) MyButtonCell *howTo;
@property (weak, nonatomic) MyButtonCell *signInOut;
@property (weak, nonatomic) MyButtonCell *leaderboard;
@property (weak, nonatomic) MyLabelCell *currentScoreLabel;
@property (weak, nonatomic) MyLabelCell *highScoreLabel;
@property (weak, nonatomic) MyBannerCell *bannerAdCell;

-(void)highlightValidTargets:(NSIndexPath *)indexPath
                   highlight:(Boolean)highlight;
-(Boolean)jumpedTile:(NSIndexPath *)indexPath
             landing:(CGPoint)dropTarget;

@end

