//
//  Gameboard.m
//  jumpsum
//
//  Created by Tyler Cap on 2/3/15.
//  Copyright (c) 2015 Tyler Cap. All rights reserved.
//

#import "Gameboard.h"

@implementation Gameboard

- (id)init
{
    self = [super init];
    
    _docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    self.highScore = 0;
    
    [self loadFromSandbox];
    
    return self;
}

-(NSString *)getDocPath
{
    return self.docPath;
}

-(NSInteger)getHighScore
{
    return self.highScore;
}

-(Boolean)setHighScoreIfGreater:(NSInteger)highScore
{
    if( highScore > self.highScore ){
        self.highScore = highScore;
        return YES;
    }
    
    return NO;
}

-(NSString *)getValueAt:(NSInteger)row
                 column:(NSInteger)column
{
    NSInteger val = [self getIntValueAt:row column:column];
    return [NSString stringWithFormat:@"%ld",(long)val];
}

-(void)loadFromArray:(NSArray *)gameboard
{
    for( int i=0; i<gameboard.count; i++ ){
        NSArray *row = gameboard[i];
        
        for( int j=0; j<row.count; j++ ){
            [self setValueAt:((int)[row[j] integerValue]) row:i column:j];
        }
    }
}

-(NSMutableArray *)storeToArray
{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    for( int i=0; i<[self getSections]; i++ ){
        NSMutableArray* row = [[NSMutableArray alloc] init];
        [array addObject:row];
        
        for( int j=0; j<[self getItems]; j++ ){
            [row addObject:[self getValueAt:i column:j]];
        }
    }
    
    return array;
}

- (void)loadFromSandbox:(NSString *)arrayPath
              extraPath:(NSString *)highScorePath
{
    NSArray *array = [NSArray arrayWithContentsOfFile:arrayPath];
    
    if ( array != nil && [array count] > 0 ) {
        [self loadFromArray:array];
    }
    else{
        [self loadNewGame];
    }
    
    NSString *highScoreStr = [[NSString alloc]initWithContentsOfFile:highScorePath usedEncoding:nil error:nil];
    if( highScoreStr != nil ){
        [self setHighScoreIfGreater:[highScoreStr integerValue]];
    }
}

- (void)saveToSandbox:(NSString *)arrayPath
            extraPath:(NSString *)highScorePath
{
    NSMutableArray *array = [self storeToArray];
    
    [array writeToFile:arrayPath atomically:YES];
    
    NSString *highScoreStr = [NSString stringWithFormat:@"%ld",(long)self.highScore];

    [highScoreStr writeToFile:highScorePath atomically:NO encoding:NSStringEncodingConversionAllowLossy error:nil];
}

-(void)loadFromSandbox
{
    [self doesNotRecognizeSelector:_cmd];
}

-(void)saveToSandbox
{
    [self doesNotRecognizeSelector:_cmd];
}

-(void)loadNewGame
{
    [self doesNotRecognizeSelector:_cmd];
}

-(NSInteger)getIntValueAt:(NSInteger)row
                   column:(NSInteger)column
{
    [self doesNotRecognizeSelector:_cmd];
    return 0;
}

-(void)setValueAt:(NSInteger)value
              row:(NSInteger)row
           column:(NSInteger)column
{
    [self doesNotRecognizeSelector:_cmd];
}

-(NSInteger)getSections
{
    [self doesNotRecognizeSelector:_cmd];
    return 0;
}


-(NSInteger)getItems
{
    [self doesNotRecognizeSelector:_cmd];
    return 0;
}

@end
