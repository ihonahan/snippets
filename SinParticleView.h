//
//  SinParticleView.h
//  wofa
//
//  Created by Ihonahan Buitrago on 23/10/13.
//  Copyright (c) 2013 ByYuto. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Util.h"
#import "SparkleSin.h"


@interface SinParticleView : UIView <SparkleSinDelegate>


- (void)startSinDisplayLink;
- (void)stopSinDisplayLink;

@end
