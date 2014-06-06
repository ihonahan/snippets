//
//  TransferCenterViewController.m
//  wofa
//
//  Created by Ihonahan Buitrago on 10/02/14.
//  Copyright (c) 2014 ByYuto. All rights reserved.
//

#import "TransferCenterViewController.h"

#import "LoadingView.h"

#import "NotificationCenterViewController.h"
#import "HomeViewController.h"
#import "NewsViewController.h"
#import "TermsAndConditionsViewController.h"

#import "VerificationController.h"
#import "LeaderboardViewController.h"

#import "TutorialViewController.h"


@interface TransferCenterViewController ()

@property(strong) NSMutableArray *playersToSellArray;
@property(strong) NSMutableArray *playersToBuyArray;
@property(strong) NSMutableArray *packetsArray;
@property(strong) NSMutableArray *supergoalsArray;
@property(strong) NSMutableArray *coinsArray;
@property(strong) NSDictionary *playerToBeBuyed;
@property(strong) NSDictionary *playerToBeSold;

@property(strong) LoadingView *loading;
@property(strong) PopUpMessageView *messageView;
@property(strong) HomeMenuView *homeMenu;

@property(strong) UIImage *btnTabBuyNormal;
@property(strong) UIImage *btnTabBuyHigh;
@property(strong) UIImage *btnTabSellNormal;
@property(strong) UIImage *btnTabSellHigh;
@property(strong) UIImage *btnTabMoneyNormal;
@property(strong) UIImage *btnTabMoneyHigh;
@property(strong) UIView *selectedTabView;
@property(assign) BOOL isFadedForNavigation;

@property(strong) NSDictionary *buyablePackSelectedToBuy;

@property(assign) BOOL adcVideoStarting;


@end

@implementation TransferCenterViewController

@synthesize fullContainer;
@synthesize backgroundImage;
@synthesize sinContainer;
@synthesize menuButton;
@synthesize userInfoContainer;
@synthesize userXPLabel;
@synthesize userCoinsLabel;
@synthesize userMoreButton;
@synthesize notificationButton;
@synthesize notificationBadgeContainer;
@synthesize notificationBadgeLabel;
@synthesize transferTabContainer;
@synthesize transferBuyButton;
@synthesize transferSellButton;
@synthesize transferCoinsButton;
@synthesize yardImage;
@synthesize isVisible;
@synthesize buyPlayerView;
@synthesize sellPlayerView;
@synthesize moneyView;
@synthesize firstViewedTab;

@synthesize alertContainer;
@synthesize alertContentContainer;
@synthesize alertTitle;
@synthesize alertMessage;
@synthesize alertButton;

@synthesize playersToBuyArray;
@synthesize playersToSellArray;
@synthesize packetsArray;
@synthesize supergoalsArray;
@synthesize coinsArray;
@synthesize loading;
@synthesize messageView;
@synthesize homeMenu;
@synthesize btnTabBuyNormal;
@synthesize btnTabBuyHigh;
@synthesize btnTabSellNormal;
@synthesize btnTabSellHigh;
@synthesize btnTabMoneyNormal;
@synthesize btnTabMoneyHigh;
@synthesize selectedTabView;
@synthesize isFadedForNavigation;
@synthesize playerToBeBuyed;
@synthesize playerToBeSold;
@synthesize buyablePackSelectedToBuy;
@synthesize adcVideoStarting;



- (id)initTransferCenterViewControllerFirstViewBuy
{
    NSString *nibName = @"";
    if (IS_IPAD) {
        nibName = @"TransferCenterViewController_ipad";
    } else {
        nibName = @"TransferCenterViewController";
    }
    self = [super initWithNibName:nibName bundle:[NSBundle mainBundle]];
    if (self) {
        self.firstViewedTab = TransferCenterTabBuy;
        self.isFadedForNavigation = NO;
        self.btnTabBuyNormal = [UIImage imageNamed:@"centro_trans_ios-11.png"];
        self.btnTabBuyHigh = [UIImage imageNamed:@"centro_trans_ios-10.png"];
        self.btnTabSellNormal = [UIImage imageNamed:@"centro_trans_ios-31.png"];
        self.btnTabSellHigh = [UIImage imageNamed:@"centro_trans_ios-30.png"];
        self.btnTabMoneyNormal = [UIImage imageNamed:@"centro_trans_ios-13.png"];
        self.btnTabMoneyHigh = [UIImage imageNamed:@"centro_trans_ios-12.png"];
    }
    return self;
}

- (id)initTransferCenterViewControllerFirstViewSell
{
    NSString *nibName = @"";
    if (IS_IPAD) {
        nibName = @"TransferCenterViewController_ipad";
    } else {
        nibName = @"TransferCenterViewController";
    }
    self = [super initWithNibName:nibName bundle:[NSBundle mainBundle]];
    if (self) {
        self.firstViewedTab = TransferCenterTabSell;
        self.isFadedForNavigation = NO;
        self.btnTabBuyNormal = [UIImage imageNamed:@"centro_trans_ios-10.png"];
        self.btnTabBuyHigh = [UIImage imageNamed:@"centro_trans_ios-11.png"];
        self.btnTabSellNormal = [UIImage imageNamed:@"centro_trans_ios-30.png"];
        self.btnTabSellHigh = [UIImage imageNamed:@"centro_trans_ios-31.png"];
        self.btnTabMoneyNormal = [UIImage imageNamed:@"centro_trans_ios-12.png"];
        self.btnTabMoneyHigh = [UIImage imageNamed:@"centro_trans_ios-13.png"];
    }
    return self;
}

