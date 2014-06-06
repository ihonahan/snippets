//
//  TransferSellPlayerViewCell.h
//  wofa
//
//  Created by Ihonahan Buitrago on 15/02/14.
//  Copyright (c) 2014 ByYuto. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Util.h"


@protocol TransferSellPlayerViewCellDelegate;


@interface TransferSellPlayerViewCell : UIView

@property(strong) IBOutlet UIView *fullContainer;
@property(strong) IBOutlet UIImageView *backgroundImage;
@property(strong) IBOutlet UIImageView *shieldImage;
@property(strong) IBOutlet UIImageView *playerImage;
@property(strong) IBOutlet UIImageView *bootImage;
@property(strong) IBOutlet UILabel *nameLabel;
@property(strong) IBOutlet UILabel *costLabel;
@property(strong) IBOutlet UIButton *sellButton;

@property(weak) id<TransferSellPlayerViewCellDelegate> delegate;


- (IBAction)tapUpSell:(id)sender;


+ (TransferSellPlayerViewCell *)initTransferSellPlayerViewCellWithPlayer:(NSDictionary *)thePlayer withDelegate:(id<TransferSellPlayerViewCellDelegate>)theDelegate;


@end

@protocol TransferSellPlayerViewCellDelegate <NSObject>

@optional
- (void)transferSellPlayerViewCell:(TransferSellPlayerViewCell *)sender tryToSellPlayer:(NSDictionary *)player;

@end