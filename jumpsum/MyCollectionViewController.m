//
//  MyCollectionViewController.m
//  jumpsum
//
//  Created by Tyler Cap on 2/5/15.
//  Copyright (c) 2015 Tyler Cap. All rights reserved.
//

#import "MyCollectionViewController.h"

static NSString * const CellIdentifier = @"TileCell";
static NSString * const ButtonIdentifier = @"ButtonCell";

@implementation MyCollectionViewController

- (Gameboard *)gameboard
{
    if (_gameboard != nil) {
        return _gameboard;
    }
    _gameboard = [[Gameboard alloc] init];
    [_gameboard loadFromSandbox];
    return _gameboard;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*
    if (self.gameboard != nil) {
        for( int i=0; i<self.gameboard.getSections; i++ ){
            for( int j=0; j<self.gameboard.getItems; j++ ){
                [buttons[i][j] setTitle: [self.gameboard getValueAt:i column:j]
                               forState: UIControlStateNormal];
            }
        }
    }
     */
    
    /*
    [self.collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:CellIdentifier];
    
    [self.collectionView registerClass:[UICollectionReusableView class]
            forSupplementaryViewOfKind: UICollectionElementKindSectionHeader
                   withReuseIdentifier:HeaderIdentifier];
    [self.collectionView registerClass:[UICollectionReusableView class]
            forSupplementaryViewOfKind: UICollectionElementKindSectionFooter
                   withReuseIdentifier:FooterIdentifier];
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.gameboard getSections] + 2; // pseudo header and footer
}

-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section
{
    if(section == 0){
        // header
        return 1;
    }
    else if(section > [self.gameboard getSections]){
        // footer
        return 2;
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
    
    NSInteger section = [indexPath section];
    NSInteger item = [indexPath item];
    
    NSString *value = [self.gameboard getValueAt:section column:item];
    
    [myCell setLabel:value];
    
    return myCell;
}

-(UICollectionViewCell *)getSpecialCell:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = [indexPath section];
    NSInteger item = [indexPath item];
    
    if( section == 0 ){
        MyButtonCell *buttonCell = [collectionView
         dequeueReusableCellWithReuseIdentifier:ButtonIdentifier
         forIndexPath:indexPath];
        
        [buttonCell setLabel:@"Sign In"];
        
        return buttonCell;
    }
    if( section > [self.gameboard getSections] ){
        MyButtonCell *buttonCell = [collectionView
                                    dequeueReusableCellWithReuseIdentifier:ButtonIdentifier
                                    forIndexPath:indexPath];
        
        if(item == 0){
            [buttonCell setLabel:@"How To"];
        }
        else if(item == 1){
            [buttonCell setLabel:@"New Game"];
        }
        
        return buttonCell;
    }
    
    return nil;
}

@end
