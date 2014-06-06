//
//  TransferMoneyView.m
//  wofa
//
//  Created by Ihonahan Buitrago on 23/02/14.
//  Copyright (c) 2014 ByYuto. All rights reserved.
//

#import "TransferMoneyView.h"

#import "LoadingView.h"


@interface TransferMoneyView()

@property(strong) NSMutableArray *packetsArray;
@property(strong) NSMutableArray *coinsArray;
@property(strong) NSMutableArray *supergoalsArray;
@property(strong) NSMutableArray *adColonyArray;
@property(strong) NSMutableArray *applicantsArray;
@property(assign) BOOL isRequestVisible;
@property(assign) CGFloat coinsRequestOriginalY;
@property(assign) CGFloat coinsRequestUpY;

@property(strong) NSMutableArray *buyablePacketViews;
@property(strong) NSMutableArray *adcPacketViews;

@property(strong) ChooseFBFriendsView *chooseFBFriends;

@property(strong) PopUpMessageView *messageView;

@property(strong) AppDelegate *appDelegate;

@property(strong) LoadingView *loading;

@property(weak) id<WofaAppFBDelegate> previousDelegate;

@property(strong)  NSString *fbid;
@property(strong)  NSString *fname;
@property(strong)  NSString *lname;
@property(strong)  NSString *fbToken;
@property(strong)  NSString *email;


@property(strong) MergeAccountsView *mergeView;


- (void)setupTransferMoneyViewWithPackets:(NSArray *)thePackets withSuperGoals:(NSArray *)theSupergoals withApplicants:(NSArray *)theApplicants withDelegate:(id<TransferMoneyViewDelegate>)theDelegate;

- (void)setupTransferMoneyViewWithDelegate:(id<TransferMoneyViewDelegate>)theDelegate;

@end


@implementation TransferMoneyView


@synthesize fullContainer;
@synthesize packetsScroller;
@synthesize coinsRequestContainer;
@synthesize coinsRequestBackground;
@synthesize coinsRequestLabel;
@synthesize coinsToggleButton;
@synthesize requestCoinsButton;
@synthesize applicantsTable;
@synthesize coinsApplicantsContainer;
@synthesize coinsFBLoginContainer;
@synthesize fbLoginButton;
@synthesize delegate;

@synthesize packetsArray;
@synthesize coinsArray;
@synthesize supergoalsArray;
@synthesize adColonyArray;
@synthesize applicantsArray;
@synthesize isRequestVisible;
@synthesize coinsRequestOriginalY;
@synthesize coinsRequestUpY;
@synthesize chooseFBFriends;
@synthesize messageView;
@synthesize appDelegate;

@synthesize buyablePacketViews;
@synthesize adcPacketViews;
@synthesize loading;
@synthesize previousDelegate;
@synthesize fbid;
@synthesize fbToken;
@synthesize fname;
@synthesize lname;
@synthesize email;
@synthesize mergeView;


+ (TransferMoneyView *)initTransferMoneyViewWithPackets:(NSArray *)thePackets withSuperGoals:(NSArray *)theSupergoals withApplicants:(NSArray *)theApplicants withDelegate:(id<TransferMoneyViewDelegate>)theDelegate
{
    NSString *nibName = nil;
    if (IS_IPAD) {
        nibName = @"TransferMoneyView_ipad";
    } else {
        nibName = @"TransferMoneyView";
    }
    
    NSArray *xibsArray = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
    if (xibsArray && xibsArray.count) {
        TransferMoneyView *view = [xibsArray objectAtIndex:0];
        
        [view setupTransferMoneyViewWithPackets:thePackets withSuperGoals:theSupergoals withApplicants:theApplicants withDelegate:theDelegate];
        
        return view;
    }
    
    return nil;
}


