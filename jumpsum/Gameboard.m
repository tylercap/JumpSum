//
//  Gameboard.m
//  jumpsum
//
//  Created by Tyler Cap on 2/3/15.
//  Copyright (c) 2015 Tyler Cap. All rights reserved.
//

#import "Gameboard.h"

int values[7][5];
@implementation Gameboard

- (id)initFromArray:(NSArray *)gameboard
{
    self = [super init];
    [self loadFromArray:gameboard];
    
    return self;
}

-(NSString *)getValueAt:(NSInteger)row
                 column:(NSInteger)column
{
    int val = values[row][column];
    return [NSString stringWithFormat:@"%d",val];
}

-(NSInteger)getSections
{
    return 7;
}


-(NSInteger)getItems
{
    return 5;
}

-(void)loadFromArray:(NSArray *)gameboard
{
    for( int i=0; i<gameboard.count; i++ ){
        NSArray *row = gameboard[i];
        
        for( int j=0; j<row.count; j++ ){
            values[i][j] = (int)[row[j] integerValue];
        }
    }
}

-(NSMutableArray *)storeToArray
{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    for( int i=0; i<7; i++ ){
        NSMutableArray* row = [[NSMutableArray alloc] init];
        [array addObject:row];
        
        for( int j=0; j<5; j++ ){
            [row addObject:[NSString stringWithFormat:@"%d",values[i][j]]];
        }
    }
    
    return array;
}

-(void)loadNewGame
{
    NSMutableArray *values= [[NSMutableArray alloc]init];
    // randomly fill an array with 10 1, 2, and 3s; 4 10s; and 1 -1 for our values
    for( int i=1; i<4; i++ ){
        for( int j=0; j<10; j++ ){
            [values addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    [values addObject:@"-1"];
    for( int j=0; j<4; j++ ){
        [values addObject:@"10"];
    }
    
    int remaining = 35;
    NSMutableArray* array = [[NSMutableArray alloc] init];
    for( int i=0; i<7; i++ ){
        NSMutableArray* row = [[NSMutableArray alloc] init];
        [array addObject:row];
        
        for( int j=0; j<5; j++ ){
            NSUInteger index = arc4random_uniform(remaining);
            [row addObject:[values objectAtIndex:index]];
            
            [values removeObjectAtIndex:index];
            remaining--;
        }
    }
    
    [self loadFromArray:array];
}

- (void)loadFromSandbox
{
    NSArray *array = [NSArray arrayWithContentsOfFile:@"GAMEBOARD"];
    
    if (array != nil || [array count] > 0) {
        [self loadFromArray:array];
    }
    else{
        [self loadNewGame];
    }
}

- (void)saveToSandbox
{
    NSMutableArray *array = [self storeToArray];
    
    [array writeToFile:@"GAMEBOARD" atomically:YES];
}


@end
