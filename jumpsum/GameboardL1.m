//
//  GameboardL1.m
//  jumpsum
//
//  Created by Tyler Cap on 2/12/15.
//  Copyright (c) 2015 Tyler Cap. All rights reserved.
//

#import "GameboardL1.h"

int values[7][5];
static NSString * const Sandbox = @"GameboardL1.plist";

@implementation GameboardL1

-(NSInteger)getSections
{
    return 7;
}

-(NSInteger)getItems
{
    return 5;
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

-(NSInteger)getIntValueAt:(NSInteger)row
                   column:(NSInteger)column
{
    return values[row][column];
}

-(void)setValueAt:(NSInteger)value
              row:(NSInteger)row
           column:(NSInteger)column
{
    values[row][column] = (int)value;
}

- (void)loadFromSandbox
{
    if( _dataPath == nil ){
        _dataPath = [[self getDocPath] stringByAppendingPathComponent:Sandbox];
    }
    
    [self loadFromSandbox:_dataPath];
}

- (void)saveToSandbox
{
    if( _dataPath == nil ){
        _dataPath = [[self getDocPath] stringByAppendingPathComponent:Sandbox];
    }
    
    [self saveToSandbox:_dataPath];
}

@end