- (void)setupTransferMoneyViewWithPackets:(NSArray *)thePackets withSuperGoals:(NSArray *)theSupergoals withApplicants:(NSArray *)theApplicants withDelegate:(id<TransferMoneyViewDelegate>)theDelegate
{
    self.applicantsArray = [NSMutableArray arrayWithArray:theApplicants];
    self.packetsArray = [NSMutableArray arrayWithArray:thePackets];
    self.supergoalsArray = [NSMutableArray arrayWithArray:theSupergoals];
    self.delegate = theDelegate;
    
    self.applicantsTable.delegate = self;
    self.applicantsTable.dataSource = self;
    
    if (IS_IPAD) {
        self.coinsRequestOriginalY = 291;
        self.coinsRequestUpY = 153;
    } else {
        self.coinsRequestOriginalY = 291;
        self.coinsRequestUpY = 153;
    }

    // Loading view
    self.loading = [[LoadingView alloc] initLoadingViewWithSuperView:self];
    [self.loading stopLoading];

    UIImage *rawBgImg = [UIImage imageNamed:@"centro_trans_ios-16.png"];
    rawBgImg = [Util imageWithImage:rawBgImg scaledToSize:CGSizeMake(385, 159)];
    UIEdgeInsets edgesBg;
    edgesBg.top = 50;
    edgesBg.bottom = 20;
    edgesBg.left = 80;
    edgesBg.right = 20;
    UIImage *bgImg = [rawBgImg resizableImageWithCapInsets:edgesBg resizingMode:UIImageResizingModeTile];
    self.coinsRequestBackground.image = bgImg;

    UIImage *rawNoLoginButton = [UIImage imageNamed:@"Inicio_ios-32.png"];
    rawNoLoginButton = [Util imageWithImage:rawNoLoginButton scaledToSize:CGSizeMake(100, 43)];
    UIEdgeInsets edgesNo;
    edgesNo.top = 21;
    edgesNo.bottom = 21;
    edgesNo.left = 35;
    edgesNo.right = 35;
    UIImage *noLoginBtnImg = [rawNoLoginButton resizableImageWithCapInsets:edgesNo resizingMode:UIImageResizingModeTile];
    [self.requestCoinsButton setBackgroundImage:noLoginBtnImg forState:UIControlStateNormal];
    [self.requestCoinsButton setTitle:NSLocalizedString(@"REQUEST COINS", nil) forState:UIControlStateNormal];
    
    self.requestCoinsButton.titleLabel.font = FONT_BOLD(11);

    self.coinsRequestLabel.text = NSLocalizedString(@"COINS REQUEST", nil);
    self.coinsRequestLabel.font = FONT_REGULAR(15);
    
    [self.applicantsTable reloadData];
    
    self.chooseFBFriends = [ChooseFBFriendsView initChooseFBFriendsViewWithDelegate:self];
    [self addSubview:self.chooseFBFriends];
    [self.chooseFBFriends hideNoAnim];
    
    // Message View
    self.messageView = [PopUpMessageView initPopUpMessageViewWithParentView:self andDelegate:self];
    
    // App's delegate
    self.appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

}




+ (TransferMoneyView *)initTransferMoneyViewWithDelegate:(id<TransferMoneyViewDelegate>)theDelegate
{
    NSString *nibName = nil;
    if (IS_IPAD) {
        nibName = @"TransferMoneyView_ipad";
    } else {
        nibName = @"TransferMoneyView";
    }
    
    NSArray *xibsArray = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
    if (xibsArray && xibsArray.count) {
        TransferMoneyView *view = [xibsArray objectAtIndex:0];
        
        [view setupTransferMoneyViewWithDelegate:theDelegate];
        
        return view;
    }
    
    return nil;
}