- (id)initTransferCenterViewControllerFirstViewMoney
{
    NSString *nibName = @"";
    if (IS_IPAD) {
        nibName = @"TransferCenterViewController_ipad";
    } else {
        nibName = @"TransferCenterViewController";
    }
    self = [super initWithNibName:nibName bundle:[NSBundle mainBundle]];
    if (self) {
        self.firstViewedTab = TransferCenterTabMoney;
        self.isFadedForNavigation = NO;
        self.btnTabBuyNormal = [UIImage imageNamed:@"centro_trans_ios-11.png"];
        self.btnTabBuyHigh = [UIImage imageNamed:@"centro_trans_ios-10.png"];
        self.btnTabSellNormal = [UIImage imageNamed:@"centro_trans_ios-31.png"];
        self.btnTabSellHigh = [UIImage imageNamed:@"centro_trans_ios-30.png"];
        self.btnTabMoneyNormal = [UIImage imageNamed:@"centro_trans_ios-13.png"];
        self.btnTabMoneyHigh = [UIImage imageNamed:@"centro_trans_ios-12.png"];
    }
    return self;
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self.sinContainer addSubview:self.sinView];
    
    // Loading view
    self.loading = [[LoadingView alloc] initLoadingViewWithSuperView:self.view];
    [self.loading stopLoading];

    // Player Info
    self.userXPLabel.font = FONT_NUMBERS(15);
    self.userCoinsLabel.font = FONT_NUMBERS(15);
    self.notificationBadgeLabel.font = FONT_NUMBERS(13);
    
    // Tabs
    
    // Loading view
    self.loading = [[LoadingView alloc] initLoadingViewWithSuperView:self.view];
    [self.loading stopLoading];
    
    // Message view
    self.messageView = [PopUpMessageView initPopUpMessageViewWithParentView:self.view andDelegate:self];

    // Home Menu
    self.homeMenu = [HomeMenuView initHomeMenuViewWithSuperView:self.view withMenuButton:self.menuButton andDelegate:self];
    
    self.fullContainer.alpha = 0;
    [self fadeInFromNavigation];
    
    self.playerToBeBuyed = nil;
    self.playerToBeSold = nil;
    [self loadTransferData];
    
    // Money transactions view
    self.moneyView = [TransferMoneyView initTransferMoneyViewWithDelegate:self];
    if (self.firstViewedTab == TransferCenterTabMoney) {
        [self.transferTabContainer addSubview:self.moneyView];
        [self.transferBuyButton setImage:self.btnTabBuyNormal forState:UIControlStateNormal];
        [self.transferSellButton setImage:self.btnTabSellNormal forState:UIControlStateNormal];
        [self.transferCoinsButton setImage:self.btnTabMoneyHigh forState:UIControlStateNormal];
        self.yardImage.alpha = 0;
    } else if (self.firstViewedTab == TransferCenterTabSell) {
        self.yardImage.alpha = 0;
    } else if (self.firstViewedTab == TransferCenterTabBuy) {
        self.yardImage.alpha = 1;
    }
    
    self.buyablePackSelectedToBuy = nil;
    
    // Alert pop view
    [self.view addSubview:self.alertContainer];
    [self.view sendSubviewToBack:self.alertContainer];
    self.alertContainer.hidden = YES;
    self.alertContainer.alpha = 0;
    self.alertContentContainer.frame = CGRectMake(self.alertContentContainer.frame.origin.x, self.alertContentContainer.frame.size.height, self.alertContentContainer.frame.size.width, self.alertContentContainer.frame.size.height);
    self.alertTitle.font = FONT_BOLD(14);
    self.alertMessage.font = FONT_REGULAR(13);
    self.alertButton.titleLabel.font = FONT_BOLD(13);
    
    [self delayedTimerForReloadNotifications];
    
    NSArray *pendingTransactions = [[SKPaymentQueue defaultQueue] transactions];
    if (pendingTransactions && pendingTransactions.count) {
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    }
}


