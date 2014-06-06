//
//  TransferBuyPlayerView.m
//  wofa
//
//  Created by Ihonahan Buitrago on 10/02/14.
//  Copyright (c) 2014 ByYuto. All rights reserved.
//

#import "TransferBuyPlayerView.h"

#import "UIImageView+WebCache.h"


@interface TransferBuyPlayerView()

@property(strong) NSArray *playersList;
@property(strong) NSArray *bronzePlayers;
@property(strong) NSArray *silverPlayers;
@property(strong) NSArray *goldPlayers;
@property(strong) NSMutableArray *pageViews;
@property(strong) UIColor *levelLockColor;
@property(strong) UIColor *categoryYellowColor;
@property(assign) CGRect initialScrollerFrame;
@property(assign) CGRect initialCardFrame;
@property(assign) CGFloat levelInfoBuyY;

@property(strong) UIImage *lockLockedIcon;
@property(strong) UIImage *lockUnlockedIcon;

@property(assign) CGFloat profileX;

- (void)setupTransferBuyPlayerViewWithBronzePlayers:(NSArray *)theBronzes withSilverPlayers:(NSArray *)theSilvers withGoldPlayers:(NSArray *)theGolds withDelegate:(id<TransferBuyPlayerViewDelegate>)theDelegate;

@end


@implementation TransferBuyPlayerView

@synthesize fullContainer;
@synthesize playerProfileInfoContainer;
@synthesize playerProfileDataContainer;
@synthesize playerProfileNameLabel;
@synthesize playerSpecialLabel;
@synthesize playerSpecialIcon1;
@synthesize playerSpecialIcon2;
@synthesize playerSpecialIcon3;
@synthesize playerAgeTitleLabel;
@synthesize playerAgeLabel;
@synthesize playerClubTitleLabel;
@synthesize playerCountryTitleLabel;
@synthesize playerClubShield;
@synthesize playerCountryFlag;
@synthesize contentScroller;
@synthesize pageControl;
@synthesize pageControlLabel;
@synthesize normalBuyContainer;
@synthesize normalBuyButton;
@synthesize normalBuyLabel;
@synthesize levelInfoBuyContainer;
@synthesize lockImage;
@synthesize levelLabel;
@synthesize levelBuyCost;
@synthesize normalInfoBuyContainer;
@synthesize starImage;
@synthesize normalLabel;
@synthesize normalBuyCost;
@synthesize bronzeButton;
@synthesize silverButton;
@synthesize goldButton;
@synthesize categoryIndicatorImage;
@synthesize myCategoryToChoose;
@synthesize delegate;

@synthesize playersList;
@synthesize bronzePlayers;
@synthesize silverPlayers;
@synthesize goldPlayers;
@synthesize levelLockColor;
@synthesize categoryYellowColor;
@synthesize initialScrollerFrame;
@synthesize initialCardFrame;
@synthesize levelInfoBuyY;
@synthesize lockLockedIcon;
@synthesize lockUnlockedIcon;



+ (TransferBuyPlayerView *)initTransferBuyPlayerViewWithBronzePlayers:(NSArray *)theBronzes withSilverPlayers:(NSArray *)theSilvers withGoldPlayers:(NSArray *)theGolds withDelegate:(id<TransferBuyPlayerViewDelegate>)theDelegate
{
    NSString *nibName = nil;
    if (IS_IPAD) {
        nibName = @"TransferBuyPlayerView_ipad";
    } else {
        nibName = @"TransferBuyPlayerView";
    }
    
    NSArray *xibsArray = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
    if (xibsArray && xibsArray.count) {
        TransferBuyPlayerView *view = [xibsArray objectAtIndex:0];
        
        [view setupTransferBuyPlayerViewWithBronzePlayers:theBronzes withSilverPlayers:theSilvers withGoldPlayers:theGolds withDelegate:theDelegate];
        
        return view;
    }
    
    return nil;
}


