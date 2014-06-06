//
//  Util.h
//  wofa
//
//  Created by Ihonahan Buitrago on 15/10/13.
//  Copyright (c) 2013 ByYuto. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KeyValuePair.h"
#import "NSData+Base64.h"
#import "RGBAColor.h"

#import <CommonCrypto/CommonCrypto.h>

#import "Reachability.h"


#define IS_IPHONE_4INCH                                 ([[UIScreen mainScreen] bounds].size.height == 568)
#define IS_IPAD                                         ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
#define IOS_VERSION                                     [UIDevice currentDevice].systemVersion
#define SCREEN_SCALE                                    [[UIScreen mainScreen] scale]

#define SERVICE_DEVICE                                  [NSString stringWithFormat:@"ios-v%@", [UIDevice currentDevice].systemVersion]

#define GET_USERDEFAULTS(__KEY__)                       [[NSUserDefaults standardUserDefaults] valueForKey:__KEY__]
#define SET_USERDEFAULTS(__KEY__, __VALUE__)            [[NSUserDefaults standardUserDefaults] setValue:__VALUE__ forKey:__KEY__]
#define GET_OBJECT_USERDEFAULTS(__KEY__)                [[NSUserDefaults standardUserDefaults] objectForKey:__KEY__]
#define SET_OBJECT_USERDEFAULTS(__KEY__, __VALUE__)     [[NSUserDefaults standardUserDefaults] setObject:__VALUE__ forKey:__KEY__]
#define SYNC_USERDEFAULTS                               [[NSUserDefaults standardUserDefaults] synchronize]

#define DOCUMENTS_PATH                                  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#define CACHE_PATH                                      ([NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0])

#define DEGREES_TO_RADIANS(__x__)                       (M_PI * __x__ / 180.0)


#define SERVICES_URL                                    @"http://wofagoldenboot.com/ws" //@"http://wofa.azurewebsites.net/ws" //@"http://wofa.azurewebsites.net/frontend_dev.php/ws"
#define SERVICE_GUEST_LOGIN                             @"login/guest"
#define SERVICE_FB_LOGIN                                @"login"
#define SERVICE_GET_SPLASH_AD                           @"splash-ad/get"
#define SERVICE_CLICK_SPLASH_AD                         @"splash-ad/click"
#define SERVICE_GET_USER_PLAYERS                        @"user/players"
#define SERVICE_GET_HOME_DATA                           @"user/home-players"
#define SERVICE_GET_PLAYERS_BY_CATEGORY                 @"players"
#define SERVICE_GET_ALL_PLAYERS                         @"players/get-initial"
#define SERVICE_SET_INITIAL_PLAYERS                     @"user/set-initial-players"
#define SERVICE_SET_PLAYER_BET                          @"player/bet/set"
#define SERVICE_SET_DOUBLE_BET                          @"player/five-minutes-bet/set"
#define SERVICE_GAME_STATUS                             @"game/status"
#define SERVICE_REGISTER_PUSH                           @"push/register/ios"
#define SERVICE_GET_NOTIFICATIONS                       @"notifications/get"
#define SERVICE_GET_BUYABLE_PLAYERS                     @"player/buy-list"
#define SERVICE_BUY_PLAYER_LEVEL_COINS                  @"player/buy/level-and-coins"
#define SERVICE_BUY_PLAYER_COINS                        @"player/buy/only-coins"
#define SERVICE_SELL_PLAYER                             @"player/sell"
#define SERVICE_GET_IAP_PRODUCTS                        @""
#define SERVICE_GET_BUYABLE_PRODUCTS                    @"packs/get"
#define SERVICE_BUY_COINS_PACK                          @"packs/coins/buy/ios"
#define SERVICE_BUY_SUPERGOALS_PACK                     @"packs/super-goal/buy"
#define SERVICE_GET_TERMS_CONDITIONS                    @"terms-and-conditions"
#define SERVICE_GET_UNREAD_NOTIFICATIONS_COUNT          @"notifications/count"
#define SERVICE_GET_NEWS                                @"news/get"
#define SERVICE_REQUEST_FACEBOOK_COINS                  @"coin-requests/send"
#define SERVICE_GET_COINS_REQUESTS                      @"coin-requests/get"
#define SERVICE_CANCEL_COINS_REQUEST                    @"coin-requests/deny"
#define SERVICE_ACCEPT_COINS_REQUEST                    @"coin-requests/accept"
#define SERVICE_GET_LEADERBOARD_FRIENDS                 @"leaderboard/friends"
#define SERVICE_GET_LEADERBOARD_GLOBAL                  @"leaderboard"

