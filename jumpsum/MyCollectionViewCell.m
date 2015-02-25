//
//  MyCollectionViewCell.m
//  jumpsum
//
//  Created by Tyler Cap on 2/5/15.
//  Copyright (c) 2015 Tyler Cap. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell

- (void)setLabel:(NSInteger)value
          parent:(UIViewController *)parent
{
    self.value = value;
    self.parentController = parent;

    if( value > 0 ){
        [self setHidden:NO];
        NSString *text = [NSString stringWithFormat:@"%ld",(long)value];
        self.title.text = text;
    }
    else if( value < -1){
        [self setHidden:YES];
    }
    else{
        [self setHidden:NO];
        self.title.text = @"";
    }
    
    self.backgroundColor = [UIColor colorWithRed:1.0 green:0.5 blue:0.0 alpha:1.0];
    self.layer.borderColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.44 alpha:1.0].CGColor;
    self.layer.borderWidth = 1.2;
    self.layer.cornerRadius = 6.0f;
    self.layer.masksToBounds = YES;
}

- (void)highlight:(Boolean)highlight
{
    if( _normalBack == nil ){
        _normalBack = [UIColor colorWithRed:1.0 green:0.5 blue:0.0 alpha:1.0];
        _highlightBack = [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0];
    }
    
    if(highlight){
        self.backgroundColor = _highlightBack;
    }
    else{
        self.backgroundColor = _normalBack;
    }
}

-(void) highlightValidTargets:(Boolean)highlight
{
    UICollectionView *collectionView = (UICollectionView*)self.superview;
    NSIndexPath *indexPath = [collectionView indexPathForCell:self];
    MyCollectionViewController *mcvc = (MyCollectionViewController *)_parentController;
    [mcvc highlightValidTargets:indexPath highlight:highlight];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    MyCollectionViewController *mcvc = (MyCollectionViewController *)_parentController;
    if( [mcvc canDrag:self] ){
        _moving = YES;
    
        if( _value > 0 ){
            [self.superview bringSubviewToFront:self];
            
            self.originalPosition = self.center;
            UITouch *touch = [touches anyObject];
            CGPoint position = [touch locationInView: self.superview];
            
            self.touchOffset = CGPointMake(self.center.x - position.x,self.center.y - position.y);
            
            [self highlightValidTargets:YES];
        }
    }
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if( _moving && _value > 0 ){
        UITouch *touch = [touches anyObject];
        CGPoint position = [touch locationInView: self.superview];
        
        [UIView animateWithDuration:.001
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^ {
                             
                             self.center = CGPointMake(position.x+_touchOffset.x, position.y+_touchOffset.y);
                         }
                         completion:^(BOOL finished) {}];
    }
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if( _moving && _value > 0 ){
        UITouch *touch = [touches anyObject];
        CGPoint position = [touch locationInView: self.superview];
        
        [self highlightValidTargets:NO];
        
        UICollectionView *collectionView = (UICollectionView*)self.superview;
        NSIndexPath *indexPath = [collectionView indexPathForCell:self];
        MyCollectionViewController *mcvc = (MyCollectionViewController *)_parentController;
        
        if( [mcvc jumpedTile:indexPath landing:position] ){
            self.center = self.originalPosition;
        }
        else{
            [UIView animateWithDuration:0.4
                                  delay:0.0
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^ {
                                 self.center = self.originalPosition;
                             }
                             completion:^(BOOL finished) {}];
        }
    }
    
    MyCollectionViewController *mcvc = (MyCollectionViewController *)_parentController;
    [mcvc finishedDrag:self];
    
    _moving = NO;
}

-(void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    if( _moving ){
        [UIView animateWithDuration:0.4
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^ {
                             self.center = self.originalPosition;
                         }
                         completion:^(BOOL finished) {}];
        
        [self highlightValidTargets:NO];
    }
    
    MyCollectionViewController *mcvc = (MyCollectionViewController *)_parentController;
    [mcvc finishedDrag:self];
    
    _moving = NO;
}


@end