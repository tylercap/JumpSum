//
//  MyCollectionViewController.m
//  jumpsum
//
//  Created by Tyler Cap on 2/5/15.
//  Copyright (c) 2015 Tyler Cap. All rights reserved.
//

@import GoogleMobileAds;

#import "MyCollectionViewController.h"

static NSString * const CellIdentifier = @"TileCell";
static NSString * const ButtonIdentifier = @"ButtonCell";
static NSString * const LabelIdentifier = @"LabelCell";
static NSString * const BannerIdentifier = @"BannerCell";
static NSString * const CurrentScore = @"Current Score: ";
static NSString * const HighScore = @"High Score: ";
static NSString * const BannerAdId = @"ca-app-pub-3940256099942544/2934735716";
static NSString * const InterstitialAdId = @"ca-app-pub-3940256099942544/4411468910";

@implementation MyCollectionViewController

- (Gameboard *)gameboard
{
    if (_gameboard != nil) {
        return _gameboard;
    }
    _gameboard = [[GameboardL1 alloc] init];
    return _gameboard;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // NSLog(@"Google Mobile Ads SDK version: %@", [GADRequest sdkVersion]);
    
    _headerSections = 2;
    _footerSections = 1;
    
    self.tiles = [[NSMutableArray alloc] initWithCapacity:[self.gameboard getSections]];
    for( int i = 0; i < [self.gameboard getSections]; i++ ){
        NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:[self.gameboard getItems]];
        [self.tiles addObject:items];
    }
}