- (void)setupTransferBuyPlayerViewWithBronzePlayers:(NSArray *)theBronzes withSilverPlayers:(NSArray *)theSilvers withGoldPlayers:(NSArray *)theGolds withDelegate:(id<TransferBuyPlayerViewDelegate>)theDelegate
{
    self.delegate = theDelegate;
    self.bronzePlayers = theBronzes;
    self.silverPlayers = theSilvers;
    self.goldPlayers = theGolds;
    
    self.contentScroller.delegate = self;
    
    self.playerProfileNameLabel.font = FONT_BOLD(15);
    self.playerSpecialLabel.font = FONT_REGULAR(12);
    self.playerAgeLabel.font = FONT_REGULAR(12);
    self.playerClubTitleLabel.font = FONT_REGULAR(12);
    self.playerCountryTitleLabel.font = FONT_REGULAR(12);
    self.playerAgeLabel.font = FONT_NUMBERS(24);
    self.levelLabel.font = FONT_REGULAR(12);
    self.normalLabel.font = FONT_BOLD(13);
    self.levelBuyCost.font = FONT_NUMBERS(13);
    self.normalBuyCost.font = FONT_NUMBERS(13);
    self.normalBuyLabel.font = FONT_REGULAR(8);
    self.bronzeButton.titleLabel.font = FONT_BOLD(15);
    self.silverButton.titleLabel.font = FONT_BOLD(15);
    self.goldButton.titleLabel.font = FONT_BOLD(15);
    self.pageControlLabel.font = FONT_NUMBERS(13);
    
    self.levelLockColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1];
    self.categoryYellowColor = [UIColor colorWithRed:0.93 green:0.81 blue:0.3 alpha:1];
    
    self.lockUnlockedIcon = [UIImage imageNamed:@"centro_transferencia_ios-54.png"];
    self.lockLockedIcon = [UIImage imageNamed:@"centro_trans_ios-48.png"];
    
    NSString *levelStr = NSLocalizedString(@"LEVEL", nil);
    long long nLevel = 0;
    if ([UserData sharedUserData].userExperience < 10) {
        nLevel = 0;
    } else {
        long long lvl = ([UserData sharedUserData].userExperience - 10) / 30;
        lvl++;
        nLevel = lvl;
    }
    self.levelLabel.text = [NSString stringWithFormat:@"%@ %lld", levelStr, nLevel];
    
    self.normalLabel.text = NSLocalizedString(@"BUY HIM NOW", nil);
    
    [self.bronzeButton setTitle:NSLocalizedString(@"BRONZE", nil) forState:UIControlStateNormal];
    [self.silverButton setTitle:NSLocalizedString(@"SILVER", nil) forState:UIControlStateNormal];
    [self.goldButton setTitle:NSLocalizedString(@"GOLD", nil) forState:UIControlStateNormal];
    self.playerSpecialLabel.text = NSLocalizedString(@"SPECIAL", nil);
    self.playerAgeTitleLabel.text = NSLocalizedString(@"AGE", nil);
    self.playerClubTitleLabel.text = NSLocalizedString(@"TEAM", nil);
    self.playerCountryTitleLabel.text = NSLocalizedString(@"COUNTRY", nil);
    self.normalBuyLabel.text = NSLocalizedString(@"BUY", nil);
    
    self.bronzeButton.titleLabel.textColor = self.categoryYellowColor;
    self.silverButton.titleLabel.textColor = [UIColor whiteColor];
    self.goldButton.titleLabel.textColor = [UIColor whiteColor];
    if (IS_IPAD) {
        self.categoryIndicatorImage.frame = CGRectMake(66, 53, self.categoryIndicatorImage.frame.size.width, self.categoryIndicatorImage.frame.size.height);
        //TODO: For iPad this could be different so we need to double check with Nib File
        self.levelInfoBuyY = 92;
    } else {
        self.categoryIndicatorImage.frame = CGRectMake(66, 53, self.categoryIndicatorImage.frame.size.width, self.categoryIndicatorImage.frame.size.height);
        self.levelInfoBuyY = 92;
    }

    self.initialScrollerFrame = self.contentScroller.frame;

    [self loadPlayersUsingCategory:PlayerCategoryBronze];
    
    self.pageControl.hidden = YES;
    
    if (!IS_IPAD) {
        if (!IS_IPHONE_4INCH) {
            self.normalBuyContainer.frame = CGRectMake(self.normalBuyContainer.frame.origin.x - 88,
                                                self.normalBuyContainer.frame.origin.y,
                                                self.normalBuyContainer.frame.size.width,
                                                self.normalBuyContainer.frame.size.height);
            self.bronzeButton.frame = CGRectMake(self.bronzeButton.frame.origin.x - 88,
                                               self.bronzeButton.frame.origin.y,
                                               self.bronzeButton.frame.size.width,
                                               self.bronzeButton.frame.size.height);
            self.silverButton.frame = CGRectMake(self.silverButton.frame.origin.x - 88,
                                                       self.silverButton.frame.origin.y,
                                                       self.silverButton.frame.size.width,
                                                       self.silverButton.frame.size.height);
            self.goldButton.frame = CGRectMake(self.goldButton.frame.origin.x - 88,
                                                 self.goldButton.frame.origin.y,
                                                 self.goldButton.frame.size.width,
                                                 self.goldButton.frame.size.height);
            self.playerProfileDataContainer.frame = CGRectMake(self.playerProfileDataContainer.frame.origin.x - 88,
                                               self.playerProfileDataContainer.frame.origin.y,
                                               self.playerProfileDataContainer.frame.size.width,
                                               self.playerProfileDataContainer.frame.size.height);
        }
    }
}


