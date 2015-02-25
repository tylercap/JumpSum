//
//  GameboardL10.m
//  jumpsum
//
//  Created by Tyler Cap on 2/12/15.
//  Copyright (c) 2015 Tyler Cap. All rights reserved.
//

#import "GameboardL10.h"

static NSString * const Sandbox = @"GameboardL10.plist";
static NSString * const HSSandbox = @"HighScoreL10.txt";

@implementation GameboardL10

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
    // randomly fill an array with 12 1's, 12 2's, 12 3's, and 4 7's for our values
    for( int i=1; i<4; i++ ){
        for( int j=0; j<12; j++ ){
            [values addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    [values addObject:@"-1"];
    for( int j=0; j<4; j++ ){
        [values addObject:@"7"];
    }
    
    int remaining = 41;
    NSMutableArray* array = [[NSMutableArray alloc] init];
    for( int i=0; i<[self getSections]; i++ ){
        NSMutableArray* row = [[NSMutableArray alloc] init];
        [array addObject:row];
        
        for( int j=0; j<[self getItems]; j++ ){
            if( ((j < 2 || j > 4) && (i == 3)) ||
                ((i < 2 || i > 4) && (j == 3)) )
            {
                [row addObject:@"-2"];
            }
            else{
                NSUInteger index = arc4random_uniform(remaining);
                NSString *value = [values objectAtIndex:index];
                
                if( [value isEqualToString:@"-1"] ){
                    Boolean ok_space = NO;
                    if( i == 0 && ( j == 0 || j == 6 ) ){
                        ok_space = YES;
                    }
                    else if( i == 2 && ( j == 0 || j == 6 || j == 2 || j == 4 ) ){
                        ok_space = YES;
                    }
                    else if( i == 4 && ( j == 0 || j == 6 || j == 2 || j == 4 ) ){
                        ok_space = YES;
                    }
                    else if( i == 6 && ( j == 0 || j == 6 ) ){
                        ok_space = YES;
                    }
                    
                    if( ok_space == NO ){
                        // get a new value for this tile and put the -1 back into the list
                        while( [value isEqualToString:@"-1"] ){
                            index = arc4random_uniform(remaining);
                            value = [values objectAtIndex:index];
                        }
                        
                        [row addObject:value];
                        [values removeObjectAtIndex:index];
                    }
                    else{
                        [row addObject:value];
                        [values removeObjectAtIndex:index];
                    }
                }
                else{
                    [row addObject:value];
                    [values removeObjectAtIndex:index];
                }
                
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
    return @"CgkItMu16qgJEAIQMA";
}

- (NSString *)getOver60Id
{
    return @"CgkItMu16qgJEAIQNw";
}

- (NSString *)getOver80Id
{
    return @"CgkItMu16qgJEAIQOA";
}

- (NSString *)getOver90Id
{
    return @"CgkItMu16qgJEAIQOQ";
}

- (NSString *)getPerfectId
{
    return @"CgkItMu16qgJEAIQPA";
}

@end
