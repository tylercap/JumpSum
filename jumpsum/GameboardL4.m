//
//  GameboardL4.m
//  jumpsum
//
//  Created by Tyler Cap on 2/12/15.
//  Copyright (c) 2015 Tyler Cap. All rights reserved.
//

#import "GameboardL4.h"

static NSString * const Sandbox = @"GameboardL4.plist";
static NSString * const HSSandbox = @"HighScoreL4.txt";

@implementation GameboardL4

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
    // randomly fill an array with 9 1's, 9 2's, 9 3's, 2 7's, and 4 8's for our values
    for( int i=1; i<4; i++ ){
        for( int j=0; j<9; j++ ){
            [values addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    [values addObject:@"-1"];
    for( int j=0; j<2; j++ ){
        [values addObject:@"7"];
    }
    for( int j=0; j<4; j++ ){
        [values addObject:@"8"];
    }
    
    int remaining = 34;
    NSMutableArray* array = [[NSMutableArray alloc] init];
    for( int i=0; i<[self getSections]; i++ ){
        NSMutableArray* row = [[NSMutableArray alloc] init];
        [array addObject:row];
        
        for( int j=0; j<[self getItems]; j++ ){
            if( ((j == 0 || j == 5) && i > 1 && i < 5) ||
                ((j == 1 || j == 4) && i == 3) )
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
    return @"CgkItMu16qgJEAIQFg";
}

- (NSString *)getOver60Id
{
    return @"CgkItMu16qgJEAIQHQ";
}

- (NSString *)getOver80Id
{
    return @"CgkItMu16qgJEAIQHg";
}

- (NSString *)getOver90Id
{
    return @"CgkItMu16qgJEAIQHw";
}

- (NSString *)getPerfectId
{
    return @"CgkItMu16qgJEAIQKg";
}

@end
