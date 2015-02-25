//
//  GameboardL2.m
//  jumpsum
//
//  Created by Tyler Cap on 2/12/15.
//  Copyright (c) 2015 Tyler Cap. All rights reserved.
//

#import "GameboardL2.h"

static NSString * const Sandbox = @"GameboardL2.plist";
static NSString * const HSSandbox = @"HighScoreL2.txt";

@implementation GameboardL2

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
    for( int i=0; i<[self getSections]; i++ ){
        NSMutableArray* row = [[NSMutableArray alloc] init];
        [array addObject:row];
        
        for( int j=0; j<[self getItems]; j++ ){
            if( (i % 2 == 0 && j == 5) ||
                (i % 2 == 1 && j == 0) )
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
    return @"CgkItMu16qgJEAIQDg";
}

- (NSString *)getOver60Id
{
    return @"CgkItMu16qgJEAIQDw";
}

- (NSString *)getOver80Id
{
    return @"CgkItMu16qgJEAIQEA";
}

- (NSString *)getOver90Id
{
    return @"CgkItMu16qgJEAIQEQ";
}

- (NSString *)getPerfectId
{
    return @"CgkItMu16qgJEAIQEg";
}

@end
