//
//  TransferBuyPlayerView.h
//  wofa
//
//  Created by Ihonahan Buitrago on 10/02/14.
//  Copyright (c) 2014 ByYuto. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Util.h"
#import "UserData.h"



@protocol TransferBuyPlayerViewDelegate;


@interface TransferBuyPlayerView : UIView <UIScrollViewDelegate>


@property(strong) IBOutlet UIView *fullContainer;
@property(strong) IBOutlet UIView *playerProfileInfoContainer;
@property(strong) IBOutlet UIView *playerProfileDataContainer;
@property(strong) IBOutlet UILabel *playerProfileNameLabel;
@property(strong) IBOutlet UILabel *playerSpecialLabel;
@property(strong) IBOutlet UIImageView *playerSpecialIcon1;
@property(strong) IBOutlet UIImageView *playerSpecialIcon2;
@property(strong) IBOutlet UIImageView *playerSpecialIcon3;
@property(strong) IBOutlet UILabel *playerAgeTitleLabel;
@property(strong) IBOutlet UILabel *playerAgeLabel;
@property(strong) IBOutlet UILabel *playerClubTitleLabel;
@property(strong) IBOutlet UILabel *playerCountryTitleLabel;
@property(strong) IBOutlet UIImageView *playerClubShield;
@property(strong) IBOutlet UIImageView *playerCountryFlag;

@property(strong) IBOutlet UIScrollView *contentScroller;
@property(strong) IBOutlet UIPageControl *pageControl;
@property(strong) IBOutlet UILabel *pageControlLabel;

@property(strong) IBOutlet UIView *normalBuyContainer;
@property(strong) IBOutlet UIButton *normalBuyButton;
@property(strong) IBOutlet UILabel *normalBuyLabel;

@property(strong) IBOutlet UIView *levelInfoBuyContainer;
@property(strong) IBOutlet UIImageView *lockImage;
@property(strong) IBOutlet UILabel *levelLabel;
@property(strong) IBOutlet UILabel *levelBuyCost;
@property(strong) IBOutlet UIView *normalInfoBuyContainer;
@property(strong) IBOutlet UIImageView *starImage;
@property(strong) IBOutlet UILabel *normalLabel;
@property(strong) IBOutlet UILabel *normalBuyCost;

@property(strong) IBOutlet UIButton *bronzeButton;
@property(strong) IBOutlet UIButton *silverButton;
@property(strong) IBOutlet UIButton *goldButton;
@property(strong) IBOutlet UIImageView *categoryIndicatorImage;

@property(assign) PlayerCategory myCategoryToChoose;

@property(weak) id<TransferBuyPlayerViewDelegate> delegate;


- (IBAction)tapUpBronze:(id)sender;
- (IBAction)tapUpSilver:(id)sender;
- (IBAction)tapUpGold:(id)sender;

- (IBAction)tapUpBuy:(id)sender;


+ (TransferBuyPlayerView *)initTransferBuyPlayerViewWithBronzePlayers:(NSArray *)theBronzes withSilverPlayers:(NSArray *)theSilvers withGoldPlayers:(NSArray *)theGolds withDelegate:(id<TransferBuyPlayerViewDelegate>)theDelegate;



@end


@protocol TransferBuyPlayerViewDelegate <NSObject>

@optional
- (void)transferBuyPlayerView:(TransferBuyPlayerView *)sender tryToBuyPlayer:(NSDictionary *)player;

@end