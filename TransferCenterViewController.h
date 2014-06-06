//
//  TransferCenterViewController.h
//  wofa
//
//  Created by Ihonahan Buitrago on 10/02/14.
//  Copyright (c) 2014 ByYuto. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HomeMenuView.h"

#import "InitialServices.h"
#import "PlayGameServices.h"
#import "PopUpMessageView.h"
#import "SinParticleView.h"
#import "HomeMenuView.h"
#import "TransferBuyPlayerView.h"
#import "TransferSellPlayerView.h"
#import "TransferMoneyView.h"


#import <StoreKit/StoreKit.h>

#import <AdColony/AdColony.h>


typedef enum {
    TransferCenterTabBuy,
    TransferCenterTabSell,
    TransferCenterTabMoney
} TransferCenterTab;


@interface TransferCenterViewController : UIViewController <HomeMenuViewDelegate, PopUpMessageViewDelegate, HomeMenuViewDelegate, TransferBuyPlayerViewDelegate, TransferSellPlayerViewDelegate, TransferMoneyViewDelegate, SKProductsRequestDelegate, SKPaymentTransactionObserver, AdColonyAdDelegate>

@property(strong) IBOutlet UIView *fullContainer;
@property(strong) IBOutlet UIImageView *backgroundImage;

@property(strong) IBOutlet UIView *sinContainer;
@property(strong) SinParticleView *sinView;

@property(strong) IBOutlet UIButton *menuButton;

@property(strong) IBOutlet UIView *userInfoContainer;
@property(strong) IBOutlet UILabel *userXPLabel;
@property(strong) IBOutlet UIButton *leaderboardButton;
@property(strong) IBOutlet UILabel *userCoinsLabel;
@property(strong) IBOutlet UIButton *userMoreButton;
@property(strong) IBOutlet UIButton *notificationButton;
@property(strong) IBOutlet UIView *notificationBadgeContainer;
@property(strong) IBOutlet UILabel *notificationBadgeLabel;

@property(strong) IBOutlet UIView *transferTabButtonsContainer;
@property(strong) IBOutlet UIButton *transferBuyButton;
@property(strong) IBOutlet UIButton *transferSellButton;
@property(strong) IBOutlet UIButton *transferCoinsButton;

@property(strong) IBOutlet UIView *transferTabContainer;

@property(strong) IBOutlet UIImageView *yardImage;

@property(assign) BOOL isVisible;

@property(strong) TransferBuyPlayerView *buyPlayerView;
@property(strong) TransferSellPlayerView *sellPlayerView;
@property(strong) TransferMoneyView *moneyView;

@property(assign) TransferCenterTab firstViewedTab;

@property(strong) IBOutlet UIView *alertContainer;
@property(strong) IBOutlet UIView *alertContentContainer;
@property(strong) IBOutlet UILabel *alertTitle;
@property(strong) IBOutlet UILabel *alertMessage;
@property(strong) IBOutlet UIButton *alertButton;


//// Auxiliar views to messages
@property(strong) IBOutlet UIView *normalBuyContainer;
@property(strong) IBOutlet UILabel *normalBuyLabel;

@property(strong) IBOutlet UIView *levelBuyContainer;
@property(strong) IBOutlet UILabel *levelBuyLabel;


- (IBAction)tapUpUserMore:(id)sender;

- (IBAction)tapUpMenu:(id)sender;

- (IBAction)tapUpNotification:(id)sender;

- (IBAction)tapUpTransferBuy:(id)sender;
- (IBAction)tapUpTransferSell:(id)sender;
- (IBAction)tapUpTransferCoins:(id)sender;

- (IBAction)tapUpAlertAction:(id)sender;

- (IBAction)tapUpLeaderboard:(id)sender;


- (id)initTransferCenterViewControllerFirstViewBuy;
- (id)initTransferCenterViewControllerFirstViewSell;
- (id)initTransferCenterViewControllerFirstViewMoney;


- (void)fadeInFromNavigation;
- (void)fadeOutFromNavigation:(BOOL)back;
- (void)fadeOutForNavigationToViewController:(UIViewController *)destinationVC isPop:(BOOL)isToPop;
- (void)fadeFromPop;


- (void)loadTransferData;



@end
