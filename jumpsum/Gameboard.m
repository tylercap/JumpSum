//
//  Gameboard.m
//  jumpsum
//
//  Created by Tyler Cap on 2/3/15.
//  Copyright (c) 2015 Tyler Cap. All rights reserved.
//

#import "Gameboard.h"

int values[8][7];

@implementation Gameboard

- (id)init
{
    self = [super init];
    
    _docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    self.highScore = 0;
    
    [self loadFromSandbox];
    
    // Specify that our offset is relative to the top of the screen
    [GPGManager sharedInstance].achievementUnlockedToastPlacement = kGPGToastPlacementTop;
    // Specify our offset to be 20 points
    // [GPGManager sharedInstance].achievementUnlockedOffset = 20;
    
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

// google play games

- (void)updateAchievements:(NSInteger)score
{
    GPGScore *submitScore = [[GPGScore alloc] initWithLeaderboardId:[self getLeaderboardId]];
    submitScore.value = score;
    
    [submitScore submitScoreWithCompletionHandler: ^(GPGScoreReport *report, NSError *error) {
        if (error) {
            // Handle the error
        } else {
            // Analyze the report, if you'd like
        }
    }];
    
    [self incrementAchievement:[self get10000gamesId]];
    [self incrementAchievement:[self get10000pointsId] steps:score];
    
    if( score >= 60 ){
        [self unlockAchievement:[self getOver60Id]];
    }
    if( score >= 80 ){
        [self unlockAchievement:[self getOver80Id]];
    }
    if( score >= 90 ){
        [self unlockAchievement:[self getOver90Id]];
        
        [self incrementAchievement:[self get5times90Id]];
        [self incrementAchievement:[self get20times90Id]];
    }
    if( score >= 95 ){
        [self incrementAchievement:[self get100times95Id]];
    }
    if( score == 100 ){
        [self unlockAchievement:[self getPerfectId]];
        
        [self incrementAchievement:[self get5times100Id]];
        [self incrementAchievement:[self get20times100Id]];
    }
}

- (void)unlockAchievement:(NSString *)achievementId
{
    GPGAchievement *unlockMe = [GPGAchievement achievementWithId:achievementId];
    
    [unlockMe unlockAchievementWithCompletionHandler:^(BOOL newlyUnlocked, NSError *error) {
        if (error) {
            // Handle the error
        } else if (!newlyUnlocked) {
            // Achievement was already unlocked
        } else {
            // NSLog(@"Hooray! Achievement unlocked!");
        }
    }];
}

- (void)incrementAchievement:(NSString *)achievementId
{
    [self incrementAchievement:achievementId steps:1];
}

- (void)incrementAchievement:(NSString *)achievementId
                       steps:(NSInteger)numSteps
{
    GPGAchievement *incrementMe = [GPGAchievement achievementWithId:achievementId];
    
    [incrementMe incrementAchievementNumSteps:numSteps
                            completionHandler:^(BOOL newlyUnlocked, int currentSteps, NSError *error) {
                                if (error) {
                                    // Handle the error
                                } else if (newlyUnlocked) {
                                    // NSLog(@"Incremental achievement unlocked!");
                                } else {
                                    // NSLog(@"User has completed %i steps total", currentSteps);
                                }
                            }];
}

- (NSString *)get5times90Id
{
    return @"CgkItMu16qgJEAIQCQ";
}

- (NSString *)get20times90Id
{
    return @"CgkItMu16qgJEAIQBQ";
}

- (NSString *)get5times100Id
{
    return @"CgkItMu16qgJEAIQBw";
}

- (NSString *)get100times95Id
{
    return @"CgkItMu16qgJEAIQCA";
}

- (NSString *)get20times100Id
{
    return @"CgkItMu16qgJEAIQCw";
}

- (NSString *)get10000gamesId
{
    return @"CgkItMu16qgJEAIQCg";
}

- (NSString *)get10000pointsId
{
    return @"CgkItMu16qgJEAIQDQ";
}

// abstract classes

- (NSString *)getLeaderboardId
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (NSString *)getOver60Id
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (NSString *)getOver80Id
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (NSString *)getOver90Id
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (NSString *)getPerfectId
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

@end