- (void)viewDidAppear:(BOOL)animated
{
    [self.sinContainer addSubview:self.sinView];
    [self fadeInFromNavigation];
    [self loadNotifications];
    
    // For tutorial
    NSString *firstViewTrns = GET_USERDEFAULTS(USER_FIRST_VIEW_TRANSFER);
    if (!firstViewTrns || ![firstViewTrns isKindOfClass:[NSString class]]) {
        SET_USERDEFAULTS(USER_FIRST_VIEW_TRANSFER, @"1");
        SYNC_USERDEFAULTS;
        
        TutorialViewController *tutoTrans = [[TutorialViewController alloc] initTransferTutorialViewController];
        [self fadeOutForNavigationToViewController:tutoTrans isPop:NO];
    }

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loadTransferData
{
    for (UIView *view in self.transferTabContainer.subviews) {
        [view removeFromSuperview];
    }
    
    NSString *token = GET_USERDEFAULTS(SESSION_TOKEN);
    NSString *userId = GET_USERDEFAULTS(USER_DEVICE_ID);

    // Load My Players
    
    // Request players that can be sold
    [InitialServices requestHomeDataUser:userId andToken:token withBlock:^(NSArray *players, NSError *error) {
        if (error) {
            NSString *msgLoc = NSLocalizedString(@"There was an error when trying to get players", nil);
            NSString *msg = [NSString stringWithFormat:@"%@: %@", msgLoc, [error localizedDescription]];
            NSString *msgTitle = NSLocalizedString(@"Players", nil);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:msgTitle
                                                            message:msg
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            return;
        }
        
        if ([UserData sharedUserData].userNewNotifications) {
            self.notificationBadgeContainer.hidden = NO;
            NSString *newNotiStr = @"";
            if ([UserData sharedUserData].userNewNotifications < 10) {
                newNotiStr = [NSString stringWithFormat:@"%d", [UserData sharedUserData].userNewNotifications];
            } else {
                newNotiStr = @"9+";
            }
            self.notificationBadgeLabel.text = newNotiStr;
        } else {
            self.notificationBadgeContainer.hidden = YES;
        }
        
        
        if (players && players.count) {
            // Set controls with user data
            if ([UserData sharedUserData].userCoins > 999999) {
                self.userCoinsLabel.text = @"+999.999";
            } else {
                NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                formatter.formatterBehavior = NSNumberFormatterBehavior10_4;
                formatter.numberStyle = NSNumberFormatterCurrencyStyle;
                formatter.minimumFractionDigits = 0;
                formatter.maximumFractionDigits = 0;
                NSString *coinsFmt = [formatter stringFromNumber:[NSNumber numberWithLongLong:[UserData sharedUserData].userCoins]];
                coinsFmt = [Util unpriceValue:coinsFmt];
                
                self.userCoinsLabel.text = coinsFmt;  //[NSString stringWithFormat:@"%lld", [UserData sharedUserData].userCoins];
            }
            
            if ([UserData sharedUserData].userExperience < 10) {
                self.userXPLabel.text = @"0";
            } else {
                long long lvl = ([UserData sharedUserData].userExperience - 10) / 30;
                lvl++;
                self.userXPLabel.text = [NSString stringWithFormat:@"%lld", lvl];
            }
            
            // Create sell tab
            self.playersToSellArray = [NSMutableArray arrayWithArray:players];
            self.sellPlayerView = [TransferSellPlayerView initTransferSellPlayerViewWithPlayers:self.playersToSellArray withDelegate:self];
            if (self.firstViewedTab == TransferCenterTabSell) {
                [self.transferTabContainer addSubview:self.sellPlayerView];
                [self.transferBuyButton setImage:self.btnTabBuyNormal forState:UIControlStateNormal];
                [self.transferSellButton setImage:self.btnTabSellHigh forState:UIControlStateNormal];
                [self.transferCoinsButton setImage:self.btnTabMoneyNormal forState:UIControlStateNormal];
            }
        }
    }];
    
    // Request buyable players
    [InitialServices requestBuyablePlayersForUser:userId andToken:token withBlock:^(NSArray *players, NSError *error) {
        if (error) {
            NSString *msgLoc = NSLocalizedString(@"There was an error when trying to get players", nil);
            NSString *msg = [NSString stringWithFormat:@"%@: %@", msgLoc, [error localizedDescription]];
            NSString *msgTitle = NSLocalizedString(@"Players", nil);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:msgTitle
                                                            message:msg
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            return;
        }
        
        if (players && players.count) {
            self.playersToSellArray = [NSMutableArray arrayWithArray:players];
            NSMutableArray *bronzes = [[NSMutableArray alloc] init];
            NSMutableArray *silvers = [[NSMutableArray alloc] init];
            NSMutableArray *golds = [[NSMutableArray alloc] init];
            for (NSDictionary *player in self.playersToSellArray) {
                int playCat = [[player objectForKey:@"category"] intValue];
                switch (playCat) {
                    case PlayerCategoryBronze:
                    {
                        [bronzes addObject:player];
                    }
                        break;
                        
                    case PlayerCategorySilver:
                    {
                        [silvers addObject:player];
                    }
                        break;
                        
                    case PlayerCategoryGold:
                    {
                        [golds addObject:player];
                    }
                        break;
                        
                    default:
                        break;
                }

            }
            self.buyPlayerView = [TransferBuyPlayerView initTransferBuyPlayerViewWithBronzePlayers:bronzes withSilverPlayers:silvers withGoldPlayers:golds withDelegate:self];

            if (self.firstViewedTab == TransferCenterTabBuy) {
                [self.transferTabContainer addSubview:self.buyPlayerView];
                [self.transferBuyButton setImage:self.btnTabBuyHigh forState:UIControlStateNormal];
                [self.transferSellButton setImage:self.btnTabSellNormal forState:UIControlStateNormal];
                [self.transferCoinsButton setImage:self.btnTabMoneyNormal forState:UIControlStateNormal];
            }
        }
        
        [self.loading stopLoading];
    }];

    //Request IAP Products IDs
//    [InitialServices requestIAPProductsForUser:userId andToken:token withBlock:^(NSArray *products, NSError *error) {
//        SKProductsRequest *productsRequest = [[SKProductsRequest alloc]
//                                              initWithProductIdentifiers:[NSSet setWithArray:products]];
//        productsRequest.delegate = self;
//        [productsRequest start];
//    }];
//    [InitialServices requestBuyableProductsForUser:userId andToken:token withBlock:^(NSDictionary *userInfo, NSError *error) {
//        if (error) {
//        }
//        
//        if (userInfo) {
//            self.coinsArray = [NSMutableArray arrayWithArray:[userInfo objectForKey:@"coins_packs"]];
//            self.supergoalsArray = [NSMutableArray arrayWithArray:[userInfo objectForKey:@"super_goal_packs"]];
//            self.packetsArray = [[NSMutableArray alloc] init];
//            for (NSDictionary *coin in self.coinsArray) {
//                NSString *idCoin = [coin objectForKey:@"apple_id"];
//                [self.packetsArray addObject:idCoin];
//            }
//            if (self.packetsArray && self.packetsArray.count) {
//                SKProductsRequest *productsRequest = [[SKProductsRequest alloc]
//                                                      initWithProductIdentifiers:[NSSet setWithArray:self.packetsArray]];
//                productsRequest.delegate = self;
//                [productsRequest start];
//            }
//        }
//    }];
}

- (void)delayedTimerForReloadNotifications
{
    if (self.isVisible) {
        [self loadNotifications];
        [self performSelector:@selector(delayedTimerForReloadNotifications) withObject:nil afterDelay:TIMER_LOAD_PLAYERS];
    }
}

- (void)loadNotifications
{
    NSString *token = GET_USERDEFAULTS(SESSION_TOKEN);
    NSString *userId = GET_USERDEFAULTS(USER_DEVICE_ID);
    
    [InitialServices requestUnreadNotificationsCountForUser:userId andToken:token withBlock:^(NSDictionary *notifications, NSError *error) {
        if (!error) {
            int newNoti = [[notifications objectForKey:@"notifications"] intValue];
            if (newNoti) {
                self.notificationBadgeContainer.hidden = NO;
                NSString *newNotiStr = @"";
                if (newNoti < 10) {
                    newNotiStr = [NSString stringWithFormat:@"%d", newNoti];
                } else {
                    newNotiStr = @"9+";
                }
                self.notificationBadgeLabel.text = newNotiStr;
            } else {
                self.notificationBadgeContainer.hidden = YES;
            }
        }
    }];
}



- (void)fadeInFromNavigation
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:(UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.fullContainer.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                     }];
}

