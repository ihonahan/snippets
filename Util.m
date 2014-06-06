//
//  Util.m
//  wofa
//
//  Created by Ihonahan Buitrago on 15/10/13.
//  Copyright (c) 2013 ByYuto. All rights reserved.
//

#import "Util.h"

#import "GAI.h"
#import "GAIDictionaryBuilder.h"


@implementation Util




+ (NSString*)base64forData:(NSData*)theData
{
    NSString *result = [theData base64EncodedStringWithSeparateLines:NO];
    
    NSString *path = [NSString stringWithFormat:@"%@/imgStrBase64.txt", CACHE_PATH];
    NSError *error = nil;
    BOOL wrote = [result writeToFile:path atomically:YES encoding:NSASCIIStringEncoding error:&error];
    
    if (wrote) {
        NSLog(@"file wrote on path: %@", path);
    }
    
    error = nil;
    NSString *result2 = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    
    if (result2) {
        return result2;
    } else {
        return result;
    }
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


+ (BOOL)checkMinimumAgeDay:(int)cmpDay ageMonth:(int)cmpMonth ageYear:(int)cmpYear WithMinYear:(int)minAgeYears
{
    NSDate *now = [NSDate date];
    int biDays = minAgeYears / 4;
    NSTimeInterval goBack = minAgeYears * (365 + biDays) * 24 * 60 * 60;
    NSDate *minDate = [now dateByAddingTimeInterval:(goBack * -1)];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:cmpDay];
    [components setMonth:cmpMonth];
    [components setYear:cmpYear];
    NSDate *birth = [calendar dateFromComponents:components];
    
    NSLog(@"minDate: %@ | birth: %@", minDate, birth);
    
    NSComparisonResult comp = [birth compare:minDate];
    if (comp == NSOrderedSame || comp == NSOrderedAscending) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL)checkMinimumAgeWithMinAge:(int)minAgeYears withYear:(int)year withMonth:(int)month withDay:(int)day
{
    NSDate *now = [NSDate date];
    NSTimeInterval goBack = minAgeYears * 365 * 24 * 60 * 60;
    NSDate *minDate = [now dateByAddingTimeInterval:(goBack * -1)];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:day];
    [components setMonth:month];
    [components setYear:year];
    NSDate *birth = [calendar dateFromComponents:components];
    
    NSLog(@"minDate: %@ | birth: %@", minDate, birth);
    
    NSComparisonResult comp = [birth compare:minDate];
    if (comp == NSOrderedSame || comp == NSOrderedAscending) {
        return YES;
    } else {
        return NO;
    }
}


+ (BOOL)stringIsEmpty:(NSString *) aString
{
    
    if ((NSNull *) aString == [NSNull null]) {
        return YES;
    }
    
    if (aString == nil) {
        return YES;
    } else if ([aString length] == 0) {
        return YES;
    } else {
        aString = [aString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([aString length] == 0) {
            return YES;
        }
    }
    
    return NO;
}

+ (BOOL)stringIsEmpty:(NSString *) aString shouldCleanWhiteSpace:(BOOL)cleanWhileSpace
{
    
    if ((NSNull *) aString == [NSNull null]) {
        return YES;
    }
    
    if (aString == nil) {
        return YES;
    } else if ([aString length] == 0) {
        return YES;
    }
    
    if (cleanWhileSpace) {
        aString = [aString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([aString length] == 0) {
            return YES;
        }
    }
    
    return NO;
}


+ (NSString *)getNowInFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [formatter setDateFormat:format];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    
    NSDate *now = [NSDate date];
    
    NSString *dateString = [formatter stringFromDate:now];
    
    return dateString;
}


+ (NSString *)md5:(NSString *)input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:16 * 2];
    
    for(int i = 0; i < 16; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
    
}


+ (BOOL)validateEmail:(NSString *)candidate
{
    NSString *emailRegex =
    @"(?:[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-zA-Z0-9](?:[a-"
    @"z0-9-]*[a-zA-Z0-9])?\\.)+[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-zA-Z0-9-]*[a-zA-Z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}



+ (NSString *)getServerFormattedDeviceInfo
{
    NSString *appVer = GET_USERDEFAULTS(APP_VERSION);
    NSString *appRev = GET_USERDEFAULTS(APP_REVISION);
    NSString *devPlat = GET_USERDEFAULTS(APP_PLATFORM);
    NSString *iosVer = GET_USERDEFAULTS(APP_IOS_VERSION);
    NSString *devValue = [NSString stringWithFormat:@"ios-%@ version %@ rev.%@ ios %@", devPlat, appVer, appRev, iosVer];
    
    return devValue;
}

+ (NSString *)getStringDateFromTimeStamp:(long)timestamp withFormat:(NSString *)format
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [formatter setDateFormat:format];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    
    NSString *dateString = [formatter stringFromDate:date];
    
    return dateString;
}

