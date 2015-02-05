//
//  MyCollectionViewController.m
//  jumpsum
//
//  Created by Tyler Cap on 2/5/15.
//  Copyright (c) 2015 Tyler Cap. All rights reserved.
//

#import "MyCollectionViewController.h"

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
        for( int i=0; i<7; i++ ){
            for( int j=0; j<5; j++ ){
                /*UIButton *button = buttons[i][j];
                
                [button setTitle: [self.gameboard getValueAt:i column:j]
                        forState: UIControlStateNormal];*/
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 7;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell *myCell = [collectionView
                                    dequeueReusableCellWithReuseIdentifier:@"TileCell"
                                    forIndexPath:indexPath];
    
    NSInteger row = [indexPath section];
    NSInteger column = [indexPath row];
    
    NSString *value = [self.gameboard getValueAt:row column:column];
    
    myCell.tileLabel.text = value;
    
    return myCell;
}

@end