- (void)fadeOutFromNavigation:(BOOL)back
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:(UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.fullContainer.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         if (back) {
                             [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
                             [self.navigationController popViewControllerAnimated:NO];
                         }
                     }];
}

- (void)fadeOutForNavigationToViewController:(UIViewController *)destinationVC isPop:(BOOL)isToPop
{
    self.fullContainer.alpha = 1;
    [UIView animateWithDuration:0.3
                          delay:0
                        options:(UIViewAnimationOptionCurveEaseIn)
                     animations:^{
                         self.fullContainer.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         self.isFadedForNavigation = YES;
                         if (isToPop) {
                             [self.navigationController popToViewController:destinationVC animated:NO];
                         } else {
                             [self.navigationController pushViewController:destinationVC animated:NO];
                         }
                     }];
}


- (void)fadeFromPop
{
    self.fullContainer.alpha = 0;
    [UIView animateWithDuration:0.3
                          delay:0
                        options:(UIViewAnimationOptionCurveEaseIn)
                     animations:^{
                         self.fullContainer.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         self.isFadedForNavigation = NO;
                     }];
}


- (IBAction)tapUpLeaderboard:(id)sender
{
    LeaderboardViewController *leaderboardVC = [[LeaderboardViewController alloc] initLeaderboardViewController];
    leaderboardVC.sinView = self.sinView;
    [self fadeOutForNavigationToViewController:leaderboardVC isPop:NO];
}



- (IBAction)tapUpUserMore:(id)sender
{
    self.firstViewedTab = TransferCenterTabMoney;
    [self crossFadeTabs];
}


- (IBAction)tapUpTransferBuy:(id)sender
{
    [Util trackGAIEventForCategory:@"Btn" action:@"click" label:@"Click Compra Jugadores" value:nil];
    
    self.firstViewedTab = TransferCenterTabBuy;
    [self crossFadeTabs];
}

- (IBAction)tapUpTransferSell:(id)sender
{
    [Util trackGAIEventForCategory:@"Btn" action:@"click" label:@"Click Venta Jugadores" value:nil];
    
    self.firstViewedTab = TransferCenterTabSell;
    [self crossFadeTabs];
}

- (IBAction)tapUpTransferCoins:(id)sender
{
    [Util trackGAIEventForCategory:@"Btn" action:@"click" label:@"Click Compra Monedas" value:nil];
    
    self.firstViewedTab = TransferCenterTabMoney;
    [self crossFadeTabs];
}




- (IBAction)tapUpMenu:(id)sender
{
    [self.homeMenu show];
}


- (IBAction)tapUpNotification:(id)sender
{
    NotificationCenterViewController *notificationCenterVC = [[NotificationCenterViewController alloc] initNotificationCenterViewController];
    [self fadeOutForNavigationToViewController:notificationCenterVC isPop:NO];
}


- (void)crossFadeTabs
{
    switch (self.firstViewedTab) {
        case TransferCenterTabBuy:
        {
            [self.transferBuyButton setImage:self.btnTabBuyHigh forState:UIControlStateNormal];
            [self.transferSellButton setImage:self.btnTabSellNormal forState:UIControlStateNormal];
            [self.transferCoinsButton setImage:self.btnTabMoneyNormal forState:UIControlStateNormal];
            self.selectedTabView = self.buyPlayerView;
            
            [UIView animateWithDuration:0.15
                                  delay:0
                                options:(UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction)
                             animations:^{
                                 yardImage.alpha = 1;
                             }
                             completion:^(BOOL finished) {
                             }];
        }
            break;
            
        case TransferCenterTabSell:
        {
            [self.transferBuyButton setImage:self.btnTabBuyNormal forState:UIControlStateNormal];
            [self.transferSellButton setImage:self.btnTabSellHigh forState:UIControlStateNormal];
            [self.transferCoinsButton setImage:self.btnTabMoneyNormal forState:UIControlStateNormal];
            self.selectedTabView = self.sellPlayerView;
            
            [UIView animateWithDuration:0.15
                                  delay:0
                                options:(UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction)
                             animations:^{
                                 yardImage.alpha = 0;
                             }
                             completion:^(BOOL finished) {
                             }];
        }
            break;
            
        case TransferCenterTabMoney:
        {
            [self.transferBuyButton setImage:self.btnTabBuyNormal forState:UIControlStateNormal];
            [self.transferSellButton setImage:self.btnTabSellNormal forState:UIControlStateNormal];
            [self.transferCoinsButton setImage:self.btnTabMoneyHigh forState:UIControlStateNormal];
            self.selectedTabView = self.moneyView;
            
            [UIView animateWithDuration:0.15
                                  delay:0
                                options:(UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction)
                             animations:^{
                                 yardImage.alpha = 0;
                             }
                             completion:^(BOOL finished) {
                             }];
        }
            break;
            
        default:
            break;
    }

    [UIView animateWithDuration:0.3
                          delay:0
                        options:(UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.buyPlayerView.alpha = 0;
                         self.sellPlayerView.alpha = 0;
                         self.moneyView.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         [self.buyPlayerView removeFromSuperview];
                         [self.sellPlayerView removeFromSuperview];
                         [self.moneyView removeFromSuperview];
                         [self.transferTabContainer addSubview:self.selectedTabView];
                         
                         [UIView animateWithDuration:0.3
                                               delay:0
                                             options:(UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction)
                                          animations:^{
                                              self.selectedTabView.alpha = 1;
                                          }
                                          completion:^(BOOL finished) {
                                          }];
                     }];
}