#define PARAM_SELECTED_GUEST                            @"GUEST"
#define PARAM_SELECTED_FACEBOOK                         @"FACEBOOK"


#define APP_NAME                                        @"sett_app_name"
#define APP_VERSION                                     @"sett_app_version"
#define APP_REVISION                                    @"sett_app_revision"
#define APP_PLATFORM                                    @"sett_app_platform"
#define APP_IOS_VERSION                                 @"sett_ios_version"

#define APN_TOKEN                                       @"apn_device_token"

#define AD_SPLASH_ID                                    @"ad_splash_id"
#define AD_SPLASH_URL                                   @"ad_splash_url"
#define AD_SPLASH_IMAGE                                 @"ad_splash_image"
#define AD_SPONSOR_URL                                  @"ad_sponsor_url"

#define APP_ITUNES_URL                                  @"https://itunes.apple.com/us/app/wofa/id827932311?l=es&ls=1&mt=8"

#define APP_HOMEPAGE_URL                                @"http://wofagoldenboot.com/"

#define APP_TWITTER_URL                                 @"http://www.twitter.com/wofa"
#define APP_FACEBOOK_URL                                @"http://www.facebook.com/wofa"

#define USER_FACEBOOK_ID                                @"user_facebook_id"
#define USER_FACEBOOK_TOKEN                             @"user_facebook_token"
#define SESSION_TOKEN                                   @"session_token"
#define USER_FIRSTNAME                                  @"user_firstname"
#define USER_LASTNAME                                   @"user_lastname"
#define USER_EMAIL                                      @"user_email"
#define USER_DEVICE_ID                                  @"user_device_id"
#define USER_IS_GUEST                                   @"user_is_guest"
#define USER_COINS                                      @"user_coins"
#define USER_IS_CONFIGURED                              @"user_configured"
#define USER_TWITTER_ID                                 @"user_twitter_id"

#define USER_CELEBRATED_GOALS                           @"user_celebrated_goals"

#define USER_FIRST_VIEW_BET                             @"user_first_view_bet"
#define USER_FIRST_VIEW_HOME                            @"user_first_view_home"
#define USER_FIRST_VIEW_TRANSFER                        @"user_first_view_transfer"
#define USER_FISRT_VIEW_MONEY                           @"user_first_view_money"
#define USER_FIRST_VIEW_RESULTS                         @"user_first_view_results"

#define ADCOLONY_APP_ID                                 @"appe32ddd837d1442faaf"
#define ADCOLONY_SUPERGOAL_ZONE_ID                      @"vze9863d312d954f4eb1"
#define ADCOLONY_COINS_ZONE_ID                          @"vze0bdf1bfb02646b79d"
#define ADCOLONY_ALREADY_REGISTERED                     @"user_adcolony_registered"
#define ADCOLONY_CALLBACK_SUCCESS                       @"user_adcolony_callback_success"

#define WOFA_TIME_ZONE_NAME                             @"America/Bogota" // @"GMT"


#define FONT_REGULAR(__x__)                             [UIFont fontWithName:@"CaviarDreams" size:__x__]
#define FONT_LIGHT(__x__)                               [UIFont fontWithName:@"CaviarDreams" size:__x__]
#define FONT_BOLD(__x__)                                [UIFont fontWithName:@"CaviarDreams-Bold" size:__x__]
#define FONT_NUMBERS(__x__)                             [UIFont fontWithName:@"Opificio" size:__x__]