- (void)setupTransferMoneyViewWithDelegate:(id<TransferMoneyViewDelegate>)theDelegate
{
    self.delegate = theDelegate;
    
    self.applicantsTable.delegate = self;
    self.applicantsTable.dataSource = self;
    self.applicantsTable.backgroundColor = [UIColor clearColor];
    
    if (IS_IPAD) {
        self.coinsRequestOriginalY = 291;
        self.coinsRequestUpY = 153;
    } else {
        self.coinsRequestOriginalY = 291;
        self.coinsRequestUpY = 153;
    }
    
    UIImage *rawBgImg = [UIImage imageNamed:@"centro_trans_ios-16.png"];
    rawBgImg = [Util imageWithImage:rawBgImg scaledToSize:CGSizeMake(385, 159)];
    UIEdgeInsets edgesBg;
    edgesBg.top = 50;
    edgesBg.bottom = 20;
    edgesBg.left = 80;
    edgesBg.right = 20;
    UIImage *bgImg = [rawBgImg resizableImageWithCapInsets:edgesBg resizingMode:UIImageResizingModeTile];
    self.coinsRequestBackground.image = bgImg;
    
    UIImage *rawNoLoginButton = [UIImage imageNamed:@"Inicio_ios-32.png"];
    rawNoLoginButton = [Util imageWithImage:rawNoLoginButton scaledToSize:CGSizeMake(100, 43)];
    UIEdgeInsets edgesNo;
    edgesNo.top = 21;
    edgesNo.bottom = 21;
    edgesNo.left = 35;
    edgesNo.right = 35;
    UIImage *noLoginBtnImg = [rawNoLoginButton resizableImageWithCapInsets:edgesNo resizingMode:UIImageResizingModeTile];
    [self.requestCoinsButton setBackgroundImage:noLoginBtnImg forState:UIControlStateNormal];
    [self.requestCoinsButton setTitle:NSLocalizedString(@"REQUEST COINS", nil) forState:UIControlStateNormal];
    
    self.requestCoinsButton.titleLabel.font = FONT_BOLD(11);
    
    self.coinsRequestLabel.text = NSLocalizedString(@"COINS REQUEST", nil);
    self.coinsRequestLabel.font = FONT_REGULAR(15);
    
    NSString *token = GET_USERDEFAULTS(SESSION_TOKEN);
    NSString *userId = GET_USERDEFAULTS(USER_DEVICE_ID);

    self.buyablePacketViews = [[NSMutableArray alloc] init];
    self.adcPacketViews = [[NSMutableArray alloc] init];
    
    //Packets and buyable stuff
    [InitialServices requestBuyableProductsForUser:userId andToken:token withBlock:^(NSDictionary *userInfo, NSError *error) {
        if (error) {
        }
        
        if (userInfo) {
            // ADC Packets Data
            self.adColonyArray = [[NSMutableArray alloc] init];
            NSString *adcSucc = GET_USERDEFAULTS(ADCOLONY_CALLBACK_SUCCESS);
            BOOL adcSuccess = [adcSucc boolValue];
            
            if (adcSuccess) {
                NSString *adColonySupergoals = ADCOLONY_SUPERGOAL_ZONE_ID;
                NSString *adColonyCoins = ADCOLONY_COINS_ZONE_ID;
                ADCOLONY_ZONE_STATUS supergoalStatus = [AdColony zoneStatusForZone:adColonySupergoals];
                ADCOLONY_ZONE_STATUS coinsStatus = [AdColony zoneStatusForZone:adColonyCoins];
                
                NSDictionary *adcGoalPackData = nil;
                NSDictionary *adcCoinsData = nil;
                if (supergoalStatus != ADCOLONY_ZONE_STATUS_NO_ZONE && supergoalStatus != ADCOLONY_ZONE_STATUS_OFF) {
                    adcGoalPackData = [NSDictionary dictionaryWithObjectsAndKeys:
                                       @"1", @"points",
                                       @"0", @"coins",
                                       @"0", @"iap",
                                       @"0", @"image_num",
                                       adColonySupergoals, @"ADCZoneID",
                                       nil];
                    [self.adColonyArray addObject:adcGoalPackData];
                }
                
                if (coinsStatus != ADCOLONY_ZONE_STATUS_NO_ZONE && coinsStatus != ADCOLONY_ZONE_STATUS_OFF) {
                    adcCoinsData = [NSDictionary dictionaryWithObjectsAndKeys:
                                    @"15", @"coins",
                                    @"0", @"price",
                                    @"1", @"iap",
                                    @"0", @"image_num",
                                    @"15", @"coins_formatted",
                                    adColonyCoins, @"ADCZoneID",
                                    nil];
                    [self.adColonyArray addObject:adcCoinsData];
                }
                
            }
            
            
            // Buyable Packets Data
            self.packetsArray = [NSMutableArray arrayWithArray:[userInfo objectForKey:@"coins_packs"]];
            self.supergoalsArray = [NSMutableArray arrayWithArray:[userInfo objectForKey:@"super_goal_packs"]];
            self.coinsArray = [[NSMutableArray alloc] init];
            for (NSDictionary *coin in self.packetsArray) {
                NSString *idCoin = [coin objectForKey:@"apple_id"];
                [self.coinsArray addObject:idCoin];
            }
            if (self.coinsArray && self.coinsArray.count) {
                SKProductsRequest *productsRequest = [[SKProductsRequest alloc]
                                                      initWithProductIdentifiers:[NSSet setWithArray:self.coinsArray]];
                productsRequest.delegate = self;
                [productsRequest start];
            }
            
            NSDictionary *userDt = [userInfo objectForKey:@"user"];
            [UserData sharedUserData].userCoins = [[userDt objectForKey:@"money"] longLongValue];
        }
    }];

    [self loadCoinsRequestTable];
    
    if (!IS_IPAD) {
        if (!IS_IPHONE_4INCH) {
            self.packetsScroller.frame = CGRectMake(self.packetsScroller.frame.origin.x,
                                                       self.packetsScroller.frame.origin.y,
                                                       480,
                                                       self.packetsScroller.frame.size.height);
        }
    }

    // Buttons images
    UIImage *rawFBLoginButton = [UIImage imageNamed:@"Inicio_ios-06.png"];
    rawFBLoginButton = [Util imageWithImage:rawFBLoginButton scaledToSize:CGSizeMake(131, 49)];
    UIEdgeInsets edgesFB;
    edgesFB.top = 24;
    edgesFB.bottom = 24;
    edgesFB.left = 80;
    edgesFB.right = 30;
    UIImage *fbLoginBtnImg = [rawFBLoginButton resizableImageWithCapInsets:edgesFB resizingMode:UIImageResizingModeTile];
    [self.fbLoginButton setBackgroundImage:fbLoginBtnImg forState:UIControlStateNormal];
    NSString *fbbtnStr = NSLocalizedString(@"REGISTER WITH FACEBOOK", nil);
    [self.fbLoginButton setTitle:fbbtnStr forState:UIControlStateNormal];
    self.fbLoginButton.titleLabel.font = FONT_BOLD(13);

    NSString *isgStr = GET_USERDEFAULTS(USER_IS_GUEST);
    bool isguest = [isgStr boolValue];

    if (isguest) {
        self.coinsApplicantsContainer.hidden = YES;
        self.coinsFBLoginContainer.hidden = NO;
        self.appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        self.previousDelegate = self.appDelegate.fbDelegate;
        self.appDelegate.fbDelegate = self;
    } else {
        self.coinsApplicantsContainer.hidden = NO;
        self.coinsFBLoginContainer.hidden = YES;
        self.chooseFBFriends = [ChooseFBFriendsView initChooseFBFriendsViewWithDelegate:self];
        [self addSubview:self.chooseFBFriends];
        [self.chooseFBFriends hideNoAnim];
        
    }
    
    // Message View
    self.messageView = [PopUpMessageView initPopUpMessageViewWithParentView:self andDelegate:self];
    
}