#pragma mark - AlertView Methods
- (IBAction)tapUpAlertAction:(id)sender
{
    [self hideAlert];
}


- (void)hideAlert
{
    [UIView animateWithDuration:0.2
                          delay:0
                        options:(UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.alertContentContainer.frame = CGRectMake(self.alertContentContainer.frame.origin.x, self.alertContentContainer.frame.size.height, self.alertContentContainer.frame.size.width, self.alertContentContainer.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.2
                                               delay:0
                                             options:(UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction)
                                          animations:^{
                                              self.alertContainer.alpha = 0;
                                          }
                                          completion:^(BOOL finished) {
                                              [self.view sendSubviewToBack:self.alertContainer];
                                              self.alertContainer.hidden = YES;
                                          }];
                     }];
}


- (void)showAlertWithTitle:(NSString *)alertT withMessage:(NSString *)alertM withButtonCaption:(NSString *)alertCap
{
    self.alertContainer.hidden = NO;
    [self.view bringSubviewToFront:self.alertContainer];
    
    self.alertTitle.text = alertT;
    self.alertMessage.text = alertM;
    [self.alertButton setTitle:alertCap forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.2
                          delay:0
                        options:(UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.alertContainer.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.2
                                               delay:0
                                             options:(UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction)
                                          animations:^{
                                              self.alertContentContainer.frame = CGRectMake(self.alertContentContainer.frame.origin.x, 0, self.alertContentContainer.frame.size.width, self.alertContentContainer.frame.size.height);
                                          }
                                          completion:^(BOOL finished) {
                                          }];
                     }];
}


#pragma mark - HomeMenuViewDelegate methods
- (void)homeMenuViewRequestClose:(HomeMenuView *)sender
{
    
}

- (void)homeMenuViewRequestHome:(HomeMenuView *)sender
{
    [self.moneyView leavingTransferMoneyView];
    
    NSArray *viewcontrollers = [self.navigationController viewControllers];
    for (UIViewController *vc in viewcontrollers) {
        if ([vc isKindOfClass:[HomeViewController class]]) {
            [self fadeOutForNavigationToViewController:vc isPop:YES];
            return;
        }
    }
    
    HomeViewController *homeVC = [[HomeViewController alloc] initHomeViewController];
    [self fadeOutForNavigationToViewController:homeVC isPop:NO];
}

- (void)homeMenuViewRequestSettings:(HomeMenuView *)sender
{

}

- (void)homeMenuViewRequestNews:(HomeMenuView *)sender
{
    NewsViewController *newsVC = [[NewsViewController alloc] initNewsViewController];
    newsVC.sinView = self.sinView;
    [self fadeOutForNavigationToViewController:newsVC isPop:NO];
}

- (void)homeMenuViewRequestSocial:(HomeMenuView *)sender
{
    TermsAndConditionsViewController *termsConditionsVC = [[TermsAndConditionsViewController alloc] initTermsAndConditionsViewController];
    termsConditionsVC.sinView = self.sinView;
    [self fadeOutForNavigationToViewController:termsConditionsVC isPop:NO];
}




#pragma mark - TransferBuyPlayerViewDelegate methods
- (void)transferBuyPlayerView:(TransferBuyPlayerView *)sender tryToBuyPlayer:(NSDictionary *)player
{
    long long lvl = 0;
    if ([UserData sharedUserData].userExperience >= 10) {
        lvl = ([UserData sharedUserData].userExperience - 10) / 30;
        lvl++;
    }
    long long playerLevel = [[player objectForKey:@"level"] longLongValue];
    self.playerToBeBuyed = player;
    if (lvl >= playerLevel) {
        for (UIView *vw in self.messageView.popSideView.subviews) {
            [vw removeFromSuperview];
        }
        self.normalBuyLabel.text = [NSString stringWithFormat:@"-%@", [player objectForKey:@"buy_level_price"]];
        NSString *msg = NSLocalizedString(@"YOU ARE ABOUT TO BUY %@ FOR", nil);
        msg = [NSString stringWithFormat:msg, [player objectForKey:@"name"]];
        [self.messageView showWithTitle:NSLocalizedString(@"BUY PLAYER", nil)
                            withMessage:msg
                           withSideView:self.normalBuyContainer
                           withOKButton:NSLocalizedString(@"OK", nil)
                       withCancelButton:NSLocalizedString(@"CANCEL", nil)];
        self.messageView.behaviorFlag = 10;
    } else {
        self.normalBuyLabel.text = [NSString stringWithFormat:@"-%@", [player objectForKey:@"buy_price"]];
        NSString *msg = NSLocalizedString(@"YOU NEED TO BE LEVEL %lld TO BUY THIS PLAYER. YOU CAN BUY IT NOW FOR", nil);
        msg = [NSString stringWithFormat:msg, playerLevel];
        [self.messageView showWithTitle:NSLocalizedString(@"BUY PLAYER", nil)
                            withMessage:msg
                           withSideView:self.normalBuyContainer
                           withOKButton:NSLocalizedString(@"OK", nil)
                       withCancelButton:NSLocalizedString(@"CANCEL", nil)];
        self.messageView.behaviorFlag = 20;
    }

}



