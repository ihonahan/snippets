//
//  SparkleSin.h
//  wofa
//
//  Created by Ihonahan Buitrago on 23/10/13.
//  Copyright (c) 2013 ByYuto. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Util.h"


@protocol SparkleSinDelegate;

@interface SparkleSin : UIView

@property(strong) IBOutlet UIImageView *sparkleImage;

@property(weak) id<SparkleSinDelegate> delegate;


+ (SparkleSin *)initSparkleSinInPosition:(CGPoint)newPos withSuperview:(UIView *)parentView andDelegate:(id<SparkleSinDelegate>)newDel;


@end


@protocol SparkleSinDelegate <NSObject>

@optional
- (void)sparkleSinDie:(SparkleSin *)sender;

@end