- (void)loadCoinsRequestTable
{
    [self.loading startLoading];
    
    NSString *token = GET_USERDEFAULTS(SESSION_TOKEN);
    NSString *userId = GET_USERDEFAULTS(USER_DEVICE_ID);

    [PlayGameServices requestGetCoinsRequestsForUser:userId andToken:token withBlock:^(NSMutableDictionary *userInfo, NSError *error) {
        if (error) {
        }
        if (userInfo) {
            NSArray *coinsRequestArray = [userInfo objectForKey:@"coin_requests"];
            self.applicantsArray = [[NSMutableArray alloc] init];
            for (NSDictionary *item in coinsRequestArray) {
                NSMutableDictionary *applicant = [NSMutableDictionary dictionaryWithDictionary:item];
                [applicant setValue:[userInfo objectForKey:@"amount"] forKey:@"coins"];
                [self.applicantsArray addObject:applicant];
            }
            [self.applicantsTable reloadData];
        }
        
        [self.loading stopLoading];
    }];
}


- (void)leavingTransferMoneyView
{
    self.appDelegate.fbDelegate = self.previousDelegate;
}


- (IBAction)tapUpCoinsToggle:(id)sender
{
    self.isRequestVisible = !self.isRequestVisible;
    if (self.isRequestVisible) {
        [self showCoinsRequest];
    } else {
        [self hideCoinsRequest];
    }
}


- (IBAction)tapUpRequestCoins:(id)sender
{
    [[CentralAudio sharedCentralAudio] playHitButton];

    NSString *fbidStr = GET_USERDEFAULTS(USER_FACEBOOK_ID);
    
    if (fbidStr && ![fbidStr isEqualToString:@""]) {
        if (self.chooseFBFriends) {
            [self.chooseFBFriends show];
            
            [Util trackGAIEventForCategory:@"Btn" action:@"click" label:@"Click Pedir Monedas" value:nil];
        }
    } else {
        self.messageView.behaviorFlag = 10;
        UILabel *sideLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.messageView.popSideView.frame.size.width, self.messageView.popSideView.frame.size.height)];
        sideLabel.font = FONT_REGULAR(13);
        sideLabel.numberOfLines = 2;
        sideLabel.textColor = [UIColor whiteColor];
        sideLabel.text = @" ";  //  NSLocalizedString(@"DO YOU WANT TO DO IT NOW?", nil);
        [self.messageView showWithTitle:NSLocalizedString(@"FACEBOOK", nil)
                            withMessage:NSLocalizedString(@"YOU DIDN'T CONNECT YOUR FACEBOOK ACCOUNT WITH WOFA", nil)
                           withSideView:nil  //  sideLabel
                           withOKButton:NSLocalizedString(@"OK", nil)
                       withCancelButton:NSLocalizedString(@"CANCEL", nil)];
    }
}



- (void)hideCoinsRequest
{
    [UIView animateWithDuration:0.2
                          delay:0
                        options:(UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.coinsRequestContainer.frame = CGRectMake(self.coinsRequestContainer.frame.origin.x, self.coinsRequestOriginalY, self.coinsRequestContainer.frame.size.width, self.coinsRequestContainer.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                     }];
}

- (void)showCoinsRequest
{
    [UIView animateWithDuration:0.2
                          delay:0
                        options:(UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.coinsRequestContainer.frame = CGRectMake(self.coinsRequestContainer.frame.origin.x, self.coinsRequestUpY, self.coinsRequestContainer.frame.size.width, self.coinsRequestContainer.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                     }];
}



- (IBAction)tapUpFBLogin:(id)sender
{
    [self.loading startLoading];
    
    [[CentralAudio sharedCentralAudio] playHitButton];
    
    [self.appDelegate openFBSession];
}



#pragma mark - UITableView delegate datasource methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.applicantsArray) {
        return self.applicantsArray.count;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ApplicantsCoinsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ApplicantsCoinsCell"];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ApplicantsCoinsCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSDictionary *applicant = [self.applicantsArray objectAtIndex:indexPath.row];
    
    [cell setupCellWithApplicant:applicant andDelegate:self];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ApplicantsCoinsCell *cell = (ApplicantsCoinsCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO animated:YES];
}


#pragma mark - ApplicantsCoinsCellDelegate methods
- (void)applicantsCoinsCell:(ApplicantsCoinsCell *)sender cancelledApplicant:(NSDictionary *)theApplicant
{
    [self.loading startLoading];
    long long idReq = [[sender.applicant objectForKey:@"id"] longLongValue];
    NSString *token = GET_USERDEFAULTS(SESSION_TOKEN);
    NSString *userId = GET_USERDEFAULTS(USER_DEVICE_ID);

    [PlayGameServices requestCancelCoinsRequest:idReq forUser:userId andToken:token withBlock:^(NSMutableDictionary *userInfo, NSError *error) {
        if (error) {
            [self.loading stopLoading];
        } else {
            [self loadCoinsRequestTable];
        }
    }];
    
    // At the end, we trigger the delegate's method
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(transferMoneyView:cancelRequestBy:isIAP:)]) {
            [self.delegate transferMoneyView:self cancelRequestBy:theApplicant isIAP:NO];
        }
    }
}

