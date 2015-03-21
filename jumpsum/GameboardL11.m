//
//  GameboardL11.m
//  jumpsum
//
//  Created by Tyler Cap on 2/12/15.
//  Copyright (c) 2015 Tyler Cap. All rights reserved.
//

#import "GameboardL11.h"

static NSString * const Sandbox = @"GameboardL11.plist";
static NSString * const HSSandbox = @"HighScoreL11.txt";

@implementation GameboardL11

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
    // randomly fill an array with 7 1's, 2's, 3's, and 4's; and 3 10's for our values
    for( int j=0; j<3; j++ ){
        [values addObject:@"10"];
    }
    for( int i=1; i<5; i++ ){
        for( int j=0; j<7; j++ ){
            [values addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    [values addObject:@"-1"];
    
    int remaining = 32;
    NSMutableArray* array = [[NSMutableArray alloc] init];
    for( int i=0; i<[self getSections]; i++ ){
        NSMutableArray* row = [[NSMutableArray alloc] init];
        [array addObject:row];
        
        for( int j=0; j<[self getItems]; j++ ){
            if( ( ( i == 0 || i == 7 ) && j != 3 ) ||
                ( ( i == 1 || i == 6 ) && ( j < 2 || j > 4 ) )||
                ( ( i == 2 || i == 5 ) && ( j == 0 || j == 6 ) ) )
            {
                [row addObject:@"-2"];
            }
            else
            {
                NSUInteger index = arc4random_uniform(remaining);
                [row addObject:[values objectAtIndex:index]];
                
                [values removeObjectAtIndex:index];
                remaining--;
            }
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
    return @"CgkItMu16qgJEAIQRA";
}

- (NSString *)getOver60Id
{
    return @"CgkItMu16qgJEAIQQA";
}

- (NSString *)getOver80Id
{
    return @"CgkItMu16qgJEAIQQQ";
}

- (NSString *)getOver90Id
{
    return @"CgkItMu16qgJEAIQQg";
}

- (NSString *)getPerfectId
{
    return @"CgkItMu16qgJEAIQQw";
}

@end