#pragma mark - TransferSellPlayerViewDelegate methods
- (void)transferSellPlayerView:(TransferSellPlayerView *)sender tryToSellPlayer:(NSDictionary *)player
{
    for (UIView *vw in self.messageView.popSideView.subviews) {
        [vw removeFromSuperview];
    }
    self.playerToBeSold = player;
    self.normalBuyLabel.text = [NSString stringWithFormat:@"+%@", [player objectForKey:@"sell_price"]];
    NSString *msg = NSLocalizedString(@"ARE YOU SURE ABOUT TO SELL %@?", nil);
    msg = [NSString stringWithFormat:msg, [player objectForKey:@"name"]];
    [self.messageView showWithTitle:NSLocalizedString(@"SELL PLAYER", nil)
                        withMessage:msg
                       withSideView:self.normalBuyContainer
                       withOKButton:NSLocalizedString(@"OK", nil)
                   withCancelButton:NSLocalizedString(@"CANCEL", nil)];
    self.messageView.behaviorFlag = 30;

}

- (void)transferSellPlayerViewRequestBuyPlayer:(TransferSellPlayerView *)sender
{
    [self tapUpTransferBuy:self.transferBuyButton];
}


#pragma mark - TransferMoneyViewDelegate methods
- (void)transferMoneyView:(TransferMoneyView *)sender cancelRequestBy:(NSDictionary *)applicant isIAP:(BOOL)iapPacket
{
    
}

- (void)transferMoneyView:(TransferMoneyView *)sender acceptRequestBy:(NSDictionary *)applicant isIAP:(BOOL)iapPacket
{
    
}

- (void)transferMoneyView:(TransferMoneyView *)sender tryToBuyPacket:(NSDictionary *)packet isIAP:(BOOL)iapPacket
{
    [self.loading startLoading];
    
    if (iapPacket) {
        self.buyablePackSelectedToBuy = packet;
        
        int coins = [[packet objectForKey:@"coins"] intValue];
        NSNumber *packVal = [NSNumber numberWithInt:coins];
        [Util trackGAIEventForCategory:@"Btn" action:@"click" label:@"Comprar Monedas" value:packVal];
        
        SKProduct *skProduct = [packet objectForKey:@"skProduct"];
        
        SKMutablePayment *payment = [SKMutablePayment paymentWithProduct:skProduct];
        
        NSString *userId = GET_USERDEFAULTS(USER_DEVICE_ID);
        NSString *hashed = [Util hashedValueForUserID:userId];
        payment.applicationUsername = hashed;
        
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    } else {
        NSString *token = GET_USERDEFAULTS(SESSION_TOKEN);
        NSString *userId = GET_USERDEFAULTS(USER_DEVICE_ID);
        [PlayGameServices requestBuySupergoals:packet forUser:userId andToken:token withBlock:^(NSMutableDictionary *userInfo, NSError *error) {
            if (error) {
                [self showAlertWithTitle:NSLocalizedString(@"BUY SUPER GOALS", nil) withMessage:NSLocalizedString(@"There was an error trying to buy your super goals pack. Please try again later", nil) withButtonCaption:NSLocalizedString(@"OK", nil)];
            } else {
                NSDictionary *userDic = [userInfo objectForKey:@"user"];
                long long exp = [[userDic objectForKey:@"experience"] longLongValue];
                long long money = [[userDic objectForKey:@"money"] longLongValue];
                long long supergoals = [[userDic objectForKey:@"super_goals"] longLongValue];
                [UserData sharedUserData].userExperience = exp;
                [UserData sharedUserData].userCoins = money;
                [UserData sharedUserData].userSuperGoals = supergoals;
                
                if ([UserData sharedUserData].userCoins > 999999) {
                    self.userCoinsLabel.text = @"+999.999";
                } else {
                    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                    formatter.formatterBehavior = NSNumberFormatterBehavior10_4;
                    formatter.numberStyle = NSNumberFormatterCurrencyStyle;
                    formatter.minimumFractionDigits = 0;
                    formatter.maximumFractionDigits = 0;
                    NSString *coinsFmt = [formatter stringFromNumber:[NSNumber numberWithLongLong:[UserData sharedUserData].userCoins]];
                    coinsFmt = [Util unpriceValue:coinsFmt];

                    self.userCoinsLabel.text = coinsFmt;  //[NSString stringWithFormat:@"%lld", [UserData sharedUserData].userCoins];
                }

                [self showAlertWithTitle:NSLocalizedString(@"BUY SUPER GOALS", nil) withMessage:NSLocalizedString(@"Well done! You have now your super goals in your account to use them now!", nil) withButtonCaption:NSLocalizedString(@"OK", nil)];
            }
            
            [self.loading stopLoading];
        }];
    }
}


- (void)transferMoneyView:(TransferMoneyView *)sender tryToWatchADCVideo:(NSString *)zoneId isIAP:(BOOL)iapPacket
{
    NSString *adColonySupergoals = ADCOLONY_SUPERGOAL_ZONE_ID;
//    NSString *adColonyCoins = ADCOLONY_COINS_ZONE_ID;

    if ([zoneId isEqualToString:adColonySupergoals]) {
        [Util trackGAIEventForCategory:@"Btn" action:@"click" label:@"Click Supergol Free" value:nil];
    } else {
        [Util trackGAIEventForCategory:@"Btn" action:@"click" label:@"Click Monedas Free" value:nil];
    }
    
    
    NSLog(@"adcolony custom id: %@", [AdColony getCustomID]);
    [AdColony playVideoAdForZone:zoneId
                    withDelegate:self
                withV4VCPrePopup:YES
                andV4VCPostPopup:YES];
    self.adcVideoStarting = NO;
}