+ (int)getAgeFromDateString:(NSString *)dateStr withFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [formatter setDateFormat:format];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    NSDate *date = [formatter dateFromString:dateStr];
    
    if (date) {
        NSDate *now = [NSDate date];
        [formatter setDateFormat:@"yyyy"];
        NSString *yrDateStr = [formatter stringFromDate:date];
        NSString *yrNowStr = [formatter stringFromDate:now];
        [formatter setDateFormat:@"MM"];
        NSString *mnDateStr = [formatter stringFromDate:date];
        NSString *mnNowStr = [formatter stringFromDate:now];
        
        int yrDate = [yrDateStr intValue];
        int yrNow = [yrNowStr intValue];
        int mnDate = [mnDateStr intValue];
        int mnNow = [mnNowStr intValue];
        
        int result = yrNow - yrDate;
        if (mnNow < mnDate) {
            result--;
        }
        
        return result;
    } else {
        return 0;
    }
}

+ (NSDate *)getDateFromString:(NSString *)date withFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [formatter setDateFormat:format];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];

    NSDate *result = [formatter dateFromString:date];
    
    return result;
}

+ (NSString *)formatDate:(NSDate *)date toFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [formatter setDateFormat:format];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    
    NSString *result = [formatter stringFromDate:date];
    
    return result;
}



+ (NSDate *)getDateFromString:(NSString *)date withFormat:(NSString *)format withTimeZone:(NSTimeZone *)theTimeZone
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [formatter setDateFormat:format];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [formatter setTimeZone:theTimeZone];
    
    NSDate *result = [formatter dateFromString:date];
    
    return result;
}

+ (NSString *)formatDate:(NSDate *)date toFormat:(NSString *)format withTimeZone:(NSTimeZone *)theTimeZone
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [formatter setDateFormat:format];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [formatter setTimeZone:theTimeZone];
    
    NSString *result = [formatter stringFromDate:date];
    
    return result;
}



+ (KeyValuePair *)getKeyValueFromArray:(NSArray *)array withKey:(NSString *)key
{
    for (KeyValuePair *vp in array) {
        
        if ([vp.key isKindOfClass:[NSString class]]) {
            NSString *keyEval = (NSString *)vp.key;
            if ([keyEval isEqualToString:key]) {
                return vp;
            }
        }
    }
    
    return nil;
}



+ (void)trackGAIEventForCategory:(NSString *)newCat action:(NSString *)newAction label:(NSString *)newLabel value:(NSNumber *)newValue
{
    // May return nil if a tracker has not already been initialized with a property
    // ID.
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:newCat     // Event category (required)
                                                          action:newAction  // Event action (required)
                                                           label:newLabel          // Event label
                                                           value:newValue] build]];    // Event value
}


+ (UIImage *)bootShieldForCategory:(PlayerCategory)playCat
{
    NSString *bootShieldName = @"";
    
    if (IS_IPAD) {
        switch (playCat) {
            case PlayerCategoryBronze:
            {
                bootShieldName = @"Inicio_ios-35.png";
            }
                break;
                
            case PlayerCategorySilver:
            {
                bootShieldName = @"Inicio_ios-36.png";
            }
                break;
                
            case PlayerCategoryGold:
            {
                bootShieldName = @"Inicio_ios-46.png";
            }
                break;
                
            default:
                break;
        }
    } else {
        switch (playCat) {
            case PlayerCategoryBronze:
            {
                bootShieldName = @"Inicio_ios-35.png";
            }
                break;
                
            case PlayerCategorySilver:
            {
                bootShieldName = @"Inicio_ios-36.png";
            }
                break;
                
            case PlayerCategoryGold:
            {
                bootShieldName = @"Inicio_ios-46.png";
            }
                break;
                
            default:
                break;
        }
    }
    
    UIImage *result = [UIImage imageNamed:bootShieldName];
    
    return result;
}




+ (RGBAColor *)getRGBAColorInImage:(UIImage *)image inPoint:(CGPoint)point
{
    int x = (int)point.x;
    int y = (int)point.y;
    
    CFDataRef pixelData = CGDataProviderCopyData(CGImageGetDataProvider(image.CGImage));
    const UInt8* data = CFDataGetBytePtr(pixelData);
    
    int pixelInfo = ((image.size.width  * y) + x ) * 4; // The image is png
    
    UInt8 red = data[pixelInfo];        
    UInt8 green = data[(pixelInfo + 1)];
    UInt8 blue = data[pixelInfo + 2];   
    UInt8 alpha = data[pixelInfo + 3];
    
    CFRelease(pixelData);

    RGBAColor *result = [[RGBAColor alloc] initWithIntegersRed:red green:green blue:blue alpha:alpha];
    
    return result;
}