- (void)applicantsCoinsCell:(ApplicantsCoinsCell *)sender acceptedApplicant:(NSDictionary *)theApplicant
{
    [self.loading startLoading];
    long long idReq = [[sender.applicant objectForKey:@"id"] longLongValue];
    NSString *token = GET_USERDEFAULTS(SESSION_TOKEN);
    NSString *userId = GET_USERDEFAULTS(USER_DEVICE_ID);
    
    [PlayGameServices requestAcceptCoinsRequest:idReq forUser:userId andToken:token withBlock:^(NSMutableDictionary *userInfo, NSError *error) {
        if (error) {
            [self.loading stopLoading];
        } else {
            [self loadCoinsRequestTable];
        }
    }];
    
    // At the end, we trigger the delegate's method
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(transferMoneyView:acceptRequestBy:isIAP:)]) {
            [self.delegate transferMoneyView:self acceptRequestBy:theApplicant isIAP:NO];
        }
    }
}


#pragma mark - BuyablePacketViewDelegate methods
- (void)buyablePacketViewDidTapped:(BuyablePacketView *)sender
{
    BOOL wasBuyable = NO;
    for (BuyablePacketView *view in self.buyablePacketViews) {
        if (view == sender) {
            if (self.delegate) {
                if ([self.delegate respondsToSelector:@selector(transferMoneyView:tryToBuyPacket:isIAP:)]) {
                    [self.delegate transferMoneyView:self tryToBuyPacket:sender.packetData isIAP:sender.isIapPacket];
                }
            }
            
            wasBuyable = YES;
            break;
        }
    }
    
    if (!wasBuyable) {
        for (BuyablePacketView *view in self.adcPacketViews) {
            if (view == sender) {
                if (self.delegate) {
                    if ([self.delegate respondsToSelector:@selector(transferMoneyView:tryToWatchADCVideo:isIAP:)]) {
                        NSString *zoneId = [sender.packetData objectForKey:@"ADCZoneID"];
                        [self.delegate transferMoneyView:self tryToWatchADCVideo:zoneId isIAP:NO];
                    }
                }
                
                break;
            }
        }
    }
}





#pragma mark - SKProductsRequestDelegate methods
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    NSArray *skproducts = [NSMutableArray arrayWithArray:response.products];
    
    for (NSString *invalidIdentifier in response.invalidProductIdentifiers) {
        // Handle any invalid product identifiers.
        NSLog(@"Warning! This product is not known: %@", invalidIdentifier);
    }
    
    
    // Build the view according to the received products
    if (skproducts && skproducts.count) {
        NSMutableArray *productsValue = [[NSMutableArray alloc] init];
        
        for (SKProduct *product in skproducts) {
            for (NSMutableDictionary *packet in self.packetsArray) {
                NSString *idCoin = [packet objectForKey:@"apple_id"];
                if ([product.productIdentifier isEqualToString:idCoin]) {
                    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                    formatter.formatterBehavior = NSNumberFormatterBehavior10_4;
                    formatter.numberStyle = NSNumberFormatterCurrencyStyle;
                    formatter.minimumFractionDigits = 2;
                    formatter.maximumFractionDigits = 2;
                    NSString *priceFormatted = [formatter stringFromNumber:product.price];
                    NSLog(@"priceFormatted: %@", priceFormatted);
                    NSMutableDictionary *prodPack = [NSMutableDictionary dictionaryWithDictionary:packet];
                    NSString *prodPrice = [NSString stringWithFormat:@"%f", [product.price doubleValue]];
                    [prodPack setValue:priceFormatted forKey:@"price"];
                    [prodPack setValue:prodPrice forKey:@"price_unformatted"];
                    [prodPack setValue:product forKey:@"skProduct"];
                    
                    formatter.numberStyle = NSNumberFormatterCurrencyStyle;
                    formatter.minimumFractionDigits = 0;
                    formatter.maximumFractionDigits = 0;
                    long long coins = [[packet objectForKey:@"coins"] longLongValue];
                    NSString *coinsFmt = [formatter stringFromNumber:[NSNumber numberWithLongLong:coins]];
                    coinsFmt = [Util unpriceValue:coinsFmt];
                    [prodPack setValue:coinsFmt forKey:@"coins_formatted"];
                    
                    [productsValue addObject:prodPack];
                }
            }
        }
        
        NSArray *sortedArray = [productsValue sortedArrayUsingComparator: ^(NSMutableDictionary *obj1, NSMutableDictionary *obj2){
            
            double val1 = [[obj1 objectForKey:@"price_unformatted"] doubleValue];
            double val2 = [[obj2 objectForKey:@"price_unformatted"] doubleValue];
            
            NSComparisonResult ret = NSOrderedSame;
            if (val1 < val2)
            {
                ret = NSOrderedAscending;
            }
            else if (val1 > val2)
            {
                ret = NSOrderedDescending;
            }
            return ret;
        }];
        
        self.packetsArray = [NSMutableArray arrayWithArray:sortedArray];
    }
    
    // Packets views
    CGFloat x = 10;

    // AdColony Packets Array
    for (NSDictionary *adcPack in self.adColonyArray) {
        bool isIAP = [[adcPack objectForKey:@"iap"] boolValue];
        BuyablePacketView *adcView = [BuyablePacketView initBuyablePacketViewWithData:adcPack withDelegate:self isIAP:isIAP];
        adcView.frame = CGRectMake(x, 0, adcView.frame.size.width, adcView.frame.size.height);
        
        if (isIAP) {
            adcView.valueIAPLabel.text = NSLocalizedString(@"FREE", nil);
        } else {
            adcView.valueIAPLabel.text = NSLocalizedString(@"FREE", nil);
            adcView.valueLabel.hidden = YES;
            adcView.valueCoins.hidden = YES;
            adcView.valueIAPLabel.hidden = NO;
        }
        
        [self.packetsScroller addSubview:adcView];
        x += adcView.frame.size.width + 10;
        [self.adcPacketViews addObject:adcView];
    }
    

    // SuperGoals Packets
    for (NSDictionary *supergoal in self.supergoalsArray) {
        BuyablePacketView *supergoalView = [BuyablePacketView initBuyablePacketViewWithData:supergoal withDelegate:self isIAP:NO];
        supergoalView.frame = CGRectMake(x, 0, supergoalView.frame.size.width, supergoalView.frame.size.height);
        [self.packetsScroller addSubview:supergoalView];
        x += supergoalView.frame.size.width + 10;
        [self.buyablePacketViews addObject:supergoalView];
    }
    
    // Coins Packets
    for (NSDictionary *packet in self.packetsArray) {
        BuyablePacketView *packetView = [BuyablePacketView initBuyablePacketViewWithData:packet withDelegate:self isIAP:YES];
        packetView.frame = CGRectMake(x, 0, packetView.frame.size.width, packetView.frame.size.height);
        [self.packetsScroller addSubview:packetView];
        x += packetView.frame.size.width + 10;
        [self.buyablePacketViews addObject:packetView];
    }
    
    CGFloat ws = (self.packetsScroller.frame.size.width > x) ? self.packetsScroller.frame.size.width : x;
    self.packetsScroller.contentSize = CGSizeMake(ws, self.packetsScroller.frame.size.height);
}



