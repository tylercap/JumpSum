//
//  GameboardL5.m
//  jumpsum
//
//  Created by Tyler Cap on 2/12/15.
//  Copyright (c) 2015 Tyler Cap. All rights reserved.
//

#import "GameboardL5.h"

static NSString * const Sandbox = @"GameboardL5.plist";
static NSString * const HSSandbox = @"HighScoreL5.txt";

@implementation GameboardL5

-(NSInteger)getSections
{
    return 8;
}

-(NSInteger)getItems
{
    return 6;
}

-(void)loadNewGame
{
    NSMutableArray *values= [[NSMutableArray alloc]init];
    // randomly fill an array with 20 1's, 12 2's, 12 3's, 2 5's and 1 10 for our values
    for( int j=0; j<20; j++ ){
        [values addObject:@"1"];
    }
    for( int i=2; i<4; i++ ){
        for( int j=0; j<12; j++ ){
            [values addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    [values addObject:@"-1"];
    [values addObject:@"10"];
    for( int j=0; j<2; j++ ){
        [values addObject:@"5"];
    }
    
    int remaining = 48;
    NSMutableArray* array = [[NSMutableArray alloc] init];
    for( int i=0; i<[self getSections]; i++ ){
        NSMutableArray* row = [[NSMutableArray alloc] init];
        [array addObject:row];
        
        for( int j=0; j<[self getItems]; j++ ){
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
    if( _arrayPath == nil  || _highScorePath == nil ){
        _arrayPath = [[self getDocPath] stringByAppendingPathComponent:Sandbox];
        _highScorePath = [[self getDocPath] stringByAppendingPathComponent:HSSandbox];
    }
    
    [self loadFromSandbox:_arrayPath extraPath:_highScorePath];
}

- (void)saveToSandbox
{
    if( _arrayPath == nil  || _highScorePath == nil ){
        _arrayPath = [[self getDocPath] stringByAppendingPathComponent:Sandbox];
        _highScorePath = [[self getDocPath] stringByAppendingPathComponent:HSSandbox];
    }
    
    [self saveToSandbox:_arrayPath extraPath:_highScorePath];
}

// google play games

- (NSString *)getLeaderboardId
{
    return @"CgkItMu16qgJEAIQFw";
}

- (NSString *)getOver60Id
{
    return @"CgkItMu16qgJEAIQIA";
}

- (NSString *)getOver80Id
{
    return @"CgkItMu16qgJEAIQIQ";
}

- (NSString *)getOver90Id
{
    return @"CgkItMu16qgJEAIQIg";
}

- (NSString *)getPerfectId
{
    return @"CgkItMu16qgJEAIQKw";
}

@end