- (IBAction)tapUpBronze:(id)sender
{
    CGFloat x = 0;
    CGFloat y = 0;
    if (IS_IPAD) {
        x = 66;
        y = 53;
    } else {
        x = 66;
        y = 53;
    }
    [UIView animateWithDuration:0.15
                          delay:0
                        options:(UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.categoryIndicatorImage.frame = CGRectMake(x, y, self.categoryIndicatorImage.frame.size.width, self.categoryIndicatorImage.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         self.bronzeButton.titleLabel.textColor = self.categoryYellowColor;
                         self.silverButton.titleLabel.textColor = [UIColor whiteColor];
                         self.goldButton.titleLabel.textColor = [UIColor whiteColor];
                     }];
    [self loadPlayersUsingCategory:PlayerCategoryBronze];
}

- (IBAction)tapUpSilver:(id)sender
{
    CGFloat x = 0;
    CGFloat y = 0;
    if (IS_IPAD) {
        x = 66;
        y = 53;
    } else {
        x = 143;
        y = 53;
    }
    [UIView animateWithDuration:0.15
                          delay:0
                        options:(UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.categoryIndicatorImage.frame = CGRectMake(x, y, self.categoryIndicatorImage.frame.size.width, self.categoryIndicatorImage.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         self.bronzeButton.titleLabel.textColor = [UIColor whiteColor];
                         self.silverButton.titleLabel.textColor = self.categoryYellowColor;
                         self.goldButton.titleLabel.textColor = [UIColor whiteColor];
                     }];
    [self loadPlayersUsingCategory:PlayerCategorySilver];
}

- (IBAction)tapUpGold:(id)sender
{
    CGFloat x = 0;
    CGFloat y = 0;
    if (IS_IPAD) {
        x = 66;
        y = 53;
    } else {
        x = 220;
        y = 53;
    }
    [UIView animateWithDuration:0.15
                          delay:0
                        options:(UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.categoryIndicatorImage.frame = CGRectMake(x, y, self.categoryIndicatorImage.frame.size.width, self.categoryIndicatorImage.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         self.bronzeButton.titleLabel.textColor = [UIColor whiteColor];
                         self.silverButton.titleLabel.textColor = [UIColor whiteColor];
                         self.goldButton.titleLabel.textColor = self.categoryYellowColor;
                     }];
    [self loadPlayersUsingCategory:PlayerCategoryGold];
}


- (IBAction)tapUpBuy:(id)sender
{
    if (self.playersList && self.playersList.count) {
        NSUInteger inx = self.pageControl.currentPage;
        NSDictionary *player = [self.playersList objectAtIndex:inx];
        if (player && self.delegate) {
            if ([self.delegate respondsToSelector:@selector(transferBuyPlayerView:tryToBuyPlayer:)]) {
                [self.delegate transferBuyPlayerView:self tryToBuyPlayer:player];
            }
        }
    }
}



#pragma mark - Players data and load info
- (void)loadPlayersUsingCategory:(PlayerCategory)newPlayCat
{
    self.myCategoryToChoose = newPlayCat;
    switch (self.myCategoryToChoose) {
        case PlayerCategoryBronze:
        {
            if (self.bronzePlayers && self.bronzePlayers.count) {
                self.playersList = self.bronzePlayers;
            } else {
                self.playersList = nil;
            }
        }
            break;
            
        case PlayerCategorySilver:
        {
            if (self.silverPlayers && self.silverPlayers.count) {
                self.playersList = self.silverPlayers;
            } else {
                self.playersList = nil;
            }
        }
            break;
            
        case PlayerCategoryGold:
        {
            if (self.goldPlayers && self.goldPlayers.count) {
                self.playersList = self.goldPlayers;
            } else {
                self.playersList = nil;
            }
        }
            break;
            
        default:
            break;
    }
    
    if (self.playersList && self.playersList.count) {
        self.pageControl.hidden = YES;
        self.pageControl.numberOfPages = self.playersList.count;
        [UIView animateWithDuration:0.2
                              delay:0
                            options:(UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction)
                         animations:^{
                             self.contentScroller.frame = CGRectMake(-self.initialScrollerFrame.size.width -1000, self.initialScrollerFrame.origin.y, self.initialScrollerFrame.size.width, self.initialScrollerFrame.size.height);
                             self.contentScroller.alpha = 0;

                             self.playerProfileInfoContainer.alpha = 0;
                         }
                         completion:^(BOOL finished) {
                             for (UIView *view in self.contentScroller.subviews) {
                                 [view removeFromSuperview];
                             }
                             
                             self.pageViews = [[NSMutableArray alloc] init];
                             int i = 0;
                             for (i = 0; i < self.playersList.count; i++) {
                                 [self.pageViews addObject:[NSNull null]];
                             }
                             
                             self.contentScroller.frame = self.initialScrollerFrame;
                             [UIView animateWithDuration:0.2
                                                   delay:0
                                                 options:(UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction)
                                              animations:^{
                                                  self.contentScroller.alpha = 1;
                                                  self.playerProfileInfoContainer.alpha = 1;
                                              }
                                              completion:^(BOOL finished) {
                                                  [self loadVisiblePages];
                                              }];
                         }];
    }  // End if (self.playersList && self.playersList.count)
    
}

- (void)fadeOutPlayerInfo
{
    [UIView animateWithDuration:0.4
                          delay:0
                        options:(UIViewAnimationOptionCurveEaseIn|UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.playerProfileInfoContainer.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         [self performSelector:@selector(loadPlayerData) withObject:nil afterDelay:0.3];
                     }];
}


- (void)fadeInPlayerInfo
{
    [UIView animateWithDuration:0.4
                          delay:0
                        options:(UIViewAnimationOptionCurveEaseIn|UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.playerProfileInfoContainer.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                     }];
}


- (void)loadPlayerData
{
    int index = self.pageControl.currentPage;
    
    if (index < self.playersList.count) {
        NSDictionary *player = [self.playersList objectAtIndex:index];
        self.playerProfileNameLabel.text = [player objectForKey:@"name"];
        int age = [Util getAgeFromDateString:[player objectForKey:@"birthday"] withFormat:@"yyyy-MM-dd"];
        self.playerAgeLabel.text = [NSString stringWithFormat:@"%d", age];
        NSDictionary *club = [player objectForKey:@"club"];
        [self.playerClubShield setImageWithURL:[NSURL URLWithString:[club objectForKey:@"shield"]] placeholderImage:nil];
        NSDictionary *country = [player objectForKey:@"country"];
        [self.playerCountryFlag setImageWithURL:[NSURL URLWithString:[country objectForKey:@"shield"]] placeholderImage:nil];
        self.playerSpecialIcon1.hidden = YES;
        self.playerSpecialIcon2.hidden = YES;
        self.playerSpecialIcon3.hidden = YES;
        NSArray *abilities = [player objectForKey:@"abilities"];
        for (NSDictionary *abil in abilities) {
            int idSkill = [[abil objectForKey:@"id"] intValue];
            if (idSkill == ButtonHeadCode) {
                self.playerSpecialIcon1.hidden = NO;
            }
            if (idSkill == ButtonLeftCode) {
                self.playerSpecialIcon3.hidden = NO;
            }
            if (idSkill == ButtonRightCode) {
                self.playerSpecialIcon2.hidden = NO;
            }
        }
        
        long long lvl = ([UserData sharedUserData].userExperience - 10) / 30;
        lvl++;
        long long playerLevel = [[player objectForKey:@"level"] longLongValue];
        if (lvl >= playerLevel) {
            self.levelLabel.textColor = self.categoryYellowColor;
            self.lockImage.image = self.lockUnlockedIcon;
            CGFloat y = self.levelInfoBuyY + (self.levelInfoBuyContainer.frame.size.height / 2.0);
            self.levelInfoBuyContainer.frame = CGRectMake(self.levelInfoBuyContainer.frame.origin.x, y, self.levelInfoBuyContainer.frame.size.width, self.levelInfoBuyContainer.frame.size.height);
            self.normalInfoBuyContainer.hidden = YES;
        } else {
            self.levelLabel.textColor = self.levelLockColor;
            self.lockImage.image = self.lockLockedIcon;
            CGFloat y = self.levelInfoBuyY;
            self.levelInfoBuyContainer.frame = CGRectMake(self.levelInfoBuyContainer.frame.origin.x, y, self.levelInfoBuyContainer.frame.size.width, self.levelInfoBuyContainer.frame.size.height);
            self.normalInfoBuyContainer.hidden = NO;
        }
        
        NSString *levelStr = NSLocalizedString(@"LEVEL", nil);
        self.levelLabel.text = [NSString stringWithFormat:@"%@ %lld", levelStr, playerLevel];
        
        self.levelBuyCost.text = [player objectForKey:@"buy_level_price"];
        self.normalBuyCost.text = [player objectForKey:@"buy_price"];
    } else {
        self.playerProfileNameLabel.text = @"";
        self.playerAgeLabel.text = @"";
        self.playerClubShield.image = nil;
        self.playerCountryFlag.image = nil;
        self.levelLabel.textColor = self.levelLockColor;
        self.levelBuyCost.text = @"";
        self.normalBuyCost.text = @"";
    }

    [self fadeInPlayerInfo];
}


#pragma mark - UIScrollViewDelegate methods
- (void)loadVisiblePages
{
    CGFloat pageWidth = self.contentScroller.frame.size.width;
    NSInteger page = (NSInteger)floor((self.contentScroller.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0));
    
    self.pageControl.hidden = YES;
    self.pageControl.currentPage = page;
    self.pageControlLabel.text = [NSString stringWithFormat:@"%d/%d", (self.pageControl.currentPage + 1), self.pageControl.numberOfPages];
    
    [self fadeOutPlayerInfo];
    
    int firstPage = page - 1;
    int lastPage = page + 1;
    int i = 0;
    
    for (i = 0; i < firstPage; i++) {
        [self purgePage:i];
    }
    for (i = firstPage; i <= lastPage; i++) {
        [self loadPage:i];
    }
    for (i = lastPage+1; i < self.playersList.count; i++) {
        [self purgePage:i];
    }
    
    self.contentScroller.contentSize = CGSizeMake(self.contentScroller.frame.size.width * self.playersList.count, self.contentScroller.frame.size.height);
}

- (void)loadPage:(int)page
{
    if (page < 0 || page >= self.playersList.count) {
        return;
    }
    
    UIView *pageView = [self.pageViews objectAtIndex:page];
    if ((NSNull*)pageView == [NSNull null]) {
        CGRect frameVw = CGRectMake(self.contentScroller.frame.origin.x, self.contentScroller.frame.origin.y, self.contentScroller.frame.size.width, self.contentScroller.frame.size.height);
        frameVw.origin.x = frameVw.size.width * page;
        frameVw.origin.y = 0.0;
        CGFloat insetX = frameVw.size.width - (frameVw.size.width * 0.95);
        CGFloat insetY = frameVw.size.height - (frameVw.size.height * 0.95);
        frameVw = CGRectInset(frameVw, insetX, insetY);
        
        self.playerSpecialIcon1.hidden = YES;
        self.playerSpecialIcon2.hidden = YES;
        self.playerSpecialIcon3.hidden = YES;
        
        NSDictionary *player = [self.playersList objectAtIndex:page];
        
        NSArray *abilities = [player objectForKey:@"abilities"];
        if (abilities && abilities.count) {
            for (NSDictionary *item in abilities) {
                // TODO: get abilities and show specialities icons
                int idAb = [[item objectForKey:@"id"] intValue];
                if (idAb == ButtonHeadCode) {
                    self.playerSpecialIcon1.hidden = NO;
                } else if (idAb == ButtonRightCode) {
                    self.playerSpecialIcon2.hidden = NO;
                } else if (idAb == ButtonLeftCode) {
                    self.playerSpecialIcon3.hidden = NO;
                }
            }
        }

        NSDictionary *photos = [player objectForKey:@"photo"];
        NSString *imgUrl = [photos objectForKey:@"big"];
        UIView *imageContainer = [[UIView alloc] initWithFrame:frameVw];
        CGFloat minVal = (frameVw.size.width < frameVw.size.height) ? frameVw.size.width : frameVw.size.height;
        CGRect imgRect = CGRectMake(0, 0, minVal, minVal);
        imgRect.origin.x = imgRect.size.width * 0.015;
        imgRect.origin.y = imgRect.size.height * 0.08;
        imgRect.size.width *= 0.6;
        imgRect.size.height *= 0.8;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:imgRect];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.backgroundColor = [UIColor clearColor];
        imageContainer.backgroundColor = [UIColor clearColor];
        [imageContainer addSubview:imageView];
        
        [imageView setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:nil];
        [self.pageViews replaceObjectAtIndex:page withObject:imageContainer];
        [self.contentScroller addSubview:imageContainer];
    }
}

- (void)purgePage:(int)page
{
    if (page < 0 || page >= self.playersList.count) {
        return;
    }
    
    UIView *pageView = [self.pageViews objectAtIndex:page];
    if ((NSNull*)pageView != [NSNull null]) {
        [pageView removeFromSuperview];
        [self.pageViews replaceObjectAtIndex:page withObject:[NSNull null]];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.contentScroller) {
        if (self.playersList) {
            if (self.playersList.count) {
                [self loadVisiblePages];
            }
        }
    }
}





@end
