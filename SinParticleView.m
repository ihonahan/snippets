//
//  SinParticleView.m
//  wofa
//
//  Created by Ihonahan Buitrago on 23/10/13.
//  Copyright (c) 2013 ByYuto. All rights reserved.
//

#import "SinParticleView.h"


@interface SinParticleView()

@property(assign) CGFloat currentSinY;
@property(assign) CGFloat currentSinX;
@property(assign) CGFloat currentSinAlpha;
@property(assign) CGFloat currentSinAngle;
@property(strong) CADisplayLink *sinDisplayLink;

@property(assign) CGFloat sinX0;
@property(assign) CGFloat sinY0;
@property(assign) CGFloat sinFinalY;
@property(assign) CGFloat sinMaxX;
@property(assign) CGFloat sinMaxY;
@property(assign) CGFloat rectAngle;

@property(strong) NSMutableArray *sparkles;

@end

@implementation SinParticleView

@synthesize currentSinY;
@synthesize currentSinX;
@synthesize currentSinAlpha;
@synthesize currentSinAngle;
@synthesize sinDisplayLink;
@synthesize sparkles;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (IS_IPAD) {
            // TODO: These values must be changed according to iPad's view
            self.sinX0 = frame.size.width / 2.0;
            self.sinY0 = 0;
            self.sinFinalY = frame.size.height;
            self.sinMaxX = frame.size.width;
            self.sinMaxY = frame.size.width * 0.66;
            self.rectAngle = 90;

            self.currentSinAlpha = 0;
            self.currentSinAngle = 0;
            self.currentSinX = self.sinX0;
            self.currentSinY = self.sinY0;
        } else {
            self.sinX0 = frame.size.width / 2.0;
            self.sinY0 = 0;
            self.sinFinalY = frame.size.height;
            self.sinMaxX = frame.size.width;
            self.sinMaxY = frame.size.width * 0.66;
            self.rectAngle = 90;
            
            self.currentSinAlpha = 0;
            self.currentSinAngle = 0;
            self.currentSinX = self.sinX0;
            self.currentSinY = self.sinY0;
        }
        
        self.sparkles = [[NSMutableArray alloc] init];
        self.clipsToBounds = NO;
    }
    
    return self;
}




#pragma mark - CADisplayLink methods
- (void)startSinDisplayLink
{
    // Sinus animated sparkle
    self.sinDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(sinDisplayLinkUpdate:)];
    self.sinDisplayLink.frameInterval = 1;
    
    [self.sinDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
//    NSLog(@"Sin particles started!!");
}

- (void)stopSinDisplayLink
{
    self.currentSinAlpha = 0;
    self.currentSinAngle = 0;
    self.currentSinX = self.sinX0;
    self.currentSinY = self.sinY0;
    
    [self.sinDisplayLink removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [self.sinDisplayLink invalidate];
    self.sinDisplayLink = nil;
    
//    NSLog(@"Sin particles stoped...");
}

- (void)sinDisplayLinkUpdate:(CADisplayLink *)sender
{
    CGFloat radAngle = DEGREES_TO_RADIANS(self.currentSinAngle);
    self.currentSinX = self.sinMaxX * sinf(radAngle);
    self.currentSinX /= 2.0;
    self.currentSinX += self.sinX0;
    self.currentSinY = (self.currentSinAngle * self.sinMaxY) / self.rectAngle;
    self.currentSinY += self.sinY0;
    self.currentSinAlpha = sinf(radAngle / 2.0);
    
    SparkleSin *sparkle = [SparkleSin initSparkleSinInPosition:CGPointMake(self.currentSinX, self.currentSinY) withSuperview:self andDelegate:self];
    
    [self.sparkles addObject:sparkle];
    
    self.currentSinAngle += 4.0;
    
    if (self.currentSinY >= self.sinFinalY) {
        [self stopSinDisplayLink];
        [self performSelector:@selector(startSinDisplayLink) withObject:nil afterDelay:18];
    }
}



#pragma mark - SparkleSinDelegate methods
- (void)sparkleSinDie:(SparkleSin *)sender
{
    [self.sparkles removeObject:sender];
    sender = nil;
}

@end