#pragma mark - ChooseFBFriendsViewDelegate methods
- (void)chooseFBFriendsViewDidStartFriendsRequest:(ChooseFBFriendsView *)sender
{
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(transferMoneyViewDidStartFriendsRequest:)]) {
            [self.delegate transferMoneyViewDidStartFriendsRequest:self];
        }
    }
}

- (void)chooseFBFriendsViewDidFailFriendsRequest:(ChooseFBFriendsView *)sender
{
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(transferMoneyViewDidFailFriendsRequest:)]) {
            [self.delegate transferMoneyViewDidFailFriendsRequest:self];
        }
    }
}

- (void)chooseFBFriendsViewDidFinishFriendsRequest:(ChooseFBFriendsView *)sender
{
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(transferMoneyViewDidFinishFriendsRequest:)]) {
            [self.delegate transferMoneyViewDidFinishFriendsRequest:self];
        }
    }
}

- (void)chooseFBFriendsViewDidCancel:(ChooseFBFriendsView *)sender
{
    
}

- (void)chooseFBFriendsView:(ChooseFBFriendsView *)sender didSelect:(NSArray *)friendsArray
{
    NSString *msg = NSLocalizedString(@"FACEBOOK_INVITE_MESSAGE", nil);
    NSString *title = @"Wofa";
    NSMutableDictionary *params = [[NSMutableDictionary  alloc] init];
    NSString *fbids = @"";
    for (NSDictionary *friend in friendsArray) {
        NSString *friendfbid = [friend objectForKey:@"id"];
        fbids = [NSString stringWithFormat:@"%@,%@", fbids, friendfbid];
    }
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@", "];
    fbids = [fbids stringByTrimmingCharactersInSet:set];
    params = [NSMutableDictionary dictionaryWithObjectsAndKeys:fbids, @"to", nil];
    
    if ([[FBSession activeSession] isOpen]) {
        NSString *fbtoken = [FBSession activeSession].accessToken;
        SET_USERDEFAULTS(USER_FACEBOOK_TOKEN, fbtoken);
        SYNC_USERDEFAULTS;
        [FBWebDialogs presentRequestsDialogModallyWithSession:nil
                                                      message:msg
                                                        title:title
                                                   parameters:params
                                                      handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
                                                          if (error) {
                                                              // TODO: report to the user the error
                                                          } else {
                                                              if (result == FBWebDialogResultDialogNotCompleted) {
                                                                  NSLog(@"User cancelled request.");
                                                              } else {
                                                                  NSLog(@"Request completed");
                                                                  [self.loading startLoading];
                                                                  NSString *token = GET_USERDEFAULTS(SESSION_TOKEN);
                                                                  NSString *userId = GET_USERDEFAULTS(USER_DEVICE_ID);
                                                                  [PlayGameServices requestCoinsToFBFriends:friendsArray withFBToken:fbtoken forUser:userId andToken:token withBlock:^(NSMutableDictionary *userInfo, NSError *error) {
                                                                      if (error) {
                                                                          // TODO: report to the user the error
                                                                      }
                                                                      
                                                                      // Get the given data and manage it
                                                                      NSString *token = GET_USERDEFAULTS(SESSION_TOKEN);
                                                                      NSString *userId = GET_USERDEFAULTS(USER_DEVICE_ID);
                                                                      [PlayGameServices requestCoinsToFBFriends:friendsArray withFBToken:fbtoken forUser:userId andToken:token withBlock:^(NSMutableDictionary *userInfo, NSError *error) {
                                                                          if (error) {
                                                                              
                                                                          }
                                                                          if (userInfo) {
                                                                          }
                                                                          [self.loading stopLoading];
                                                                      }];
                                                                  }];
                                                              }
                                                          }
                                                      }];
    } else {
        self.chooseFBFriends.isOpenSession = NO;
        [self.chooseFBFriends requestFBFriends];
    }
}

