//
//  LoadingView.m
//  mundoUne
//
//  Created by Ihonahan Buitrago on 10/15/13.
//  Copyright (c) 2013 Ricardo Hernandez. All rights reserved.
//

#import "LoadingView.h"

@implementation LoadingView

@synthesize loadingView;


- (id)initLoadingViewWithSuperView:(UIView *)supVw
{
    CGRect superRect = supVw.frame;
    
    self = [super initWithFrame:superRect];
    if (self) {
        // Initialization code
        [supVw addSubview:self];
        [supVw sendSubviewToBack:self];
        self.alpha = 0;
        CGFloat x = (superRect.size.width / 2) - 18;
        CGFloat y = (superRect.size.height / 2) - 18;
        CGRect loadRect = CGRectMake(x, y, 37, 37); // Large white activity indicator
        self.loadingView = [[UIActivityIndicatorView alloc] initWithFrame:loadRect];
        self.loadingView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        self.loadingView.color = [UIColor colorWithRed:0.6 green:0.7 blue:1 alpha:1];
        [self addSubview:self.loadingView];
        self.hidden = YES;
        self.backgroundColor = [UIColor colorWithRed:0.01 green:0.01 blue:0.01 alpha:0.6];
    }
    return self;
    
}


- (void)startLoading
{
    self.hidden = NO;
    
    [self.superview bringSubviewToFront:self];
    
    self.loadingView.hidden = NO;
    [self.loadingView startAnimating];
    
    [UIView animateWithDuration:0.2
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                     }];
}

- (void)stopLoading
{
    [self.loadingView stopAnimating];
    
    [UIView animateWithDuration:0.2
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         self.loadingView.hidden = YES;
                         self.hidden = YES;
                         [self.superview sendSubviewToBack:self];
                     }];
}


@end
