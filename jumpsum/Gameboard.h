//
//  Gameboard.h
//  jumpsum
//
//  Created by Tyler Cap on 2/3/15.
//  Copyright (c) 2015 Tyler Cap. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Gameboard : NSObject

extern int values[7][5];

- (id)initFromArray:(NSArray *)gameboard;

-(NSString *)getValueAt:(NSInteger)row
                 column:(NSInteger)column;

-(void)loadFromArray:(NSArray *)gameboard;

-(NSMutableArray *)storeToArray;

-(void)loadNewGame;

- (void)saveToSandbox;

- (void)loadFromSandbox;


@end
