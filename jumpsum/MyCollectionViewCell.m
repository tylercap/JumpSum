//
//  MyCollectionViewCell.m
//  jumpsum
//
//  Created by Tyler Cap on 2/5/15.
//  Copyright (c) 2015 Tyler Cap. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        //self.backgroundColor = _normalBack;
    }
    
    return self;
}

- (void)setLabel:(NSInteger)value
{
    self.value = value;

    if( value > 0 ){
        NSString *text = [NSString stringWithFormat:@"%ld",(long)value];
        self.title.text = text;
    }
    else{
        self.title.text = @"";
    }
    
    self.layer.borderColor = [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0].CGColor;
    self.layer.borderWidth = 1.0;
    self.layer.cornerRadius = 6.0f;
    self.layer.masksToBounds = YES;
}

- (void)highlight:(Boolean)highlight
{
    if( _normalBack == nil ){
        _normalBack = [UIColor colorWithRed:0.9 green:0.5 blue:0.0 alpha:1.0];
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
    MyCollectionViewController *mcvc = (MyCollectionViewController *)self.window.rootViewController;
    [mcvc highlightValidTargets:indexPath highlight:highlight];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.superview bringSubviewToFront:self];
    
    self.originalPosition = self.center;
    UITouch *touch = [touches anyObject];
    CGPoint position = [touch locationInView: self.superview];
    
    self.touchOffset = CGPointMake(self.center.x - position.x,self.center.y - position.y);
    
    [self highlightValidTargets:YES];
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
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

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //CGPoint positionInView = [touch locationInView:self.view];
    CGPoint newPosition;
    /*if (CGRectContainsPoint(_desiredView.frame, positionInView)) {
        newPosition = positionInView;
        // _desiredView is view where the user can drag the view
    } else {*/
        newPosition = self.originalPosition;
        // its outside the desired view so lets move the view back to start position
    //}
    
    [UIView animateWithDuration:0.4
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^ {
                         self.center = newPosition;
                     }
                     completion:^(BOOL finished) {}];
    
    [self highlightValidTargets:NO];
}

-(void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:0.4
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^ {
                         self.center = self.originalPosition;
                     }
                     completion:^(BOOL finished) {}];
    
    [self highlightValidTargets:NO];
}


@end