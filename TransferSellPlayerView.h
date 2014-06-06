//
//  TransferSellPlayerView.h
//  wofa
//
//  Created by Ihonahan Buitrago on 15/02/14.
//  Copyright (c) 2014 ByYuto. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Util.h"

#import "TransferSellPlayerViewCell.h"
#import "PopUpMessageView.h"


@protocol TransferSellPlayerViewDelegate;


@interface TransferSellPlayerView : UIView <UIScrollViewDelegate, TransferSellPlayerViewCellDelegate, PopUpMessageViewDelegate>

@property(strong) IBOutlet UIView *fullContainer;
@property(strong) IBOutlet UIImageView *tableBackground;
@property(strong) IBOutlet UILabel *sellLabel;
@property(strong) IBOutlet UIScrollView *contentScroller;

@property(weak) id<TransferSellPlayerViewDelegate> delegate;



+ (TransferSellPlayerView *)initTransferSellPlayerViewWithPlayers:(NSArray *)thePlayers withDelegate:(id<TransferSellPlayerViewDelegate>)theDelegate;


@end


@protocol TransferSellPlayerViewDelegate <NSObject>

@optional
- (void)transferSellPlayerView:(TransferSellPlayerView *)sender tryToSellPlayer:(NSDictionary *)player;
- (void)transferSellPlayerViewRequestBuyPlayer:(TransferSellPlayerView *)sender;

@end