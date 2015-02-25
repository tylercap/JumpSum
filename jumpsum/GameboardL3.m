//
//  GameboardL3.m
//  jumpsum
//
//  Created by Tyler Cap on 2/12/15.
//  Copyright (c) 2015 Tyler Cap. All rights reserved.
//

#import "GameboardL3.h"

static NSString * const Sandbox = @"GameboardL3.plist";
static NSString * const HSSandbox = @"HighScoreL3.txt";

@implementation GameboardL3

-(NSInteger)getSections
{
    return 7;
}

-(NSInteger)getItems
{
    return 6;
}

-(void)loadNewGame
{
    NSMutableArray *values= [[NSMutableArray alloc]init];
    // randomly fill an array with 12 1, 2, and 3s; 4 5s; 1 8; and 1 -1 for our values
    for( int i=1; i<4; i++ ){
        for( int j=0; j<12; j++ ){
            [values addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    [values addObject:@"-1"];
    [values addObject:@"8"];
    for( int j=0; j<4; j++ ){
        [values addObject:@"5"];
    }
    
    int remaining = 42;
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
    return @"CgkItMu16qgJEAIQFQ";
}

- (NSString *)getOver60Id
{
    return @"CgkItMu16qgJEAIQGg";
}

- (NSString *)getOver80Id
{
    return @"CgkItMu16qgJEAIQGw";
}

- (NSString *)getOver90Id
{
    return @"CgkItMu16qgJEAIQHA";
}

- (NSString *)getPerfectId
{
    return @"CgkItMu16qgJEAIQKQ";
}

@end
