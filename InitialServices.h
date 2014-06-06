//
//  InitialServices.h
//  wofa
//
//  Created by Ihonahan Buitrago on 18/10/13.
//  Copyright (c) 2013 ByYuto. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Util.h"
#import "AFNetworking.h"
#import "UserData.h"



@interface InitialServices : NSObject


+ (void)requestAdverImageUrlWithBlock:(void (^)(NSString *adverUrl, NSString *adverID, NSString *sponsorUrl, NSError *error))block;

+ (void)sendADClickForUser:(NSString *)userId andToken:(NSString *)token withBlock:(void (^)(NSDictionary *userInfo, NSError *error))block;


+ (void)requestFBLoginWithFBID:(NSString *)fbid andFBToken:(NSString *)tokenData andFirstname:(NSString *)fname andLastname:(NSString *)lname andEmail:(NSString *)email withDeviceID:(NSString *)deviceGuestId withBlock:(void (^)(NSDictionary *loginData, NSError *error))block;

+ (void)requestGuestLoginWithDeviceID:(NSString *)deviceGuestId withBlock:(void (^)(NSDictionary *loginData, NSError *error))block;

+ (void)requestPlayersForUser:(NSString *)userId andToken:(NSString *)token withBlock:(void (^)(NSArray *players, NSError *error))block;

+ (void)requestHomeDataUser:(NSString *)userId andToken:(NSString *)token withBlock:(void (^)(NSArray *players, NSError *error))block;

+ (void)requestPlayersByCategory:(int)category forUser:(NSString *)userId andToken:(NSString *)token withBlock:(void (^)(NSArray *players, NSError *error))block;

+ (void)requestAllPlayersForUser:(NSString *)userId andToken:(NSString *)token withBlock:(void (^)(NSArray *players, NSError *error))block;

+ (void)requestSetInitialPlayersBronze:(int)idPlayerBronze silver:(int)idPlayerSilver forUser:(NSString *)userId andToken:(NSString *)token withBlock:(void (^)(NSDictionary *goldPlayer, NSError *error))block;

+ (void)requestRegisterPushToken:(NSString *)pushToken ForUser:(NSString *)userId andToken:(NSString *)token withBlock:(void (^)(NSDictionary *result, NSError *error))block;

+ (void)requestNotificationsForUser:(NSString *)userId andToken:(NSString *)token withBlock:(void (^)(NSArray *notifications, NSError *error))block;

+ (void)requestBuyablePlayersForUser:(NSString *)userId andToken:(NSString *)token withBlock:(void (^)(NSArray *players, NSError *error))block;

+ (void)requestIAPProductsForUser:(NSString *)userId andToken:(NSString *)token withBlock:(void (^)(NSArray *products, NSError *error))block;

+ (void)requestBuyableProductsForUser:(NSString *)userId andToken:(NSString *)token withBlock:(void (^)(NSDictionary *userInfo, NSError *error))block;


+ (void)requestTermsAndConditionsWithBlock:(void (^)(NSString *termsText, NSError *error))block;

+ (void)requestUnreadNotificationsCountForUser:(NSString *)userId andToken:(NSString *)token withBlock:(void (^)(NSDictionary *notifications, NSError *error))block;

+ (void)requestNewsForUser:(NSString *)userId andToken:(NSString *)token withBlock:(void (^)(NSDictionary *userInfo, NSError *error))block;


+ (void)requestLeaderboardFriendsForUser:(NSString *)userId andToken:(NSString *)token andFBFriends:(NSArray *)fbFriends withBlock:(void (^)(NSDictionary *userInfo, NSError *error))block;

+ (void)requestWorldLeaderboardsForUser:(NSString *)userId andToken:(NSString *)token withBlock:(void (^)(NSDictionary *userInfo, NSError *error))block;



+ (void)requestLinkAccountWithFBID:(NSString *)fbid andFBToken:(NSString *)tokenData andFirstname:(NSString *)fname andLastname:(NSString *)lname andEmail:(NSString *)email withDeviceID:(NSString *)deviceGuestId withBlock:(void (^)(NSDictionary *loginData, NSError *error))block;

+ (void)resolveLinkAccountWithFBID:(NSString *)fbid andFBToken:(NSString *)tokenData andFirstname:(NSString *)fname andLastname:(NSString *)lname andEmail:(NSString *)email withDeviceID:(NSString *)deviceGuestId withSelectedAccount:(NSString *)selectedAccount withBlock:(void (^)(NSDictionary *loginData, NSError *error))block;


@end