- (void)chooseFBFriendsViewDidReopenSession:(ChooseFBFriendsView *)sender
{
    NSString *msg = NSLocalizedString(@"FACEBOOK_INVITE_MESSAGE", nil);
    NSString *title = @"Wofa";
    [FBWebDialogs presentRequestsDialogModallyWithSession:nil
                                                  message:msg
                                                    title:title
                                               parameters:nil
                                                  handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
                                                      if (error) {
                                                          // TODO: report to the user the error
                                                      } else {
                                                          if (result == FBWebDialogResultDialogNotCompleted) {
                                                              NSLog(@"User cancelled request.");
                                                          } else {
                                                              NSLog(@"Request completed");
                                                          }
                                                      }
                                                  }];
}





#pragma mark - WofaAppFBDelegate methods
- (void)fbSessionGeneralError:(NSError *)error
{
    
}

- (void)fbSessionClosedSessionState:(FBSessionState)state
{
    
}

- (void)fbSessionOpenSession:(FBSession *)session state:(FBSessionState)state
{
    self.fbid = nil;
    self.fbToken = nil;
    self.fname = nil;
    self.lname = nil;
    self.email = nil;
    [[FBRequest requestForMe] startWithCompletionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
        if (!error) {
            self.email = [user objectForKey:@"email"];
            self.fbid = user.id;
            self.fname = user.first_name;
            self.lname = user.last_name;
            self.fbToken = [FBSession activeSession].accessToken;
            
            CGRect sideRect = CGRectMake(0, 0, self.messageView.popSideView.frame.size.width, self.messageView.popSideView.frame.size.height);
            UILabel *sideLabel = [[UILabel alloc] initWithFrame:sideRect];
            sideLabel.text = NSLocalizedString(@"TO YOUR FACEBOOK ACCOUNT. CONTINUE?", nil);
            NSString *msg = NSLocalizedString(@"YOUR CURRENT PROGRESS WILL BE LINKED", nil);
            sideLabel.font = FONT_REGULAR(10);
            sideLabel.textColor = [UIColor whiteColor];
            sideLabel.numberOfLines = 2;
            self.messageView.behaviorFlag = 20;
            [self.messageView showWithTitle:@"FACEBOOK"
                                withMessage:msg
                               withSideView:sideLabel
                               withOKButton:NSLocalizedString(@"OK", nil)
                           withCancelButton:NSLocalizedString(@"CANCEL", nil)];
        } else {
            self.messageView.behaviorFlag = 1;
            [self.messageView showWithTitle:@"FACEBOOK"
                                withMessage:NSLocalizedString(@"WE HAVE AN ERROR WITH FACEBOOK", nil)
                               withSideView:nil
                               withOKButton:NSLocalizedString(@"OK", nil)
                           withCancelButton:nil];
        }
    }];
    
}