#define COINS_BET_STEP                                  5
#define MINUTES_DOUBLE_BET                              5
#define MINUTES_LEFT_BET                                15
#define MINUTES_PLAY_BALL                               220


#define TIMER_LOAD_PLAYERS                              5*60

#define KEYBOARD_HEIGHT                                 400


#define WOFA_APP_ID                                     827932311 //Change this one to your ID



#define ButtonHeadCode   21
#define ButtonRightCode   1
#define ButtonLeftCode   11



typedef enum
{
    FacebookGraphErrorNoError = 0,
    FacebookGraphErrorGeneral = 1,
    FacebookGraphErrorNoDictionary = 2
} FacebookGraphError;

typedef enum
{
    PlayerCategoryBronze = 1,
    PlayerCategorySilver = 2,
    PlayerCategoryGold = 3
} PlayerCategory;

typedef enum
{
    TimeToBetStatusWayBefore,
    TimeToBetStatusBetweenWait,
    TimeToBetStatusPlayBall,
    TimeToBetStatusWayPast
}TimeToBetStatus;

typedef enum
{
    PlayMoveStatusEdit = 1,
    PlayMoveStatusSelected = 2,
    PlayMoveStatusNoEdit = 3,
    PlayMoveStatusSuperGoalEdit = 4,
    PlayMoveStatusSuperGoalNoEdit = 5,
    PlayMoveStatusSuperGoalSelected = 6,
    PlayMoveStatusGoalFail = 7,
    PlayMoveStatusGoalSuccess = 8,
    PlayMoveStatusSuperGoalSuccess = 9
    
}PlayMoveStatus;

@interface Util : NSObject


+ (NSString*)base64forData:(NSData*)theData;

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

+ (BOOL)checkMinimumAgeDay:(int)cmpDay ageMonth:(int)cmpMonth ageYear:(int)cmpYear WithMinYear:(int)minAgeYears;

+ (BOOL)stringIsEmpty:(NSString *) aString;

+ (BOOL)stringIsEmpty:(NSString *) aString shouldCleanWhiteSpace:(BOOL)cleanWhileSpace;

+ (NSString *)getNowInFormat:(NSString *)format;

+ (BOOL)checkMinimumAgeWithMinAge:(int)minAgeYears withYear:(int)year withMonth:(int)month withDay:(int)day;

+ (NSString *)md5:(NSString *)input;

+ (BOOL)validateEmail:(NSString *) candidate;

+ (NSString *)getServerFormattedDeviceInfo;


+ (NSString *)getStringDateFromTimeStamp:(long)timestamp withFormat:(NSString *)format;

+ (int)getAgeFromDateString:(NSString *)dateStr withFormat:(NSString *)format;

+ (NSDate *)getDateFromString:(NSString *)date withFormat:(NSString *)format;

+ (NSString *)formatDate:(NSDate *)date toFormat:(NSString *)format;

+ (NSDate *)getDateFromString:(NSString *)date withFormat:(NSString *)format withTimeZone:(NSTimeZone *)theTimeZone;

+ (NSString *)formatDate:(NSDate *)date toFormat:(NSString *)format withTimeZone:(NSTimeZone *)theTimeZone;

+ (NSString *)unpriceValue:(NSString *)strValue;


+ (KeyValuePair *)getKeyValueFromArray:(NSArray *)array withKey:(NSString *)key;

+ (void)trackGAIEventForCategory:(NSString *)newCat action:(NSString *)newAction label:(NSString *)newLabel value:(NSNumber *)newValue;

+ (UIImage *)bootShieldForCategory:(PlayerCategory)playCat;


+ (RGBAColor *)getRGBAColorInImage:(UIImage *)image inPoint:(CGPoint)point;

+ (RGBAColor *)getRGBAColorInImageRef:(CGImageRef)image inPoint:(CGPoint)point withImageSize:(CGSize)size;


+ (NSString *)hashedValueForUserID:(NSString*)userID;


+ (BOOL)checkIfGoalWasCelebrated:(long long)idGoal;


@end