- (void)loadInterstitial
{
    self.interstitial = [[GADInterstitial alloc] init];
    self.interstitial.adUnitID = InterstitialAdId;
    
    GADRequest *request = [GADRequest request];
    self.interstitial.delegate = self;
    [self.interstitial loadRequest:request];
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial {
    [self loadInterstitial];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self updateScore:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (_gameboard != nil) {
        [_gameboard saveToSandbox];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    if (_gameboard != nil) {
        [_gameboard saveToSandbox];
    }
}

- (Boolean)jumpedTile:(NSIndexPath *)indexPath
           landing:(CGPoint)dropTarget
{
    NSInteger row = [indexPath section] - _headerSections;
    NSInteger column = [indexPath item];
    
    NSMutableArray *validTargets = [self getValidTargets:row column:column];
    for( CellPair *validTarget in validTargets ){
        MyCollectionViewCell *landingTile = (MyCollectionViewCell*)validTarget.landingCell;
        
        if (CGRectContainsPoint(landingTile.frame, dropTarget)) {
            // update the visible tile and the gameboard data
            NSInteger row = [indexPath section] - _headerSections;
            NSInteger column = [indexPath item];
            NSMutableArray *rowArray = [self.tiles objectAtIndex:row];
            MyCollectionViewCell *draggedTile = [rowArray objectAtIndex:column];
            
            MyCollectionViewCell *jumpedTile = (MyCollectionViewCell*)validTarget.jumpedCell;
            
            NSInteger landingValue = draggedTile.value + jumpedTile.value;
            [landingTile setLabel:landingValue];
            
            [draggedTile setLabel:-1];
            [jumpedTile setLabel:-1];
            
            // still have to update the gameboard data
            [self.gameboard setValueAt:-1
                                   row:row
                                column:column];
            
            NSIndexPath *jumpedPath = [self.collectionView indexPathForCell:jumpedTile];
            NSIndexPath *landingPath = [self.collectionView indexPathForCell:landingTile];
            
            row = [jumpedPath section] - _headerSections;
            column = [jumpedPath item];
            [self.gameboard setValueAt:-1
                                   row:row
                                column:column];
            
            row = [landingPath section] - _headerSections;
            column = [landingPath item];
            [self.gameboard setValueAt:landingValue
                                   row:row
                                column:column];
            
            [self updateScore:YES];
            
            return YES;
        }
    }
    
    return NO;
}

- (void)updateScoreNoCheck
{
    [self updateScore:NO];
}

- (void)updateScore:(Boolean)gameOverCheck
{
    Boolean gameOver = gameOverCheck;
    NSInteger currentScore = 0;
    
    for( int i=0; i<[self.gameboard getSections]; i++ ){
        for( int j=0; j<[self.gameboard getItems]; j++ ){
            NSMutableArray *rowArray = [self.tiles objectAtIndex:i];
            MyCollectionViewCell *cell = [rowArray objectAtIndex:j];
            
            NSInteger cellValue = cell.value;
            
            if( cellValue > 0 ){
                // check game over as well
                NSMutableArray *validMoves = [self getValidTargets:i column:j];
                if(validMoves != nil && [validMoves count] > 0){
                    gameOver = NO;
                }
                
                currentScore = fmax(currentScore, cellValue);
            }
        }
    }
    
    self.currentScoreLabel.label.text = [NSString stringWithFormat:@"%@%ld", CurrentScore, (long)currentScore];
    
    if( gameOver ){
        // Display game over popup
        NSString *scoreStr = [NSString stringWithFormat:@"Score: %ld", (long)currentScore];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over"
                                                        message:scoreStr
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"New Game", nil];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if( buttonIndex == 1 )
        [self newGame];
}

- (void)newGame
{
    if ([self.interstitial isReady]) {
        [self.interstitial presentFromRootViewController:self];
    }
    
    [self.gameboard loadNewGame];
    
    [self.collectionView reloadData];
    
    [self performSelector:@selector(updateScoreNoCheck) withObject:nil afterDelay:0.1];
}

- (void)signInOrOut
{
    [self.leaderboard.button setHidden:(![self.leaderboard.button isHidden])];
}

- (NSMutableArray *)getValidTargets:(NSInteger)row
                             column:(NSInteger)column
{
    NSMutableArray *validTargets = [[NSMutableArray alloc] init];
    
    MyCollectionViewCell *jumpedTile;
    MyCollectionViewCell *landingTile;
    
    // check left directly 2 and right directly 2
    NSMutableArray *rowArray = [self.tiles objectAtIndex:row];
    
    if( column > 1 ){
        // left
        jumpedTile = [rowArray objectAtIndex:(column - 1)];
        landingTile = [rowArray objectAtIndex:(column - 2)];
        
        if( [self isValidJump:jumpedTile destination:landingTile] ){
            CellPair *validPair = [[CellPair alloc] initWithCell:landingTile
                                                           cell2:jumpedTile];
            [validTargets addObject:validPair];
        }
    }
    if( (column + 2) < [self.gameboard getItems] ){
        // right
        jumpedTile = [rowArray objectAtIndex:(column + 1)];
        landingTile = [rowArray objectAtIndex:(column + 2)];
        
        if( [self isValidJump:jumpedTile destination:landingTile] ){
            CellPair *validPair = [[CellPair alloc] initWithCell:landingTile
                                                           cell2:jumpedTile];
            [validTargets addObject:validPair];
        }
    }
    
    // check up directly 2 and down directly 2
    if( row > 1 ){
        // up
        rowArray = [self.tiles objectAtIndex:(row - 1)];
        jumpedTile = [rowArray objectAtIndex:column];
        rowArray = [self.tiles objectAtIndex:(row - 2)];
        landingTile = [rowArray objectAtIndex:column];
        
        if( [self isValidJump:jumpedTile destination:landingTile] ){
            CellPair *validPair = [[CellPair alloc] initWithCell:landingTile
                                                           cell2:jumpedTile];
            [validTargets addObject:validPair];
        }
    }
    if( (row + 2) < [self.gameboard getSections] ){
        // down
        rowArray = [self.tiles objectAtIndex:(row + 1)];
        jumpedTile = [rowArray objectAtIndex:column];
        rowArray = [self.tiles objectAtIndex:(row + 2)];
        landingTile = [rowArray objectAtIndex:column];
        
        if( [self isValidJump:jumpedTile destination:landingTile] ){
            CellPair *validPair = [[CellPair alloc] initWithCell:landingTile
                                                           cell2:jumpedTile];
            [validTargets addObject:validPair];
        }
    }
    
    return validTargets;
}

- (void)highlightValidTargets:(NSIndexPath *)indexPath
                    highlight:(Boolean)highlight
{
    NSInteger row = [indexPath section] - _headerSections;
    NSInteger column = [indexPath item];
    
    NSMutableArray *validTargets = [self getValidTargets:row column:column];
    for( CellPair *validTarget in validTargets ){
        MyCollectionViewCell *landing = (MyCollectionViewCell *)validTarget.landingCell;
        [landing highlight:highlight];
    }
}

-(Boolean) isValidJump:(MyCollectionViewCell *)jumpedTile
           destination:(MyCollectionViewCell *)landingTile
{
    if( jumpedTile == nil || landingTile == nil ){
        return NO;
    }
    
    if( jumpedTile.value <= 0 ){
        return NO;
    }
    if( landingTile.value > 0 ){
        return NO;
    }
    
    return YES;
}

#pragma mark UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.gameboard getSections] + _headerSections + _footerSections;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section
{
    if(section == 0){
        // banner ad
        return 1;
    }
    else if(section == 1){
        // header
        return 3;
    }
    else if(section >= ([self.gameboard getSections] + _headerSections) ){
        // footer
        return 3;
    }
    
    return [self.gameboard getItems];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *specialtyCell = [self getSpecialCell:collectionView
                                        cellForItemAtIndexPath:indexPath];
    if( specialtyCell != nil ){
        return specialtyCell;
    }
    
    MyCollectionViewCell *myCell = [collectionView
                                    dequeueReusableCellWithReuseIdentifier:CellIdentifier
                                    forIndexPath:indexPath];
    
    NSInteger row = [indexPath section] - _headerSections;
    NSInteger column = [indexPath item];
    
    NSMutableArray *rowArray = [self.tiles objectAtIndex:row];
    [rowArray insertObject:myCell atIndex:column];
    
    //NSString *value = [self.gameboard getValueAt:row column:column];
    NSInteger value = [self.gameboard getIntValueAt:row column:column];
    
    [myCell setLabel:value];
    
    return myCell;
}

-(UICollectionViewCell *)getSpecialCell:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = [indexPath section];
    NSInteger item = [indexPath item];
    
    UICollectionViewCell *cell = nil;
    if( section == 0 ){
        /*if( _bannerAdCell != nil ){
            cell = _bannerAdCell;
        }
        else{*/
            MyBannerCell *bannerCell = [collectionView
                                        dequeueReusableCellWithReuseIdentifier:BannerIdentifier
                                        forIndexPath:indexPath];
            
            
            bannerCell.bannerAd.adUnitID = BannerAdId;
            bannerCell.bannerAd.rootViewController = self;
            [bannerCell.bannerAd loadRequest:[GADRequest request]];
            
            _bannerAdCell = bannerCell;
            cell = bannerCell;
        //}
    }
    if( section == 1 ){
        if(item == 0){
            if( _leaderboard != nil ){
                cell = _leaderboard;
            }
            else{
                MyButtonCell *buttonCell = [collectionView
                                            dequeueReusableCellWithReuseIdentifier:ButtonIdentifier
                                            forIndexPath:indexPath];
                
                [buttonCell setLabel:@"Leaderboard"
                           backColor:[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0]
                           textColor:[UIColor colorWithWhite:1.0 alpha:1.0]
                             rounded:NO];
                
                cell = buttonCell;
                self.leaderboard = buttonCell;
                
                [buttonCell.button setHidden:YES];
            }
        }
        else if(item == 2){
            if( _signInOut != nil ){
                cell = _signInOut;
            }
            else{
                MyButtonCell *buttonCell = [collectionView
                                            dequeueReusableCellWithReuseIdentifier:ButtonIdentifier
                                            forIndexPath:indexPath];
                
                [buttonCell setLabel:@"Sign In"
                           backColor:[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0]
                           textColor:[UIColor colorWithWhite:1.0 alpha:1.0]
                             rounded:NO];
                
                cell = buttonCell;
                self.signInOut = buttonCell;
                [buttonCell.button addTarget:self
                                     action:@selector(signInOrOut)
                           forControlEvents:UIControlEventTouchUpInside];
            }
        }
        else if(item == 1){
            if( _currentScoreLabel != nil ){
                cell = _currentScoreLabel;
            }
            else{
                MyLabelCell *labelCell = [collectionView
                                          dequeueReusableCellWithReuseIdentifier:LabelIdentifier
                                          forIndexPath:indexPath];
                
                [labelCell setLabel:CurrentScore
                          textColor:[UIColor colorWithRed:1.0 green:0.5 blue:0.0 alpha:1.0]];
                
                cell = labelCell;
                self.currentScoreLabel = labelCell;
            }
        }
    }
    if( section >= ([self.gameboard getSections] + _headerSections) ){
        if(item == 0){
            if( _howTo != nil ){
                cell = _howTo;
            }
            else{
                MyButtonCell *buttonCell = [collectionView
                                            dequeueReusableCellWithReuseIdentifier:ButtonIdentifier
                                            forIndexPath:indexPath];
                
                [buttonCell setLabel:@"How To"
                           backColor:[UIColor colorWithRed:0.5 green:0.0 blue:0.8 alpha:1.0]
                           textColor:[UIColor colorWithRed:0.1 green:1.0 blue:0.2 alpha:1.0]
                             rounded:NO];
                
                cell = buttonCell;
                self.howTo = buttonCell;
            }
        }
        else if(item == 2){
            if( _restartGame != nil ){
                cell = _restartGame;
            }
            else{
                MyButtonCell *buttonCell = [collectionView
                                            dequeueReusableCellWithReuseIdentifier:ButtonIdentifier
                                            forIndexPath:indexPath];
                
                [buttonCell setLabel:@"New Game"
                           backColor:[UIColor colorWithRed:0.1 green:1.0 blue:0.2 alpha:1.0]
                           textColor:[UIColor colorWithRed:0.5 green:0.0 blue:0.8 alpha:1.0]
                             rounded:NO];
                
                cell = buttonCell;
                self.restartGame = buttonCell;
                [buttonCell.button addTarget:self
                                      action:@selector(newGame)
                            forControlEvents:UIControlEventTouchUpInside];
            }
        }
        else if(item == 1){
            if( _highScoreLabel != nil ){
                cell = _highScoreLabel;
            }
            else{
                MyLabelCell *labelCell = [collectionView
                                          dequeueReusableCellWithReuseIdentifier:LabelIdentifier
                                          forIndexPath:indexPath];
                
                [labelCell setLabel:HighScore
                          textColor:[UIColor colorWithRed:0.9 green:0.5 blue:0.0 alpha:1.0]];
                
                cell = labelCell;
                self.highScoreLabel = labelCell;
            }
        }
    }
    
    return cell;
}

@end