//
//  Gameboard.h
//  jumpsum
//
//  Created by Tyler Cap on 2/3/15.
//  Copyright (c) 2015 Tyler Cap. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Gameboard : NSObject

@property (nonatomic, strong) NSString *docPath;
@property (nonatomic) NSInteger highScore;

-(NSInteger)getHighScore;
-(Boolean)setHighScoreIfGreater:(NSInteger)highScore;

-(NSInteger)getIntValueAt:(NSInteger)row
                   column:(NSInteger)column;
-(NSString *)getValueAt:(NSInteger)row
                 column:(NSInteger)column;
-(void)setValueAt:(NSInteger)value
              row:(NSInteger)row
           column:(NSInteger)column;
-(NSInteger)getSections; // rows
-(NSInteger)getItems; // columns

-(void)loadFromArray:(NSArray *)gameboard;
-(NSMutableArray *)storeToArray;

-(void)loadNewGame;

- (NSString *)getDocPath;
- (void)saveToSandbox;
- (void)loadFromSandbox;
- (void)saveToSandbox:(NSString *)arrayPath
            extraPath:(NSString *)highScorePath;
- (void)loadFromSandbox:(NSString *)arrayPath
              extraPath:(NSString *)highScorePath;

@end