+ (RGBAColor *)getRGBAColorInImageRef:(CGImageRef)cgimage inPoint:(CGPoint)point withImageSize:(CGSize)size
{
    size_t x = point.x * SCREEN_SCALE;
    size_t y = point.y * SCREEN_SCALE;
    
    size_t width = CGImageGetWidth(cgimage);
    size_t height = CGImageGetHeight(cgimage);
    
    size_t bpr = CGImageGetBytesPerRow(cgimage);
    size_t bpp = CGImageGetBitsPerPixel(cgimage);
    size_t bpc = CGImageGetBitsPerComponent(cgimage);
    size_t bytes_per_pixel = bpp / bpc;
    
    CGDataProviderRef provider = CGImageGetDataProvider(cgimage);
    NSData *data = (id)CFBridgingRelease(CGDataProviderCopyData(provider));
    const uint8_t *bytes = [data bytes];
    
    const uint8_t *pixel = &bytes[(y * bpr) + (x * bytes_per_pixel)];
    
    uint8_t red = pixel[0];
    uint8_t green = pixel[1];
    uint8_t blue = pixel[2];
    uint8_t alpha = 1;
    if (bytes_per_pixel >= 4) {
        alpha = pixel[3];
    }
    
    RGBAColor *result = [[RGBAColor alloc] initWithIntegersRed:red green:green blue:blue alpha:alpha];
    
    return result;
    
//    int x = (int)point.x;
//    int y = (int)point.y;
//    
//    CFDataRef pixelData = CGDataProviderCopyData(CGImageGetDataProvider(image));
//    const UInt8* data = CFDataGetBytePtr(pixelData);
//    
//    int pixelInfo = ((size.width  * y) + x ) * 4; // The image is png
//    
//    UInt8 red = data[pixelInfo];        
//    UInt8 green = data[(pixelInfo + 1)];
//    UInt8 blue = data[pixelInfo + 2];   
//    UInt8 alpha = data[pixelInfo + 3];
//    
//    CFRelease(pixelData);
//    
//    RGBAColor *result = [[RGBAColor alloc] initWithIntegersRed:red green:green blue:blue alpha:alpha];
//    
//    return result;
}



// Custom method to calculate the SHA-256 hash using Common Crypto
+ (NSString *)hashedValueForUserID:(NSString*)userID
{
    const int HASH_SIZE = 32;
    unsigned char hashedChars[HASH_SIZE];
    const char *accountName = [userID UTF8String];
    size_t accountNameLen = strlen(accountName);
    
    // Confirm that the length of the user name is small enough
    // to be recast when calling the hash function.
    if (accountNameLen > UINT32_MAX) {
        NSLog(@"Account name too long to hash: %@", userID);
        return nil;
    }
    CC_SHA256(accountName, (CC_LONG)accountNameLen, hashedChars);
    
    // Convert the array of bytes into a string showing its hex representation.
    NSMutableString *userAccountHash = [[NSMutableString alloc] init];
    for (int i = 0; i < HASH_SIZE; i++) {
        // Add a dash every four bytes, for readability.
        if (i != 0 && i%4 == 0) {
            [userAccountHash appendString:@"-"];
        }
        [userAccountHash appendFormat:@"%02x", hashedChars[i]];
    }
    
    return userAccountHash;
}



+ (BOOL)checkIfGoalWasCelebrated:(long long)idGoal
{
    NSArray *celebratedGoals = GET_USERDEFAULTS(USER_CELEBRATED_GOALS);
    NSString *thegoal = [NSString stringWithFormat:@"%lld", idGoal];
    BOOL wasCelebrated = NO;

    if (celebratedGoals && celebratedGoals.count) {
        for (NSString *goal in celebratedGoals) {
            long long goalI = [goal longLongValue];
            if (goalI == idGoal) {
                wasCelebrated = YES;
                break;
            }
        }
        
        if (wasCelebrated) {
            return YES;
        } else {
            NSMutableArray *goals = [NSMutableArray arrayWithArray:celebratedGoals];
            if (goals.count >= 100) {
                [goals removeObjectAtIndex:0];
            }
            
            [goals addObject:thegoal];
            SET_USERDEFAULTS(USER_CELEBRATED_GOALS, goals);
            SYNC_USERDEFAULTS;
            return NO;
        }
    } else {
        NSArray *goals = [NSArray arrayWithObjects:thegoal, nil];
        SET_USERDEFAULTS(USER_CELEBRATED_GOALS, goals);
        SYNC_USERDEFAULTS;
        return NO;
    }
}


+ (NSString *)unpriceValue:(NSString *)strValue
{
    NSString *result = [strValue stringByReplacingOccurrencesOfString:@"$" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"€" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"¥" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"π" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"%" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"œ" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"ø" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"§" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"฿" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"ƒ" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"₣" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"Fr" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"£" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"₩" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"B/." withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"₥" withString:@""];
    
    return result;
}




@end
