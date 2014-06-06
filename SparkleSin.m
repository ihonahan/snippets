//
//  SparkleSin.m
//  wofa
//
//  Created by Ihonahan Buitrago on 23/10/13.
//  Copyright (c) 2013 ByYuto. All rights reserved.
//

#import "SparkleSin.h"


@interface SparkleSin()

@property(assign) CGFloat totalLifetime;

- (void)setupViewInPosition:(CGPoint)newPos withSuperview:(UIView *)parentView andDelegate:(id<SparkleSinDelegate>)newDel;
- (void)animAndDie;

@end

@implementation SparkleSin

@synthesize sparkleImage;
@synthesize delegate;
@synthesize totalLifetime;


+ (SparkleSin *)initSparkleSinInPosition:(CGPoint)newPos withSuperview:(UIView *)parentView andDelegate:(id<SparkleSinDelegate>)newDel
{
    NSString *nibName = nil;
    if (IS_IPAD) {
        nibName = @"SparkleSin_ipad";
    } else {
        nibName = @"SparkleSin";
    }
    
    NSArray *xibsArray = [[NSBundle mainBundle] loadNibNamed:@"SparkleSin" owner:nil options:nil];
    if (xibsArray && xibsArray.count) {
        SparkleSin *view = [xibsArray objectAtIndex:0];
        
        [view setupViewInPosition:newPos withSuperview:parentView andDelegate:newDel];
        
        return view;
    }
    
    return nil;
}


- (void)setupViewInPosition:(CGPoint)newPos withSuperview:(UIView *)parentView andDelegate:(id<SparkleSinDelegate>)newDel
{
    self.delegate = newDel;
    [parentView addSubview:self];
    CGFloat x = newPos.x - (self.frame.size.width / 2.0);
    CGFloat y = newPos.y - (self.frame.size.height / 2.0);
    self.frame = CGRectMake(x, y, self.frame.size.width, self.frame.size.height);
    self.alpha = 0;
    self.totalLifetime = 4;
    
    [self animAndDie];
}

- (void)animAndDie
{
    [UIView animateWithDuration:(self.totalLifetime / 2.0)
                          delay:0
                        options:(UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionCurveEaseIn)
                     animations:^{
                         self.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:(self.totalLifetime / 2.0)
                                               delay:0
                                             options:(UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionCurveEaseOut)
                                          animations:^{
                                              self.alpha = 0;
                                          }
                                          completion:^(BOOL finished) {
                                              [self removeFromSuperview];
                                              if (self.delegate) {
                                                  if ([self.delegate respondsToSelector:@selector(sparkleSinDie:)]) {
                                                      [self.delegate sparkleSinDie:self];
                                                  }
                                              }
                                          }];
                     }];
}


@end
