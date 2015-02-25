//
//  GameboardL8.m
//  jumpsum
//
//  Created by Tyler Cap on 2/12/15.
//  Copyright (c) 2015 Tyler Cap. All rights reserved.
//

#import "GameboardL8.h"

static NSString * const Sandbox = @"GameboardL8.plist";
static NSString * const HSSandbox = @"HighScoreL8.txt";

@implementation GameboardL8

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
    // randomly fill an array with 12 1's, 12 2's, 12 3's, and 7 4's for our values
    for( int i=1; i<4; i++ ){
        for( int j=0; j<12; j++ ){
            [values addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    [values addObject:@"-1"];
    for( int j=0; j<7; j++ ){
        [values addObject:@"4"];
    }
    
    int remaining = 44;
    NSMutableArray* array = [[NSMutableArray alloc] init];
    for( int i=0; i<[self getSections]; i++ ){
        NSMutableArray* row = [[NSMutableArray alloc] init];
        [array addObject:row];
        
        for( int j=0; j<[self getItems]; j++ ){
            if( (j == 2 || j == 3) && (i == 3 || i == 4) )
            {
                [row addObject:@"-2"];
            }
            else{
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
    return @"CgkItMu16qgJEAIQLg";
}

- (NSString *)getOver60Id
{
    return @"CgkItMu16qgJEAIQMQ";
}

- (NSString *)getOver80Id
{
    return @"CgkItMu16qgJEAIQMg";
}

- (NSString *)getOver90Id
{
    return @"CgkItMu16qgJEAIQMw";
}

- (NSString *)getPerfectId
{
    return @"CgkItMu16qgJEAIQOg";
}

@end
