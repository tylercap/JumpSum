//
//  GameboardL7.m
//  jumpsum
//
//  Created by Tyler Cap on 2/12/15.
//  Copyright (c) 2015 Tyler Cap. All rights reserved.
//

#import "GameboardL7.h"

static NSString * const Sandbox = @"GameboardL7.plist";
static NSString * const HSSandbox = @"HighScoreL7.txt";

@implementation GameboardL7

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
    // randomly fill an array with 6 1's, 6 2's, 6 3's, 6 4's, 2 5's and 3 10's for our values
    for( int i=1; i<5; i++ ){
        for( int j=0; j<6; j++ ){
            [values addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    [values addObject:@"-1"];
    [values addObject:@"5"];
    [values addObject:@"5"];
    for( int j=0; j<3; j++ ){
        [values addObject:@"10"];
    }
    
    int remaining = 30;
    NSMutableArray* array = [[NSMutableArray alloc] init];
    for( int i=0; i<[self getSections]; i++ ){
        NSMutableArray* row = [[NSMutableArray alloc] init];
        [array addObject:row];
        
        for( int j=0; j<[self getItems]; j++ ){
            if( ( j < 2 && i < 3 ) ||
               ( j == 2 && ( i < 2 || i == 7 ) ) ||
               ( j == 3 && ( i == 0 || i > 5 ) ) ||
               ( j > 3 && i > 4 ) )
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
    return @"CgkItMu16qgJEAIQGQ";
}

- (NSString *)getOver60Id
{
    return @"CgkItMu16qgJEAIQJg";
}

- (NSString *)getOver80Id
{
    return @"CgkItMu16qgJEAIQJw";
}

- (NSString *)getOver90Id
{
    return @"CgkItMu16qgJEAIQKA";
}

- (NSString *)getPerfectId
{
    return @"CgkItMu16qgJEAIQLQ";
}

@end