#pragma mark - AdColonyAdDelegate methods
- (void)onAdColonyAdAttemptFinished:(BOOL)shown inZone:(NSString *)zoneID
{
    NSLog(@"adcolony attempt finished: %d %@", shown, zoneID);
    if (!self.adcVideoStarting && !shown) {
        for (UIView *vw in self.messageView.popSideView.subviews) {
            [vw removeFromSuperview];
        }
        UILabel *sideLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.messageView.popSideView.frame.size.width, self.messageView.popSideView.frame.size.height)];
        sideLabel.font = FONT_REGULAR(12);
        sideLabel.numberOfLines = 2;
        sideLabel.textColor = [UIColor whiteColor];
        sideLabel.text = NSLocalizedString(@"PLEASE COME BACK TOMORROW FOR MORE REWARDS", nil);
        NSString *msg = NSLocalizedString(@"YOU REACHED THE DAILY VIDEO LIMITS", nil);
        [self.messageView showWithTitle:NSLocalizedString(@"VIDEO REWARDS", nil)
                            withMessage:msg
                           withSideView:sideLabel
                           withOKButton:NSLocalizedString(@"OK", nil)
                       withCancelButton:nil];
        self.messageView.behaviorFlag = 50;
    } else {
        [self performSelector:@selector(tapUpTransferCoins:) withObject:nil afterDelay:0.7];
//        [self tapUpTransferCoins:self.transferCoinsButton];
    }
}

- (void)onAdColonyAdStartedInZone:(NSString *)zoneID
{
    NSLog(@"adcolony started: %@", zoneID);
    self.adcVideoStarting = YES;
}


#pragma mark - PopUpMessageViewDelegate methods
- (void)popUpMessageViewDidTouchCancel:(PopUpMessageView *)view
{
    self.playerToBeBuyed = nil;
}

- (void)popUpMessageViewDidTouchOK:(PopUpMessageView *)view
{
    NSString *token = GET_USERDEFAULTS(SESSION_TOKEN);
    NSString *userId = GET_USERDEFAULTS(USER_DEVICE_ID);

    if (view.behaviorFlag == 10 || view.behaviorFlag == 20) {
        if (self.playerToBeBuyed) {
            [self.loading startLoading];
            
            NSString *labelGAI = [NSString stringWithFormat:@"Click Comprar Diálogo Aceptar (%@)", [self.playerToBeBuyed objectForKey:@"name"]];
            [Util trackGAIEventForCategory:@"Btn" action:@"click" label:labelGAI value:nil];
            
            [PlayGameServices requestBuyPlayer:self.playerToBeBuyed forUser:userId andToken:token withBlock:^(NSMutableDictionary *userInfo, NSError *error) {
                if (error) {
                    [self.loading stopLoading];
                    
                    [self performSelector:@selector(delayedShowBuyMoreCoinsMessage) withObject:nil afterDelay:0.15];
                }
                
                if (userInfo) {
                    [self loadTransferData];
                }
                
            }];
        }
    } else if (view.behaviorFlag == 30) {
        [self.loading startLoading];
        [PlayGameServices requestSellPlayer:self.playerToBeSold forUser:userId andToken:token withBlock:^(NSMutableDictionary *userInfo, NSError *error) {
            if (error) {
                [self.loading stopLoading];
            }
            
            if (userInfo) {
                [self loadTransferData];
            }
        }];
    } else if (view.behaviorFlag == 50) {
        [self tapUpTransferCoins:self.transferCoinsButton];
    }
}


- (void)delayedShowBuyMoreCoinsMessage
{
    for (UIView *vw in self.messageView.popSideView.subviews) {
        [vw removeFromSuperview];
    }
    UILabel *sideLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.messageView.popSideView.frame.size.width, self.messageView.popSideView.frame.size.height)];
    sideLabel.font = FONT_REGULAR(13);
    sideLabel.numberOfLines = 2;
    sideLabel.textColor = [UIColor whiteColor];
    sideLabel.text = NSLocalizedString(@"DO YOU WANT TO BUY MORE COINS?", nil);
    NSString *msg = NSLocalizedString(@"YOU DON'T HAVE ENOUGH COINS TO BUY HIM", nil);
    [self.messageView showWithTitle:NSLocalizedString(@"BUY PLAYER", nil)
                        withMessage:msg
                       withSideView:sideLabel
                       withOKButton:NSLocalizedString(@"OK", nil)
                   withCancelButton:NSLocalizedString(@"CANCEL", nil)];
    self.messageView.behaviorFlag = 50;

}


