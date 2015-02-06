//
//  MyCollectionViewController.m
//  jumpsum
//
//  Created by Tyler Cap on 2/5/15.
//  Copyright (c) 2015 Tyler Cap. All rights reserved.
//

#import "MyCollectionViewController.h"

static NSString * const CellIdentifier = @"TileCell";

@implementation MyCollectionViewController

- (Gameboard *)gameboard
{
    if (_gameboard != nil) {
        return _gameboard;
    }
    _gameboard = [[Gameboard alloc] init];
    [_gameboard loadFromSandbox];
    //[self fillButtonArray];
    return _gameboard;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.gameboard != nil) {
        for( int i=0; i<self.gameboard.getSections; i++ ){
            for( int j=0; j<self.gameboard.getItems; j++ ){
                /*UIButton *button = buttons[i][j];
                
                [button setTitle: [self.gameboard getValueAt:i column:j]
                        forState: UIControlStateNormal];*/
            }
        }
    }
    
    //[self.collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:CellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.gameboard getSections];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section
{
    return [self.gameboard getItems];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell *myCell = [collectionView
                                    dequeueReusableCellWithReuseIdentifier:CellIdentifier
                                    forIndexPath:indexPath];
    
    NSInteger section = [indexPath section];
    NSInteger item = [indexPath item];
    
    NSString *value = [self.gameboard getValueAt:section column:item];
    
    [myCell setLabel:value];
    
    return myCell;
}

@end
