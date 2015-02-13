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
static NSString * const HSSandbox = @"HighScoreL1.txt";

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
    return @"CgkItMu16qgJEAIQAQ";
}

- (NSString *)getOver60Id
{
    return @"CgkItMu16qgJEAIQBA";
}

- (NSString *)getOver80Id
{
    return @"CgkItMu16qgJEAIQAw";
}

- (NSString *)getOver90Id
{
    return @"CgkItMu16qgJEAIQAg";
}

- (NSString *)getPerfectId
{
    return @"CgkItMu16qgJEAIQBg";
}

@end
