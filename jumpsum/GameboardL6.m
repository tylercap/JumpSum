//
//  GameboardL6.m
//  jumpsum
//
//  Created by Tyler Cap on 2/12/15.
//  Copyright (c) 2015 Tyler Cap. All rights reserved.
//

#import "GameboardL6.h"

static NSString * const Sandbox = @"GameboardL6.plist";
static NSString * const HSSandbox = @"HighScoreL6.txt";

@implementation GameboardL6

-(NSInteger)getSections
{
    return 8;
}

-(NSInteger)getItems
{
    return 7;
}

-(void)loadNewGame
{
    NSMutableArray *values= [[NSMutableArray alloc]init];
    // randomly fill an array with 25 1's, 15 2's, and 15 3's for our values
    for( int j=0; j<25; j++ ){
        [values addObject:@"1"];
    }
    for( int i=2; i<4; i++ ){
        for( int j=0; j<15; j++ ){
            [values addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    [values addObject:@"-1"];
    
    int remaining = 56;
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
    return @"CgkItMu16qgJEAIQGA";
}

- (NSString *)getOver60Id
{
    return @"CgkItMu16qgJEAIQIw";
}

- (NSString *)getOver80Id
{
    return @"CgkItMu16qgJEAIQJA";
}

- (NSString *)getOver90Id
{
    return @"CgkItMu16qgJEAIQJQ";
}

- (NSString *)getPerfectId
{
    return @"CgkItMu16qgJEAIQLA";
}

@end