#pragma  mark - PopUpMessageViewDelegate methods
- (void)popUpMessageViewDidTouchOK:(PopUpMessageView *)view
{
    if (view.behaviorFlag == 10) {
//        [self.appDelegate openFBSession];
    } else if (view.behaviorFlag == 20) {
        NSString *userIdStr = nil;
        
        NSString *tmpUserId = GET_USERDEFAULTS(USER_DEVICE_ID);
        if (tmpUserId && ![tmpUserId isEqualToString:@""]) {
            userIdStr = tmpUserId;
        }
        [InitialServices requestLinkAccountWithFBID:self.fbid andFBToken:self.fbToken andFirstname:self.fname andLastname:self.lname andEmail:self.email withDeviceID:userIdStr withBlock:^(NSDictionary *loginData, NSError *error) {
            if (error) {
                self.messageView.behaviorFlag = 1;
                [self.messageView showWithTitle:@"FACEBOOK"
                                    withMessage:NSLocalizedString(@"WE HAVE AN ERROR WITH FACEBOOK", nil)
                                   withSideView:nil
                                   withOKButton:NSLocalizedString(@"OK", nil)
                               withCancelButton:nil];
            }
            if (loginData) {
                NSDictionary *conflictDict = [loginData objectForKey:@"account_conflict"];
                NSDictionary *userDict = [loginData objectForKey:@"user"];
                if (conflictDict) {
                    //show conflict solver view so the user will select the desired account
                    [self.loading stopLoading];
                    self.mergeView = [MergeAccountsView initMergeAccountsViewWithLoginData:loginData withParentView:self.superview andDelegate:self];
                    [self.mergeView performSelector:@selector(show) withObject:nil afterDelay:0.3];
                }
                if (userDict) {
                    NSString *newToken = [userDict objectForKey:@"token"];
                    SET_USERDEFAULTS(USER_IS_GUEST, @"0");
                    SET_USERDEFAULTS(USER_FACEBOOK_ID, self.fbid);
                    SET_USERDEFAULTS(SESSION_TOKEN, newToken);
                    SET_USERDEFAULTS(USER_EMAIL, self.email);
                    SET_USERDEFAULTS(USER_FIRSTNAME, self.fname);
                    SET_USERDEFAULTS(USER_LASTNAME, self.lname);
                    SET_USERDEFAULTS(USER_FACEBOOK_TOKEN, self.fbToken);
                    SET_USERDEFAULTS(USER_DEVICE_ID, self.fbid);
                    SYNC_USERDEFAULTS;
                    
                    self.coinsApplicantsContainer.hidden = NO;
                    self.coinsFBLoginContainer.hidden = YES;

                    [self.chooseFBFriends removeFromSuperview];
                    self.chooseFBFriends = nil;
                    self.chooseFBFriends = [ChooseFBFriendsView initChooseFBFriendsViewWithDelegate:self];
                    [self addSubview:self.chooseFBFriends];
                    [self.chooseFBFriends hideNoAnim];

                }
            }
        }];
    }
}





#pragma mark - MergeAccountsViewDelegate methods
- (void)mergeAccountsViewDidLinkGuest
{
    [self.loading startLoading];
    NSString *accSel = PARAM_SELECTED_GUEST;
    [self requestResolveLinkWithSelected:accSel];
}

- (void)mergeAccountsViewDidLinkFacebook
{
    [self.loading startLoading];
    NSString *accSel = PARAM_SELECTED_FACEBOOK;
    [self requestResolveLinkWithSelected:accSel];
}


- (void)requestResolveLinkWithSelected:(NSString *)accSel
{
    NSString *userIdStr = nil;
    
    NSString *tmpUserId = GET_USERDEFAULTS(USER_DEVICE_ID);
    if (tmpUserId && ![tmpUserId isEqualToString:@""]) {
        userIdStr = tmpUserId;
    }
    [InitialServices resolveLinkAccountWithFBID:self.fbid andFBToken:self.fbToken andFirstname:self.fname andLastname:self.lname andEmail:self.email withDeviceID:userIdStr withSelectedAccount:accSel withBlock:^(NSDictionary *loginData, NSError *error) {
        if (error) {
            [self.loading stopLoading];
            for (UIView *vw in self.messageView.popSideView.subviews) {
                [vw removeFromSuperview];
            }
            self.messageView.behaviorFlag = 1;
            [self.messageView showWithTitle:@"FACEBOOK"
                                withMessage:NSLocalizedString(@"WE HAVE AN ERROR WITH FACEBOOK", nil)
                               withSideView:nil
                               withOKButton:NSLocalizedString(@"OK", nil)
                           withCancelButton:nil];
        }
        if (loginData) {
            NSDictionary *userDict = [loginData objectForKey:@"user"];
            if (userDict) {
                NSString *newToken = [userDict objectForKey:@"token"];
                SET_USERDEFAULTS(USER_IS_GUEST, @"0");
                SET_USERDEFAULTS(USER_FACEBOOK_ID, self.fbid);
                SET_USERDEFAULTS(SESSION_TOKEN, newToken);
                SET_USERDEFAULTS(USER_EMAIL, self.email);
                SET_USERDEFAULTS(USER_FIRSTNAME, self.fname);
                SET_USERDEFAULTS(USER_LASTNAME, self.lname);
                SET_USERDEFAULTS(USER_FACEBOOK_TOKEN, self.fbToken);
                SET_USERDEFAULTS(USER_DEVICE_ID, self.fbid);
                SYNC_USERDEFAULTS;
                
                self.coinsApplicantsContainer.hidden = NO;
                self.coinsFBLoginContainer.hidden = YES;
                
                [self.chooseFBFriends removeFromSuperview];
                self.chooseFBFriends = nil;
                self.chooseFBFriends = [ChooseFBFriendsView initChooseFBFriendsViewWithDelegate:self];
                [self addSubview:self.chooseFBFriends];
                [self.chooseFBFriends hideNoAnim];
                
            }
        }
    }];
}




@end
