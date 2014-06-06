//
//  LoadingView.h
//  mundoUne
//
//  Created by Ihonahan Buitrago on 10/15/13.
//  Copyright (c) 2013 Ricardo Hernandez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView

@property(strong) IBOutlet UIActivityIndicatorView *loadingView;

- (id)initLoadingViewWithSuperView:(UIView *)supVw;

- (void)startLoading;
- (void)stopLoading;


@end
