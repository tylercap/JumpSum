//
//  Gameboard.h
//  jumpsum
//
//  Created by Tyler Cap on 2/3/15.
//  Copyright (c) 2015 Tyler Cap. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GooglePlayGames/GooglePlayGames.h>

extern int values[8][7];
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

// for google play games
- (void)updateAchievements:(NSInteger)score;

- (NSString *)get5times90Id;
- (NSString *)get20times90Id;
- (NSString *)get5times100Id;
- (NSString *)get100times95Id;
- (NSString *)get20times100Id;
- (NSString *)get10000gamesId;
- (NSString *)get10000pointsId;

- (NSString *)getLeaderboardId;
- (NSString *)getOver60Id;
- (NSString *)getOver80Id;
- (NSString *)getOver90Id;
- (NSString *)getPerfectId;

@end
