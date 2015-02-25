//
//  GameboardL9.m
//  jumpsum
//
//  Created by Tyler Cap on 2/12/15.
//  Copyright (c) 2015 Tyler Cap. All rights reserved.
//

#import "GameboardL9.h"

static NSString * const Sandbox = @"GameboardL9.plist";
static NSString * const HSSandbox = @"HighScoreL9.txt";

@implementation GameboardL9

-(NSInteger)getSections
{
    return 7;
}

-(NSInteger)getItems
{
    return 7;
}

-(void)loadNewGame
{
    NSMutableArray *values= [[NSMutableArray alloc]init];
    // randomly fill an array with 8 2's, 8 3's, 8 4's, 1 8 and 2 10's for our values
    for( int i=2; i<5; i++ ){
        for( int j=0; j<8; j++ ){
            [values addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    [values addObject:@"-1"];
    [values addObject:@"8"];
    for( int j=0; j<2; j++ ){
        [values addObject:@"10"];
    }
    
    int remaining = 28;
    NSMutableArray* array = [[NSMutableArray alloc] init];
    for( int i=0; i<[self getSections]; i++ ){
        NSMutableArray* row = [[NSMutableArray alloc] init];
        [array addObject:row];
        
        for( int j=0; j<[self getItems]; j++ ){
            if( i > j )
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
    return @"CgkItMu16qgJEAIQLw";
}

- (NSString *)getOver60Id
{
    return @"CgkItMu16qgJEAIQNA";
}

- (NSString *)getOver80Id
{
    return @"CgkItMu16qgJEAIQNQ";
}

- (NSString *)getOver90Id
{
    return @"CgkItMu16qgJEAIQNg";
}

- (NSString *)getPerfectId
{
    return @"CgkItMu16qgJEAIQOw";
}

@end
