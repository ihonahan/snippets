//
//  TransferSellPlayerView.m
//  wofa
//
//  Created by Ihonahan Buitrago on 15/02/14.
//  Copyright (c) 2014 ByYuto. All rights reserved.
//

#import "TransferSellPlayerView.h"


@interface TransferSellPlayerView()

@property(strong) NSArray *myPlayers;
@property(strong) PopUpMessageView *messageView;

- (void)setupTransferSellPlayerViewWithPlayers:(NSArray *)thePlayers withDelegate:(id<TransferSellPlayerViewDelegate>)theDelegate;


@end


@implementation TransferSellPlayerView

@synthesize fullContainer;
@synthesize tableBackground;
@synthesize sellLabel;
@synthesize contentScroller;
@synthesize delegate;

@synthesize myPlayers;



+ (TransferSellPlayerView *)initTransferSellPlayerViewWithPlayers:(NSArray *)thePlayers withDelegate:(id<TransferSellPlayerViewDelegate>)theDelegate
{
    NSString *nibName = nil;
    if (IS_IPAD) {
        nibName = @"TransferSellPlayerView_ipad";
    } else {
        nibName = @"TransferSellPlayerView";
    }
    
    NSArray *xibsArray = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
    if (xibsArray && xibsArray.count) {
        TransferSellPlayerView *view = [xibsArray objectAtIndex:0];
        
        [view setupTransferSellPlayerViewWithPlayers:thePlayers withDelegate:theDelegate];
        
        return view;
    }
    
    return nil;
}


- (void)setupTransferSellPlayerViewWithPlayers:(NSArray *)thePlayers withDelegate:(id<TransferSellPlayerViewDelegate>)theDelegate
{
    self.delegate = theDelegate;
    self.myPlayers = thePlayers;
    
    self.sellLabel.font = FONT_BOLD(16);
    self.sellLabel.text = NSLocalizedString(@"SELL MY PLAYERS", nil);
    
    self.contentScroller.delegate = self;

    // Message view
    self.messageView = [PopUpMessageView initPopUpMessageViewWithParentView:self andDelegate:self];
    
    
    UIImage *rawFBLoginButton = [UIImage imageNamed:@"centro_trans_ios-16.png"];
    rawFBLoginButton = [Util imageWithImage:rawFBLoginButton scaledToSize:CGSizeMake(385, 159)];
    UIEdgeInsets edgesFB;
    edgesFB.top = 50;
    edgesFB.bottom = 50;
    edgesFB.left = 80;
    edgesFB.right = 80;
    UIImage *fbLoginBtnImg = [rawFBLoginButton resizableImageWithCapInsets:edgesFB resizingMode:UIImageResizingModeTile];
    self.tableBackground.image = fbLoginBtnImg;

    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat h = 0;
    int i = 1;
    for (NSDictionary *player in self.myPlayers) {
        TransferSellPlayerViewCell *cell = [TransferSellPlayerViewCell initTransferSellPlayerViewCellWithPlayer:player withDelegate:self];

        if ((i % 2) == 0) {
            x += cell.frame.size.width;
        } else if (i > 1) {
            x = 0;
            h = cell.frame.size.height;
            y += h;
        }

        cell.frame = CGRectMake(x, y, cell.frame.size.width, cell.frame.size.height);
        [self.contentScroller addSubview:cell];
        i++;
    }
    self.contentScroller.contentSize = CGSizeMake(self.contentScroller.frame.size.width, y + (h * 1.5));
}





#pragma mark - TransferSellPlayerViewCellDelegate methods
- (void)transferSellPlayerViewCell:(TransferSellPlayerViewCell *)sender tryToSellPlayer:(NSDictionary *)player
{
    if (self.myPlayers.count >= 2) {
        if (self.delegate) {
            if ([self.delegate respondsToSelector:@selector(transferSellPlayerView:tryToSellPlayer:)]) {
                [self.delegate transferSellPlayerView:self tryToSellPlayer:player];
            }
        }
    } else {
        UILabel *sideLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.messageView.popSideView.frame.size.width, self.messageView.popSideView.frame.size.height)];
        sideLabel.font = FONT_REGULAR(12);
        sideLabel.numberOfLines = 2;
        sideLabel.textColor = [UIColor whiteColor];
        sideLabel.text = NSLocalizedString(@"BUY OTHER PLAYER BEFORE SELL THIS ONE", nil);
        [self.messageView showWithTitle:NSLocalizedString(@"GAME", nil)
                            withMessage:NSLocalizedString(@"YOU CAN'T RUN OUT OF PLAYERS", nil)
                           withSideView:sideLabel
                           withOKButton:NSLocalizedString(@"OK", nil)
                       withCancelButton:NSLocalizedString(@"CANCEL", nil)];

    }
}


#pragma mark - PopMessageViewDelegate methods
- (void)popUpMessageViewDidTouchOK:(PopUpMessageView *)view
{
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(transferSellPlayerViewRequestBuyPlayer:)]) {
            [self.delegate transferSellPlayerViewRequestBuyPlayer:self];
        }
    }
}


@end