#pragma mark - SKPaymentTransactionObserver methods
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchasing:
            {
                NSLog(@"transaction %@ is purchasing", transaction.transactionIdentifier);

                [self.loading startLoading];
            }
                break;
                
            case SKPaymentTransactionStatePurchased:
            {
                NSLog(@"transaction %@ is purchased", transaction.transactionIdentifier);
                
                // TODO: Call server functionality to report the successful transaction
                // so the server will assign the recently purchased product to the given user

                NSData *receiptData = [NSData dataWithBytes:(uint8_t *)transaction.transactionReceipt.bytes
                                                     length:transaction.transactionReceipt.length];
                NSString *jsonObjectString = [Util base64forData:receiptData];
                
                // Create the POST request payload.
                NSString *payload = [NSString stringWithFormat:@"{\"receipt-data\" : \"%@\", \"password\" : \"%@\"}",
                                     jsonObjectString, ITC_CONTENT_PROVIDER_SHARED_SECRET];
                
                NSData *payloadData = [payload dataUsingEncoding:NSUTF8StringEncoding];
                
                NSString *payloadBase64 = [Util base64forData:payloadData];

                NSLog(@"Payload Base64: %@", payloadBase64);
                
                NSString *token = GET_USERDEFAULTS(SESSION_TOKEN);
                NSString *userId = GET_USERDEFAULTS(USER_DEVICE_ID);

                BOOL validPack = NO;
                
                if (self.buyablePackSelectedToBuy) {
                    SKProduct *skProduct = [self.buyablePackSelectedToBuy objectForKey:@"skProduct"];

                    if (skProduct) {
                        NSString *packId = skProduct.productIdentifier;
                        NSString *paymentPackId = transaction.payment.productIdentifier;
                        if ([packId isEqualToString:paymentPackId]) {
                            validPack = YES;
                            
                            // The transaction appears to be valid, let's check with Apple
                            [[VerificationController sharedInstance] verifyPurchase:transaction completionHandler:^(BOOL success) {
                                if (success) {
                                    // The purchase was validated by Apple and the transaction is OK!
                                    [PlayGameServices requestBuyablePackToWofa:self.buyablePackSelectedToBuy forUser:userId andToken:token andReceipt:payloadBase64 withBlock:^(NSMutableDictionary *userInfo, NSError *error) {
                                        if (error) {
                                            // At the end, we finish the transaction and remove the observer reporting the error
//                                            [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
//                                            
//                                            if (![[SKPaymentQueue defaultQueue] transactions].count) {
//                                                [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
//                                            }

                                            [self.loading stopLoading];
                                            
                                            [self showAlertWithTitle:NSLocalizedString(@"BUY COINS", nil) withMessage:NSLocalizedString(@"There was a problem trying to get the coins pack. Your purchase was made and we will restore you the coins at once!", nil) withButtonCaption:NSLocalizedString(@"OK", nil)];
                                            
                                            NSString *msg = [NSString stringWithFormat:@"Wofa error: %@.\rUserId: %@ | transaction: %@", [error localizedDescription], userId, transaction.transactionIdentifier];
                                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Wofa"
                                                                                            message:msg
                                                                                           delegate:nil
                                                                                  cancelButtonTitle:@"OK"
                                                                                  otherButtonTitles:nil];
                                            [alert show];
                                        } else {
                                            // At the end, we finish the transaction and remove the observer reporting the error
                                            [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                                            
                                            if (![[SKPaymentQueue defaultQueue] transactions].count) {
                                                [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
                                            }
                                            
                                            NSDictionary *userDt = [userInfo objectForKey:@"user"];
                                            long long coins = [[userDt objectForKey:@"money"] longLongValue];
                                            [UserData sharedUserData].userCoins = coins;
                                            
                                            if ([UserData sharedUserData].userCoins > 999999) {
                                                self.userCoinsLabel.text = @"+999.999";
                                            } else {
                                                NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                                                formatter.formatterBehavior = NSNumberFormatterBehavior10_4;
                                                formatter.numberStyle = NSNumberFormatterCurrencyStyle;
                                                formatter.minimumFractionDigits = 0;
                                                formatter.maximumFractionDigits = 0;
                                                NSString *coinsFmt = [formatter stringFromNumber:[NSNumber numberWithLongLong:[UserData sharedUserData].userCoins]];
                                                coinsFmt = [Util unpriceValue:coinsFmt];
                                                
                                                self.userCoinsLabel.text = coinsFmt;  //[NSString stringWithFormat:@"%lld", [UserData sharedUserData].userCoins];
                                            }

                                            [self.loading stopLoading];
                                            
                                            [self showAlertWithTitle:NSLocalizedString(@"BUY COINS", nil) withMessage:NSLocalizedString(@"Congratulations! You got your coins and they will be added to your account's coins!", nil) withButtonCaption:NSLocalizedString(@"OK", nil)];
                                        }
                                    }];
                                } else {
                                    // The purchase couldn't be validated. Something is wrong with the transaction (Theft)
                                    [self.loading stopLoading];

                                    NSString *msg = NSLocalizedString(@"Apple couldn't validate your Purchase. Please verify your iTunes credentials", nil);
                                    [self showAlertWithTitle:NSLocalizedString(@"BUY COINS", nil) withMessage:msg withButtonCaption:NSLocalizedString(@"OK", nil)];
                                }
                            }];
                        }
                    }
                }
                
                if (!validPack) {
                    // At the end, we finish the transaction and remove the observer reporting the error
                    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                    
                    if (![[SKPaymentQueue defaultQueue] transactions].count) {
                        [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
                    }
                    
                    [self.loading stopLoading];
                    
                    [self showAlertWithTitle:NSLocalizedString(@"BUY COINS", nil) withMessage:NSLocalizedString(@"The package couldn't be verified. Please check your credentials and relaunch Wofa Golden Boot", nil) withButtonCaption:NSLocalizedString(@"OK", nil)];
                }

                
            }
                break;
                
            case SKPaymentTransactionStateFailed:
            {
                NSLog(@"transaction %@ has failed", transaction.transactionIdentifier);
                
                // TODO: report to the user the error and inform about the transaction failed
                NSString *msg = [NSString stringWithFormat:@"Transaction %@ Error: %@", transaction.transactionIdentifier, [transaction.error localizedDescription]];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"IAP Error"
                                                                message:msg
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];

                // At the end, we finish the transaction and remove the observer
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                
                if (![[SKPaymentQueue defaultQueue] transactions].count) {
                    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
                }
                
                [self.loading stopLoading];
                
                [self showAlertWithTitle:NSLocalizedString(@"BUY COINS", nil) withMessage:NSLocalizedString(@"There was a problem trying to buy the coins pack. Your purchase couldn't complete. Please make sure you have an Apple ID and you have credit to make purchases, and try again later", nil) withButtonCaption:NSLocalizedString(@"OK", nil)];
            }
                break;
                
            default:
            {
                NSLog(@"transaction %@ has status: %d", transaction.transactionIdentifier, transaction.transactionState);
            }
                break;
        }
    }
}


@end
