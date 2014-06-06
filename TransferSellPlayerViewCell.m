//
//  TransferSellPlayerViewCell.m
//  wofa
//
//  Created by Ihonahan Buitrago on 15/02/14.
//  Copyright (c) 2014 ByYuto. All rights reserved.
//

#import "TransferSellPlayerViewCell.h"

#import "UIImageView+WebCache.h"



@interface TransferSellPlayerViewCell()

@property(strong) NSDictionary *myPlayer;

@property(strong) UIImage *bootIconBronze;
@property(strong) UIImage *bootIconSilver;
@property(strong) UIImage *bootIconGold;

@property(strong) UIImage *shieldIconBronze;
@property(strong) UIImage *shieldIconSilver;
@property(strong) UIImage *shieldIconGold;


- (void)setupTransferSellPlayerViewCellWithPlayer:(NSDictionary *)thePlayer withDelegate:(id<TransferSellPlayerViewCellDelegate>)theDelegate;

@end


@implementation TransferSellPlayerViewCell

@synthesize fullContainer;
@synthesize backgroundImage;
@synthesize shieldImage;
@synthesize playerImage;
@synthesize bootImage;
@synthesize nameLabel;
@synthesize costLabel;
@synthesize sellButton;
@synthesize delegate;

@synthesize myPlayer;
@synthesize bootIconBronze;
@synthesize bootIconSilver;
@synthesize bootIconGold;
@synthesize shieldIconBronze;
@synthesize shieldIconSilver;
@synthesize shieldIconGold;


+ (TransferSellPlayerViewCell *)initTransferSellPlayerViewCellWithPlayer:(NSDictionary *)thePlayer withDelegate:(id<TransferSellPlayerViewCellDelegate>)theDelegate
{
    NSString *nibName = nil;
    if (IS_IPAD) {
        nibName = @"TransferSellPlayerViewCell_ipad";
    } else {
        nibName = @"TransferSellPlayerViewCell";
    }
    
    NSArray *xibsArray = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
    if (xibsArray && xibsArray.count) {
        TransferSellPlayerViewCell *view = [xibsArray objectAtIndex:0];
        
        [view setupTransferSellPlayerViewCellWithPlayer:thePlayer withDelegate:theDelegate];
        
        return view;
    }
    
    return nil;
}


- (void)setupTransferSellPlayerViewCellWithPlayer:(NSDictionary *)thePlayer withDelegate:(id<TransferSellPlayerViewCellDelegate>)theDelegate
{
    self.myPlayer = thePlayer;
    self.delegate = theDelegate;
    
    self.bootIconBronze = [UIImage imageNamed:@"centro_trans_ios-36.png"];
    self.bootIconSilver = [UIImage imageNamed:@"centro_trans_ios-37.png"];
    self.bootIconGold = [UIImage imageNamed:@"centro_trans_ios-38.png"];
    
    self.shieldIconBronze = [UIImage imageNamed:@"centro_trans_ios-33.png"];
    self.shieldIconSilver = [UIImage imageNamed:@"centro_trans_ios-34.png"];
    self.shieldIconGold = [UIImage imageNamed:@"centro_trans_ios-35.png"];


    UIImage *rawFBLoginButton = [UIImage imageNamed:@"centro_trans_ios-15.png"];
    rawFBLoginButton = [Util imageWithImage:rawFBLoginButton scaledToSize:CGSizeMake(100, 50)];
    UIEdgeInsets edgesFB;
    edgesFB.top = 24;
    edgesFB.bottom = 24;
    edgesFB.left = 40;
    edgesFB.right = 40;
    UIImage *fbLoginBtnImg = [rawFBLoginButton resizableImageWithCapInsets:edgesFB resizingMode:UIImageResizingModeTile];
    self.backgroundImage.image = fbLoginBtnImg;
    
    NSDictionary *photos = [self.myPlayer objectForKey:@"photo"];
    if (photos) {
        NSString *urlImg = [photos objectForKey:@"small"];
        [self.playerImage setImageWithURL:[NSURL URLWithString:urlImg] placeholderImage:nil];
    }
    
    int catPlayer = [[self.myPlayer objectForKey:@"category"] intValue];
    switch (catPlayer) {
        case PlayerCategoryBronze:
        {
            self.bootImage.image = self.bootIconBronze;
            self.shieldImage.image = self.shieldIconBronze;
        }
            break;
            
        case PlayerCategorySilver:
        {
            self.bootImage.image = self.bootIconSilver;
            self.shieldImage.image = self.shieldIconSilver;
        }
            break;
            
        case PlayerCategoryGold:
        {
            self.bootImage.image = self.bootIconGold;
            self.shieldImage.image = self.shieldIconGold;
        }
            break;
            
        default:
            break;
    }
    self.nameLabel.text = [self.myPlayer objectForKey:@"name"];
    
    self.costLabel.text = [self.myPlayer  objectForKey:@"sell_price"];

    self.nameLabel.font = FONT_BOLD(11);
    self.costLabel.font = FONT_NUMBERS(13);
    
}



- (IBAction)tapUpSell:(id)sender
{
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(transferSellPlayerViewCell:tryToSellPlayer:)]) {
            [self.delegate transferSellPlayerViewCell:self tryToSellPlayer:self.myPlayer];
        }
    }
}

@end
