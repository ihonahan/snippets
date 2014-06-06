//
//  TransferMoneyView.h
//  wofa
//
//  Created by Ihonahan Buitrago on 23/02/14.
//  Copyright (c) 2014 ByYuto. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Util.h"

#import "ApplicantsCoinsCell.h"

#import "BuyablePacketView.h"
#import "ChooseFBFriendsView.h"

#import "InitialServices.h"
#import "PlayGameServices.h"

#import "PopUpMessageView.h"

#import "AppDelegate.h"

#import <StoreKit/StoreKit.h>

#import <AdColony/AdColony.h>

#import <FacebookSDK/FacebookSDK.h>
#import "FBWebDialogs.h"

#import "CentralAudio.h"


#import "MergeAccountsView.h"


@protocol TransferMoneyViewDelegate;


@interface TransferMoneyView : UIView <UITableViewDataSource, UITableViewDelegate, ApplicantsCoinsCellDelegate, BuyablePacketViewDelegate, SKProductsRequestDelegate, ChooseFBFriendsViewDelegate, PopUpMessageViewDelegate, WofaAppFBDelegate, MergeAccountsViewDelegate>

@property(strong) IBOutlet UIView *fullContainer;
@property(strong) IBOutlet UIScrollView *packetsScroller;

@property(strong) IBOutlet UIView *coinsRequestContainer;
@property(strong) IBOutlet UIImageView *coinsRequestBackground;
@property(strong) IBOutlet UILabel *coinsRequestLabel;
@property(strong) IBOutlet UIButton *coinsToggleButton;
@property(strong) IBOutlet UIView *coinsApplicantsContainer;
@property(strong) IBOutlet UIButton *requestCoinsButton;
@property(strong) IBOutlet UITableView *applicantsTable;
@property(strong) IBOutlet UIView *coinsFBLoginContainer;
@property(strong) IBOutlet UIButton *fbLoginButton;

@property(weak) id<TransferMoneyViewDelegate> delegate;


- (IBAction)tapUpCoinsToggle:(id)sender;
- (IBAction)tapUpRequestCoins:(id)sender;

- (IBAction)tapUpFBLogin:(id)sender;


+ (TransferMoneyView *)initTransferMoneyViewWithPackets:(NSArray *)thePackets withSuperGoals:(NSArray *)theSupergoals withApplicants:(NSArray *)theApplicants withDelegate:(id<TransferMoneyViewDelegate>)theDelegate;

+ (TransferMoneyView *)initTransferMoneyViewWithDelegate:(id<TransferMoneyViewDelegate>)theDelegate;


- (void)leavingTransferMoneyView;


@end


@protocol TransferMoneyViewDelegate <NSObject>

@optional
- (void)transferMoneyViewDidRequestCoins:(TransferMoneyView *)sender;
- (void)transferMoneyView:(TransferMoneyView *)sender tryToBuyPacket:(NSDictionary *)packet isIAP:(BOOL)iapPacket;
- (void)transferMoneyView:(TransferMoneyView *)sender acceptRequestBy:(NSDictionary *)applicant isIAP:(BOOL)iapPacket;
- (void)transferMoneyView:(TransferMoneyView *)sender cancelRequestBy:(NSDictionary *)applicant isIAP:(BOOL)iapPacket;
- (void)transferMoneyView:(TransferMoneyView *)sender tryToWatchADCVideo:(NSString *)zoneId isIAP:(BOOL)iapPacket;

- (void)transferMoneyViewDidStartFriendsRequest:(TransferMoneyView *)sender;
- (void)transferMoneyViewDidFinishFriendsRequest:(TransferMoneyView *)sender;
- (void)transferMoneyViewDidFailFriendsRequest:(TransferMoneyView *)sender;

@end