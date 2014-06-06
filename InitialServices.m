//
//  InitialServices.m
//  wofa
//
//  Created by Ihonahan Buitrago on 18/10/13.
//  Copyright (c) 2013 ByYuto. All rights reserved.
//

#import "InitialServices.h"

@implementation InitialServices


+ (void)requestAdverImageUrlWithBlock:(void (^)(NSString *adverUrl, NSString *adverID, NSString *sponsorUrl, NSError *error))block
{
    Reachability *reachConn = [Reachability reachabilityForInternetConnection];
    if (reachConn.currentReachabilityStatus == NotReachable) {
        NSLog(@"no internet");
        if (block) {
            NSString *msg = NSLocalizedString(@"NO INTERNET CONNECTION DETECTED. PLEASE CHECK YOUR INTERNET CONNECTION AND TRY AGAIN.", nil);
            NSString *code = @"100";
            NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
            NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
            block(nil, nil, nil, myError);
        }
        return;
    }

    
    NSString *userID = GET_USERDEFAULTS(USER_DEVICE_ID);
    NSString *sessionToken = GET_USERDEFAULTS(SESSION_TOKEN);
    
    NSString *serviceUrl = [NSString stringWithFormat:@"%@/%@", SERVICES_URL, SERVICE_GET_SPLASH_AD];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                userID, @"token[userid]",
                                sessionToken, @"token[token]",
                                nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:serviceUrl
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSDictionary *jsonResponse = nil;
              NSError *jsonError = nil;
              if ([responseObject isKindOfClass:[NSDictionary class]]) {
                  jsonResponse = (NSDictionary *)responseObject;
              } else if ([responseObject isKindOfClass:[NSArray class]]) {
                  NSArray *jsonArray = (NSArray *)responseObject;
                  jsonResponse = (NSDictionary *)[jsonArray objectAtIndex:0];
              } else if ([responseObject isKindOfClass:[NSString class]]) {
                  NSString *jsonStr = (NSString *)responseObject;
                  NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
                  jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
                  if (jsonError) {
                      block(nil, nil, nil, jsonError);
                      return;
                  }
              } else if ([responseObject isKindOfClass:[NSData class]]) {
                  NSData *jsonData = (NSData *)responseObject;
                  jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
                  if (jsonError) {
                      block(nil, nil, nil, jsonError);
                      return;
                  }
              }
              
              if (jsonResponse && block) {
                  int errorNo = [[jsonResponse objectForKey:@"error"] intValue];
                  
                  if (!errorNo) {
                      NSDictionary *splashDict = [jsonResponse objectForKey:@"splash_ad"];
                      if (splashDict) {
                          NSString *idSplash = [splashDict objectForKey:@"id"];
                          NSString *urlSplash = [splashDict objectForKey:@"photo"];
                          NSString *urlSponsor = [splashDict objectForKey:@"url"];
                          block(urlSplash, idSplash, urlSponsor, nil);
                      } else {
                          NSString *msg = [jsonResponse objectForKey:@"message"];
                          NSString *code = [jsonResponse objectForKey:@"error"];
                          NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
                          NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
                          block(nil, nil, nil, myError);
                      }
                  } else {
                      NSString *msg = [jsonResponse objectForKey:@"message"];
                      NSString *code = [jsonResponse objectForKey:@"error"];
                      NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
                      NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
                      block(nil, nil, nil, myError);
                  }
              }
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if (block) {
                  block(nil, nil, nil, error);
              }
              return;
          }];
}



+ (void)sendADClickForUser:(NSString *)userId andToken:(NSString *)token withBlock:(void (^)(NSDictionary *userInfo, NSError *error))block
{
    Reachability *reachConn = [Reachability reachabilityForInternetConnection];
    if (reachConn.currentReachabilityStatus == NotReachable) {
        NSLog(@"no internet");
        if (block) {
            NSString *msg = NSLocalizedString(@"NO INTERNET CONNECTION DETECTED. PLEASE CHECK YOUR INTERNET CONNECTION AND TRY AGAIN.", nil);
            NSString *code = @"100";
            NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
            NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
            block(nil, myError);
        }
        return;
    }

    
    NSString *serviceUrl = [NSString stringWithFormat:@"%@/%@", SERVICES_URL, SERVICE_CLICK_SPLASH_AD];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                userId, @"token[userid]",
                                token, @"token[token]",
                                nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:serviceUrl
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSDictionary *jsonResponse = nil;
              NSError *jsonError = nil;
              if ([responseObject isKindOfClass:[NSDictionary class]]) {
                  jsonResponse = (NSDictionary *)responseObject;
              } else if ([responseObject isKindOfClass:[NSArray class]]) {
                  NSArray *jsonArray = (NSArray *)responseObject;
                  jsonResponse = (NSDictionary *)[jsonArray objectAtIndex:0];
              } else if ([responseObject isKindOfClass:[NSString class]]) {
                  NSString *jsonStr = (NSString *)responseObject;
                  NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
                  jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
                  if (jsonError) {
                      block(nil, jsonError);
                      return;
                  }
              } else if ([responseObject isKindOfClass:[NSData class]]) {
                  NSData *jsonData = (NSData *)responseObject;
                  jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
                  if (jsonError) {
                      block(nil, jsonError);
                      return;
                  }
              }
              
              if (jsonResponse && block) {
                  int errorNo = [[jsonResponse objectForKey:@"error"] intValue];
                  
                  if (!errorNo) {
                          block(jsonResponse, nil);
                  } else {
                      NSString *msg = [jsonResponse objectForKey:@"message"];
                      NSString *code = [jsonResponse objectForKey:@"error"];
                      NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
                      NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
                      block(nil, myError);
                  }
              }
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if (block) {
                  block(nil, error);
              }
              return;
          }];
}



+ (void)requestFBLoginWithFBID:(NSString *)fbid andFBToken:(NSString *)tokenData andFirstname:(NSString *)fname andLastname:(NSString *)lname andEmail:(NSString *)email withDeviceID:(NSString *)deviceGuestId withBlock:(void (^)(NSDictionary *loginData, NSError *error))block
{
    Reachability *reachConn = [Reachability reachabilityForInternetConnection];
    if (reachConn.currentReachabilityStatus == NotReachable) {
        NSLog(@"no internet");
        if (block) {
            NSString *msg = NSLocalizedString(@"NO INTERNET CONNECTION DETECTED. PLEASE CHECK YOUR INTERNET CONNECTION AND TRY AGAIN.", nil);
            NSString *code = @"100";
            NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
            NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
            block(nil, myError);
        }
        return;
    }
    
    
    NSString *serviceUrl = [NSString stringWithFormat:@"%@/%@", SERVICES_URL, SERVICE_FB_LOGIN];
    
    NSString *loginDev = SERVICE_DEVICE;
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       fbid, @"login[facebook_id]",
                                       fname, @"login[firstname]",
                                       lname, @"login[lastname]",
                                       email, @"login[email]",
                                       tokenData, @"login[access_token]",
                                       //@"0", @"login[birthday]",
                                       loginDev, @"login[device]",
                                       nil];
    if (deviceGuestId) {
        [parameters setObject:deviceGuestId forKey:@"login[device_id]"];
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:serviceUrl
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSDictionary *jsonResponse = nil;
              NSError *jsonError = nil;
              if ([responseObject isKindOfClass:[NSDictionary class]]) {
                  jsonResponse = (NSDictionary *)responseObject;
              } else if ([responseObject isKindOfClass:[NSArray class]]) {
                  NSArray *jsonArray = (NSArray *)responseObject;
                  jsonResponse = (NSDictionary *)[jsonArray objectAtIndex:0];
              } else if ([responseObject isKindOfClass:[NSString class]]) {
                  NSString *jsonStr = (NSString *)responseObject;
                  NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
                  jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
                  if (jsonError) {
                      block(nil, jsonError);
                      return;
                  }
              } else if ([responseObject isKindOfClass:[NSData class]]) {
                  NSData *jsonData = (NSData *)responseObject;
                  jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
                  if (jsonError) {
                      block(nil, jsonError);
                      return;
                  }
              }
              
              if (jsonResponse && block) {
                  int errorNo = [[jsonResponse objectForKey:@"error"] intValue];
                  
                  if (!errorNo) {
                      NSDictionary *userDict = [jsonResponse objectForKey:@"user"];
                      
                      if (userDict) {
                          // Create or modify the UserData static object
                          UserData *userDt = [UserData sharedUserData];
                          userDt.userFirstname = fname;
                          userDt.userLastname = lname;
                          userDt.userFacebookId = fbid;
                          userDt.userEmail = email;
                          userDt.sessionToken = [userDict objectForKey:@"token"];
                          userDt.userDeviceId = [userDict objectForKey:@"userid"];
                          userDt.userCoins = [[userDict objectForKey:@"momey"] intValue];
                          userDt.userExperience = [[userDict objectForKey:@"experience"] intValue];
                          userDt.userSuperGoals = [[userDict objectForKey:@"super_goals"] intValue];
                          
                          // Call the block success mode
                          block(userDict, nil);
                      } else {
                          NSString *msg = [jsonResponse objectForKey:@"message"];
                          NSString *code = [jsonResponse objectForKey:@"error"];
                          NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
                          NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
                          block(jsonResponse, myError);
                      }
                  } else {
                      NSString *msg = [jsonResponse objectForKey:@"message"];
                      NSString *code = [jsonResponse objectForKey:@"error"];
                      NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
                      NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
                      block(jsonResponse, myError);
                  }
              }
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if (block) {
                  block(nil, error);
              }
              return;
          }];
}



+ (void)requestGuestLoginWithDeviceID:(NSString *)deviceGuestId withBlock:(void (^)(NSDictionary *loginData, NSError *error))block
{
    Reachability *reachConn = [Reachability reachabilityForInternetConnection];
    if (reachConn.currentReachabilityStatus == NotReachable) {
        NSLog(@"no internet");
        if (block) {
            NSString *msg = NSLocalizedString(@"NO INTERNET CONNECTION DETECTED. PLEASE CHECK YOUR INTERNET CONNECTION AND TRY AGAIN.", nil);
            NSString *code = @"100";
            NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
            NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
            block(nil, myError);
        }
        return;
    }
    
    
    NSString *serviceUrl = [NSString stringWithFormat:@"%@/%@", SERVICES_URL, SERVICE_GUEST_LOGIN];
    
    NSString *loginDev = SERVICE_DEVICE;
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       loginDev, @"guest_login[device]",
                                       nil];
    if (deviceGuestId) {
        [parameters setObject:deviceGuestId forKey:@"guest_login[device_id]"];
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:serviceUrl
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSDictionary *jsonResponse = nil;
              NSError *jsonError = nil;
              if ([responseObject isKindOfClass:[NSDictionary class]]) {
                  jsonResponse = (NSDictionary *)responseObject;
              } else if ([responseObject isKindOfClass:[NSArray class]]) {
                  NSArray *jsonArray = (NSArray *)responseObject;
                  jsonResponse = (NSDictionary *)[jsonArray objectAtIndex:0];
              } else if ([responseObject isKindOfClass:[NSString class]]) {
                  NSString *jsonStr = (NSString *)responseObject;
                  NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
                  jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
                  if (jsonError) {
                      block(nil, jsonError);
                      return;
                  }
              } else if ([responseObject isKindOfClass:[NSData class]]) {
                  NSData *jsonData = (NSData *)responseObject;
                  jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
                  if (jsonError) {
                      block(nil, jsonError);
                      return;
                  }
              }
              
              if (jsonResponse && block) {
                  int errorNo = [[jsonResponse objectForKey:@"error"] intValue];
                  
                  if (!errorNo) {
                      NSDictionary *userDict = [jsonResponse objectForKey:@"user"];
                      
                      if (userDict) {
                          // Create or modify the UserData static object
                          UserData *userDt = [UserData sharedUserData];
                          userDt.userFirstname = @"";
                          userDt.userLastname = @"";
                          userDt.userFacebookId = @"";
                          userDt.userEmail = @"";
                          userDt.sessionToken = [userDict objectForKey:@"token"];
                          userDt.userDeviceId = [userDict objectForKey:@"userid"];
                          userDt.userCoins = [[userDict objectForKey:@"money"] intValue];
                          userDt.userExperience = [[userDict objectForKey:@"experience"] intValue];
                          userDt.userSuperGoals = [[userDict objectForKey:@"super_goals"] intValue];
                          
                          // Call the block success mode
                          block(userDict, nil);
                      } else {
                          NSString *msg = [jsonResponse objectForKey:@"message"];
                          NSString *code = [jsonResponse objectForKey:@"error"];
                          NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
                          NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
                          block(jsonResponse, myError);
                      }
                  } else {
                      NSString *msg = [jsonResponse objectForKey:@"message"];
                      NSString *code = [jsonResponse objectForKey:@"error"];
                      NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
                      NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
                      block(jsonResponse, myError);
                  }
              }
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if (block) {
                  block(nil, error);
              }
              return;
          }];
}



+ (void)requestPlayersForUser:(NSString *)userId andToken:(NSString *)token withBlock:(void (^)(NSArray *players, NSError *error))block
{
    Reachability *reachConn = [Reachability reachabilityForInternetConnection];
    if (reachConn.currentReachabilityStatus == NotReachable) {
        NSLog(@"no internet");
        if (block) {
            NSString *msg = NSLocalizedString(@"NO INTERNET CONNECTION DETECTED. PLEASE CHECK YOUR INTERNET CONNECTION AND TRY AGAIN.", nil);
            NSString *code = @"100";
            NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
            NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
            block(nil, myError);
        }
        return;
    }
    
    
    NSString *serviceUrl = [NSString stringWithFormat:@"%@/%@", SERVICES_URL, SERVICE_GET_USER_PLAYERS];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       userId, @"token[userid]",
                                       token, @"token[token]",
                                       nil];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:serviceUrl
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSDictionary *jsonResponse = nil;
              NSError *jsonError = nil;
              if ([responseObject isKindOfClass:[NSDictionary class]]) {
                  jsonResponse = (NSDictionary *)responseObject;
              } else if ([responseObject isKindOfClass:[NSArray class]]) {
                  NSArray *jsonArray = (NSArray *)responseObject;
                  jsonResponse = (NSDictionary *)[jsonArray objectAtIndex:0];
              } else if ([responseObject isKindOfClass:[NSString class]]) {
                  NSString *jsonStr = (NSString *)responseObject;
                  NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
                  jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
                  if (jsonError) {
                      block(nil, jsonError);
                      return;
                  }
              } else if ([responseObject isKindOfClass:[NSData class]]) {
                  NSData *jsonData = (NSData *)responseObject;
                  jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
                  if (jsonError) {
                      block(nil, jsonError);
                      return;
                  }
              }
              
              if (jsonResponse && block) {
                  int errorNo = [[jsonResponse objectForKey:@"error"] intValue];
                  
                  if (!errorNo) {
                      NSArray *playersArray = [jsonResponse objectForKey:@"players"];
                      
                      if (playersArray) {
                          block(playersArray, nil);
                      } else {
                          NSString *msg = [jsonResponse objectForKey:@"message"];
                          NSString *code = [jsonResponse objectForKey:@"error"];
                          NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
                          NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
                          block(nil, myError);
                      }
                  } else {
                      NSString *msg = [jsonResponse objectForKey:@"message"];
                      NSString *code = [jsonResponse objectForKey:@"error"];
                      NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
                      NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
                      block(nil, myError);
                  }
              }
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if (block) {
                  block(nil, error);
              }
              return;
          }];
}



+ (void)requestHomeDataUser:(NSString *)userId andToken:(NSString *)token withBlock:(void (^)(NSArray *players, NSError *error))block
{
    Reachability *reachConn = [Reachability reachabilityForInternetConnection];
    if (reachConn.currentReachabilityStatus == NotReachable) {
        NSLog(@"no internet");
        if (block) {
            NSString *msg = NSLocalizedString(@"NO INTERNET CONNECTION DETECTED. PLEASE CHECK YOUR INTERNET CONNECTION AND TRY AGAIN.", nil);
            NSString *code = @"100";
            NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
            NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
            block(nil, myError);
        }
        return;
    }
    
    
    NSString *serviceUrl = [NSString stringWithFormat:@"%@/%@", SERVICES_URL, SERVICE_GET_HOME_DATA];
    
//    NSString *tokenStr = @"df270a224f1fc745b64115efe1a95c8d23e7cfd4";
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       userId, @"token[userid]",
                                       token, @"token[token]",
                                       nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:serviceUrl
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSDictionary *jsonResponse = nil;
              NSError *jsonError = nil;
              if ([responseObject isKindOfClass:[NSDictionary class]]) {
                  jsonResponse = (NSDictionary *)responseObject;
              } else if ([responseObject isKindOfClass:[NSArray class]]) {
                  NSArray *jsonArray = (NSArray *)responseObject;
                  jsonResponse = (NSDictionary *)[jsonArray objectAtIndex:0];
              } else if ([responseObject isKindOfClass:[NSString class]]) {
                  NSString *jsonStr = (NSString *)responseObject;
                  NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
                  jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
                  if (jsonError) {
                      block(nil, jsonError);
                      return;
                  }
              } else if ([responseObject isKindOfClass:[NSData class]]) {
                  NSData *jsonData = (NSData *)responseObject;
                  jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
                  if (jsonError) {
                      block(nil, jsonError);
                      return;
                  }
              }
              
              if (jsonResponse && block) {
                  int errorNo = [[jsonResponse objectForKey:@"error"] intValue];
                  NSString *msg = [jsonResponse objectForKey:@"message"];
                  
                  if (!errorNo) {
                      NSDictionary *userDict = [jsonResponse objectForKey:@"user"];
                      if (userDict) {
                          [UserData sharedUserData].userCoins = [[userDict objectForKey:@"money"] longLongValue];
                          [UserData sharedUserData].userExperience = [[userDict objectForKey:@"experience"] longLongValue];
                          [UserData sharedUserData].userSuperGoals = [[userDict objectForKey:@"super_goals"] longLongValue];
                      }
                      int qtyNoti = [[jsonResponse objectForKey:@"unread_notifications_count"] intValue];
                      [UserData sharedUserData].userNewNotifications = qtyNoti;
                      
                      NSArray *playersArray = [jsonResponse objectForKey:@"players"];
                      
                      if (playersArray) {
                          block(playersArray, nil);
                          NSString *pushToken = GET_USERDEFAULTS(APN_TOKEN);
                          if (pushToken && pushToken.length) {
                              [InitialServices requestRegisterPushToken:pushToken ForUser:userId andToken:token withBlock:nil];
                          }
                      } else {
                          NSString *code = [jsonResponse objectForKey:@"error"];
                          NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
                          NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
                          block(nil, myError);
                      }
                  } else if (errorNo == 10 || [msg isEqualToString:@"INVALID_LOGIN_DATA"]) {
                      if ([UserData sharedUserData].userFacebookId) {
                          [self requestFBLoginWithFBID:[UserData sharedUserData].userFacebookId
                                            andFBToken:nil
                                          andFirstname:[UserData sharedUserData].userFirstname
                                           andLastname:[UserData sharedUserData].userLastname
                                              andEmail:[UserData sharedUserData].userEmail
                                          withDeviceID:nil
                                             withBlock:^(NSDictionary *loginData, NSError *errorLogin) {
                                                 if (!errorLogin && loginData) {
                                                     SET_USERDEFAULTS(SESSION_TOKEN, [loginData objectForKey:@"token"]);
                                                     [UserData sharedUserData].sessionToken = [loginData objectForKey:@"token"];
                                                     [self requestHomeDataUser:[UserData sharedUserData].userDeviceId andToken:[UserData sharedUserData].sessionToken withBlock:block];
                                                 }
                                                 if (errorLogin && block) {
                                                     block(nil, errorLogin);
                                                 }
                                             }];
                      } else if([UserData sharedUserData].userDeviceId) {
                          [self requestGuestLoginWithDeviceID:[UserData sharedUserData].userDeviceId withBlock:^(NSDictionary *loginData, NSError *errorLogin) {
                              if (!errorLogin && loginData) {
                                  SET_USERDEFAULTS(SESSION_TOKEN, [loginData objectForKey:@"token"]);
                                  [UserData sharedUserData].sessionToken = [loginData objectForKey:@"token"];
                                  [self requestHomeDataUser:[UserData sharedUserData].userDeviceId andToken:[UserData sharedUserData].sessionToken withBlock:block];
                              }
                              if (errorLogin && block) {
                                  block(nil, errorLogin);
                              }
                          }];
                  } else {
                      NSString *code = [jsonResponse objectForKey:@"error"];
                      NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
                      NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
                      block(nil, myError);
                  }
              }
          }
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if (block) {
                  block(nil, error);
              }
              return;
          }];
}




+ (void)requestAllPlayersForUser:(NSString *)userId andToken:(NSString *)token withBlock:(void (^)(NSArray *players, NSError *error))block
{
    Reachability *reachConn = [Reachability reachabilityForInternetConnection];
    if (reachConn.currentReachabilityStatus == NotReachable) {
        NSLog(@"no internet");
        if (block) {
            NSString *msg = NSLocalizedString(@"NO INTERNET CONNECTION DETECTED. PLEASE CHECK YOUR INTERNET CONNECTION AND TRY AGAIN.", nil);
            NSString *code = @"100";
            NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
            NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
            block(nil, myError);
        }
        return;
    }
    
    
    NSString *serviceUrl = [NSString stringWithFormat:@"%@/%@", SERVICES_URL, SERVICE_GET_ALL_PLAYERS];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       userId, @"token[userid]",
                                       token, @"token[token]",
                                       nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:serviceUrl
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSDictionary *jsonResponse = nil;
              NSError *jsonError = nil;
              if ([responseObject isKindOfClass:[NSDictionary class]]) {
                  jsonResponse = (NSDictionary *)responseObject;
              } else if ([responseObject isKindOfClass:[NSArray class]]) {
                  NSArray *jsonArray = (NSArray *)responseObject;
                  jsonResponse = (NSDictionary *)[jsonArray objectAtIndex:0];
              } else if ([responseObject isKindOfClass:[NSString class]]) {
                  NSString *jsonStr = (NSString *)responseObject;
                  NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
                  jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
                  if (jsonError) {
                      block(nil, jsonError);
                      return;
                  }
              } else if ([responseObject isKindOfClass:[NSData class]]) {
                  NSData *jsonData = (NSData *)responseObject;
                  jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
                  if (jsonError) {
                      block(nil, jsonError);
                      return;
                  }
              }
              
              if (jsonResponse && block) {
                  int errorNo = [[jsonResponse objectForKey:@"error"] intValue];
                  NSString *msg = [jsonResponse objectForKey:@"message"];
                  
                  if (!errorNo) {
                      NSArray *playersArray = [jsonResponse objectForKey:@"players"];
                      
                      if (playersArray) {
                          block(playersArray, nil);
                      } else {
                          NSString *code = [jsonResponse objectForKey:@"error"];
                          NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
                          NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
                          block(nil, myError);
                      }
                  } else if (errorNo == 10 || [msg isEqualToString:@"INVALID_LOGIN_DATA"]) {
                      if ([UserData sharedUserData].userFacebookId) {
                          [self requestFBLoginWithFBID:[UserData sharedUserData].userFacebookId
                                            andFBToken:nil
                                          andFirstname:[UserData sharedUserData].userFirstname
                                           andLastname:[UserData sharedUserData].userLastname
                                              andEmail:[UserData sharedUserData].userEmail
                                          withDeviceID:nil
                                             withBlock:^(NSDictionary *loginData, NSError *errorLogin) {
                                                 if (!errorLogin && loginData) {
                                                     SET_USERDEFAULTS(SESSION_TOKEN, [loginData objectForKey:@"token"]);
                                                     [UserData sharedUserData].sessionToken = [loginData objectForKey:@"token"];
                                                     [self requestAllPlayersForUser:[UserData sharedUserData].userDeviceId andToken:[UserData sharedUserData].sessionToken withBlock:block];
                                                 }
                                                 if (errorLogin && block) {
                                                     block(nil, errorLogin);
                                                 }
                                             }];
                      } else if([UserData sharedUserData].userDeviceId) {
                          [self requestGuestLoginWithDeviceID:[UserData sharedUserData].userDeviceId withBlock:^(NSDictionary *loginData, NSError *errorLogin) {
                              if (!errorLogin && loginData) {
                                  SET_USERDEFAULTS(SESSION_TOKEN, [loginData objectForKey:@"token"]);
                                  [UserData sharedUserData].sessionToken = [loginData objectForKey:@"token"];
                                  [self requestAllPlayersForUser:[UserData sharedUserData].userDeviceId andToken:[UserData sharedUserData].sessionToken withBlock:block];
                              }
                              if (errorLogin && block) {
                                  block(nil, errorLogin);
                              }
                          }];
                      }
                  } else {
                      NSString *code = [jsonResponse objectForKey:@"error"];
                      NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
                      NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
                      block(nil, myError);
                  }
              }
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if (block) {
                  block(nil, error);
              }
              return;
          }];
}



+ (void)requestPlayersByCategory:(int)category forUser:(NSString *)userId andToken:(NSString *)token withBlock:(void (^)(NSArray *players, NSError *error))block
{
    Reachability *reachConn = [Reachability reachabilityForInternetConnection];
    if (reachConn.currentReachabilityStatus == NotReachable) {
        NSLog(@"no internet");
        if (block) {
            NSString *msg = NSLocalizedString(@"NO INTERNET CONNECTION DETECTED. PLEASE CHECK YOUR INTERNET CONNECTION AND TRY AGAIN.", nil);
            NSString *code = @"100";
            NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
            NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
            block(nil, myError);
        }
        return;
    }
    
    
    NSString *serviceUrl = [NSString stringWithFormat:@"%@/%@", SERVICES_URL, SERVICE_GET_PLAYERS_BY_CATEGORY];
    
    NSString *categoryStr = [NSString stringWithFormat:@"%d", category];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       userId, @"token[userid]",
                                       token, @"token[token]",
                                       categoryStr, @"get_players[category]",
                                       nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:serviceUrl
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSDictionary *jsonResponse = nil;
              NSError *jsonError = nil;
              if ([responseObject isKindOfClass:[NSDictionary class]]) {
                  jsonResponse = (NSDictionary *)responseObject;
              } else if ([responseObject isKindOfClass:[NSArray class]]) {
                  NSArray *jsonArray = (NSArray *)responseObject;
                  jsonResponse = (NSDictionary *)[jsonArray objectAtIndex:0];
              } else if ([responseObject isKindOfClass:[NSString class]]) {
                  NSString *jsonStr = (NSString *)responseObject;
                  NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
                  jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
                  if (jsonError) {
                      block(nil, jsonError);
                      return;
                  }
              } else if ([responseObject isKindOfClass:[NSData class]]) {
                  NSData *jsonData = (NSData *)responseObject;
                  jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
                  if (jsonError) {
                      block(nil, jsonError);
                      return;
                  }
              }
              
              if (jsonResponse && block) {
                  int errorNo = [[jsonResponse objectForKey:@"error"] intValue];
                  NSString *msg = [jsonResponse objectForKey:@"message"];
                  
                  if (!errorNo) {
                      NSArray *playersArray = [jsonResponse objectForKey:@"players"];
                      
                      if (playersArray) {
                          block(playersArray, nil);
                      } else {
                          NSString *code = [jsonResponse objectForKey:@"error"];
                          NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
                          NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
                          block(nil, myError);
                      }
                  } else if (errorNo == 10 || [msg isEqualToString:@"INVALID_LOGIN_DATA"]) {
                      if ([UserData sharedUserData].userFacebookId) {
                          [self requestFBLoginWithFBID:[UserData sharedUserData].userFacebookId
                                            andFBToken:nil
                                          andFirstname:[UserData sharedUserData].userFirstname
                                           andLastname:[UserData sharedUserData].userLastname
                                              andEmail:[UserData sharedUserData].userEmail
                                          withDeviceID:nil
                                             withBlock:^(NSDictionary *loginData, NSError *errorLogin) {
                                                 if (!errorLogin && loginData) {
                                                     SET_USERDEFAULTS(SESSION_TOKEN, [loginData objectForKey:@"token"]);
                                                     [UserData sharedUserData].sessionToken = [loginData objectForKey:@"token"];
                                                     [self requestPlayersByCategory:category forUser:[UserData sharedUserData].userDeviceId andToken:[UserData sharedUserData].sessionToken withBlock:block];
                                                 }
                                                 if (errorLogin && block) {
                                                     block(nil, errorLogin);
                                                 }
                                             }];
                      } else if([UserData sharedUserData].userDeviceId) {
                          [self requestGuestLoginWithDeviceID:[UserData sharedUserData].userDeviceId withBlock:^(NSDictionary *loginData, NSError *errorLogin) {
                              if (!errorLogin && loginData) {
                                  SET_USERDEFAULTS(SESSION_TOKEN, [loginData objectForKey:@"token"]);
                                  [UserData sharedUserData].sessionToken = [loginData objectForKey:@"token"];
                                  [self requestPlayersByCategory:category forUser:[UserData sharedUserData].userDeviceId andToken:[UserData sharedUserData].sessionToken withBlock:block];
                              }
                              if (errorLogin && block) {
                                  block(nil, errorLogin);
                              }
                          }];
                      }
                  } else {
                      NSString *msg = [jsonResponse objectForKey:@"message"];
                      NSString *code = [jsonResponse objectForKey:@"error"];
                      NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
                      NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
                      block(nil, myError);
                  }
              }
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if (block) {
                  block(nil, error);
              }
              return;
          }];
}



+ (void)requestSetInitialPlayersBronze:(int)idPlayerBronze silver:(int)idPlayerSilver forUser:(NSString *)userId andToken:(NSString *)token withBlock:(void (^)(NSDictionary *goldPlayer, NSError *error))block
{
    Reachability *reachConn = [Reachability reachabilityForInternetConnection];
    if (reachConn.currentReachabilityStatus == NotReachable) {
        NSLog(@"no internet");
        if (block) {
            NSString *msg = NSLocalizedString(@"NO INTERNET CONNECTION DETECTED. PLEASE CHECK YOUR INTERNET CONNECTION AND TRY AGAIN.", nil);
            NSString *code = @"100";
            NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
            NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
            block(nil, myError);
        }
        return;
    }
    
    
    NSString *serviceUrl = [NSString stringWithFormat:@"%@/%@", SERVICES_URL, SERVICE_SET_INITIAL_PLAYERS];
    
    NSString *bronzeId = [NSString stringWithFormat:@"%d", idPlayerBronze];
    NSString *silverId = [NSString stringWithFormat:@"%d", idPlayerSilver];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       userId, @"token[userid]",
                                       token, @"token[token]",
                                       bronzeId, @"initial_players[bronze_id]",
                                       silverId, @"initial_players[silver_id]",
                                       nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:serviceUrl
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSDictionary *jsonResponse = nil;
              NSError *jsonError = nil;
              if ([responseObject isKindOfClass:[NSDictionary class]]) {
                  jsonResponse = (NSDictionary *)responseObject;
              } else if ([responseObject isKindOfClass:[NSArray class]]) {
                  NSArray *jsonArray = (NSArray *)responseObject;
                  jsonResponse = (NSDictionary *)[jsonArray objectAtIndex:0];
              } else if ([responseObject isKindOfClass:[NSString class]]) {
                  NSString *jsonStr = (NSString *)responseObject;
                  NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
                  jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
                  if (jsonError) {
                      block(nil, jsonError);
                      return;
                  }
              } else if ([responseObject isKindOfClass:[NSData class]]) {
                  NSData *jsonData = (NSData *)responseObject;
                  jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
                  if (jsonError) {
                      block(nil, jsonError);
                      return;
                  }
              }
              
              if (jsonResponse && block) {
                  int errorNo = [[jsonResponse objectForKey:@"error"] intValue];
                  
                  if (!errorNo) {
                      NSMutableDictionary *gold = [NSMutableDictionary dictionaryWithDictionary:[jsonResponse objectForKey:@"gold_player"]];
                      
                      if (gold) {
                          NSMutableArray *imagesGolds = [[NSMutableArray alloc] init];
                          [InitialServices requestPlayersByCategory:PlayerCategoryGold forUser:userId andToken:token withBlock:^(NSArray *players, NSError *error) {
                              if (!error && players && players.count) {
                                  for (NSDictionary *item in players) {
                                      NSDictionary *photo = [item objectForKey:@"photo"];
                                      NSString *playerImg = [photo objectForKey:@"small"];
                                      [imagesGolds addObject:playerImg];
                                  }
                                  
                                  [gold setObject:imagesGolds forKey:@"goldenImages"];
                              }
                              
                              block(gold, nil);
                          }];
                      } else {
                          NSString *msg = [jsonResponse objectForKey:@"message"];
                          NSString *code = [jsonResponse objectForKey:@"error"];
                          NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
                          NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
                          block(nil, myError);
                      }
                  } else {
                      NSString *msg = [jsonResponse objectForKey:@"message"];
                      NSString *code = [jsonResponse objectForKey:@"error"];
                      NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
                      NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
                      block(nil, myError);
                  }
              }
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if (block) {
                  block(nil, error);
              }
              return;
          }];
}




+ (void)requestRegisterPushToken:(NSString *)pushToken ForUser:(NSString *)userId andToken:(NSString *)token withBlock:(void (^)(NSDictionary *result, NSError *error))block
{
    Reachability *reachConn = [Reachability reachabilityForInternetConnection];
    if (reachConn.currentReachabilityStatus == NotReachable) {
        NSLog(@"no internet");
        if (block) {
            NSString *msg = NSLocalizedString(@"NO INTERNET CONNECTION DETECTED. PLEASE CHECK YOUR INTERNET CONNECTION AND TRY AGAIN.", nil);
            NSString *code = @"100";
            NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
            NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
            block(nil, myError);
        }
        return;
    }
    
    
    NSString *serviceUrl = [NSString stringWithFormat:@"%@/%@", SERVICES_URL, SERVICE_REGISTER_PUSH];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       userId, @"token[userid]",
                                       token, @"token[token]",
                                       pushToken, @"ios_push_register[token_ios]",
                                       nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:serviceUrl
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSDictionary *jsonResponse = nil;
              NSError *jsonError = nil;
              if ([responseObject isKindOfClass:[NSDictionary class]]) {
                  jsonResponse = (NSDictionary *)responseObject;
              } else if ([responseObject isKindOfClass:[NSArray class]]) {
                  NSArray *jsonArray = (NSArray *)responseObject;
                  jsonResponse = (NSDictionary *)[jsonArray objectAtIndex:0];
              } else if ([responseObject isKindOfClass:[NSString class]]) {
                  NSString *jsonStr = (NSString *)responseObject;
                  NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
                  jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
                  if (jsonError) {
                      block(nil, jsonError);
                      return;
                  }
              } else if ([responseObject isKindOfClass:[NSData class]]) {
                  NSData *jsonData = (NSData *)responseObject;
                  jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
                  if (jsonError) {
                      block(nil, jsonError);
                      return;
                  }
              }
              
              if (jsonResponse && block) {
                  int errorNo = [[jsonResponse objectForKey:@"error"] intValue];
                  
                  if (!errorNo) {
                      if (block) {
                          block(jsonResponse, nil);
                      } else {
                          NSString *msg = [jsonResponse objectForKey:@"message"];
                          NSString *code = [jsonResponse objectForKey:@"error"];
                          NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
                          NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
                          block(nil, myError);
                      }
                  } else {
                      NSString *msg = [jsonResponse objectForKey:@"message"];
                      NSString *code = [jsonResponse objectForKey:@"error"];
                      NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
                      NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
                      block(nil, myError);
                  }
              }
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if (block) {
                  block(nil, error);
              }
              return;
          }];
}



+ (void)requestNotificationsForUser:(NSString *)userId andToken:(NSString *)token withBlock:(void (^)(NSArray *notifications, NSError *error))block
{
    Reachability *reachConn = [Reachability reachabilityForInternetConnection];
    if (reachConn.currentReachabilityStatus == NotReachable) {
        NSLog(@"no internet");
        if (block) {
            NSString *msg = NSLocalizedString(@"NO INTERNET CONNECTION DETECTED. PLEASE CHECK YOUR INTERNET CONNECTION AND TRY AGAIN.", nil);
            NSString *code = @"100";
            NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
            NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
            block(nil, myError);
        }
        return;
    }
    
    
    NSString *serviceUrl = [NSString stringWithFormat:@"%@/%@", SERVICES_URL, SERVICE_GET_NOTIFICATIONS];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       userId, @"token[userid]",
                                       token, @"token[token]",
                                       nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:serviceUrl
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSDictionary *jsonResponse = nil;
              NSError *jsonError = nil;
              if ([responseObject isKindOfClass:[NSDictionary class]]) {
                  jsonResponse = (NSDictionary *)responseObject;
              } else if ([responseObject isKindOfClass:[NSArray class]]) {
                  NSArray *jsonArray = (NSArray *)responseObject;
                  jsonResponse = (NSDictionary *)[jsonArray objectAtIndex:0];
              } else if ([responseObject isKindOfClass:[NSString class]]) {
                  NSString *jsonStr = (NSString *)responseObject;
                  NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
                  jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
                  if (jsonError) {
                      block(nil, jsonError);
                      return;
                  }
              } else if ([responseObject isKindOfClass:[NSData class]]) {
                  NSData *jsonData = (NSData *)responseObject;
                  jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
                  if (jsonError) {
                      block(nil, jsonError);
                      return;
                  }
              }
              
              if (jsonResponse && block) {
                  int errorNo = [[jsonResponse objectForKey:@"error"] intValue];
                  
                  if (!errorNo) {
                      NSArray *result = [jsonResponse objectForKey:@"notifications"];
                      if (result) {
                          block(result, nil);
                      } else {
                          NSString *msg = [jsonResponse objectForKey:@"message"];
                          NSString *code = [jsonResponse objectForKey:@"error"];
                          NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
                          NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
                          block(nil, myError);
                      }
                  } else {
                      NSString *msg = [jsonResponse objectForKey:@"message"];
                      NSString *code = [jsonResponse objectForKey:@"error"];
                      NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
                      NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
                      block(nil, myError);
                  }
              }
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if (block) {
                  block(nil, error);
              }
              return;
          }];
}





+ (void)requestBuyablePlayersForUser:(NSString *)userId andToken:(NSString *)token withBlock:(void (^)(NSArray *players, NSError *error))block
{
    Reachability *reachConn = [Reachability reachabilityForInternetConnection];
    if (reachConn.currentReachabilityStatus == NotReachable) {
        NSLog(@"no internet");
        if (block) {
            NSString *msg = NSLocalizedString(@"NO INTERNET CONNECTION DETECTED. PLEASE CHECK YOUR INTERNET CONNECTION AND TRY AGAIN.", nil);
            NSString *code = @"100";
            NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
            NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
            block(nil, myError);
        }
        return;
    }
    
    
    NSString *serviceUrl = [NSString stringWithFormat:@"%@/%@", SERVICES_URL, SERVICE_GET_BUYABLE_PLAYERS];
    
    //    NSString *tokenStr = @"df270a224f1fc745b64115efe1a95c8d23e7cfd4";
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       userId, @"token[userid]",
                                       token, @"token[token]",
                                       nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:serviceUrl
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSDictionary *jsonResponse = nil;
              NSError *jsonError = nil;
              if ([responseObject isKindOfClass:[NSDictionary class]]) {
                  jsonResponse = (NSDictionary *)responseObject;
              } else if ([responseObject isKindOfClass:[NSArray class]]) {
                  NSArray *jsonArray = (NSArray *)responseObject;
                  jsonResponse = (NSDictionary *)[jsonArray objectAtIndex:0];
              } else if ([responseObject isKindOfClass:[NSString class]]) {
                  NSString *jsonStr = (NSString *)responseObject;
                  NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
                  jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
                  if (jsonError) {
                      block(nil, jsonError);
                      return;
                  }
              } else if ([responseObject isKindOfClass:[NSData class]]) {
                  NSData *jsonData = (NSData *)responseObject;
                  jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
                  if (jsonError) {
                      block(nil, jsonError);
                      return;
                  }
              }
              
              if (jsonResponse && block) {
                  int errorNo = [[jsonResponse objectForKey:@"error"] intValue];
                  NSString *msg = [jsonResponse objectForKey:@"message"];
                  
                  if (!errorNo) {
                      NSDictionary *userDict = [jsonResponse objectForKey:@"user"];
                      if (userDict) {
                          [UserData sharedUserData].userCoins = [[userDict objectForKey:@"money"] longLongValue];
                          [UserData sharedUserData].userExperience = [[userDict objectForKey:@"experience"] longLongValue];
                          [UserData sharedUserData].userSuperGoals = [[userDict objectForKey:@"super_goals"] longLongValue];
                      }
                      int qtyNoti = [[jsonResponse objectForKey:@"unread_notifications_count"] intValue];
                      [UserData sharedUserData].userNewNotifications = qtyNoti;
                      
                      NSArray *playersArray = [jsonResponse objectForKey:@"players"];
                      
                      if (playersArray) {
                          block(playersArray, nil);
                      } else {
                          NSString *code = [jsonResponse objectForKey:@"error"];
                          NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
                          NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
                          block(nil, myError);
                      }
                  } else {
                      NSString *code = [jsonResponse objectForKey:@"error"];
                      NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
                      NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
                      block(nil, myError);
                  }
              }
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if (block) {
                  block(nil, error);
              }
              return;
          }];
}


+ (void)requestIAPProductsForUser:(NSString *)userId andToken:(NSString *)token withBlock:(void (^)(NSArray *products, NSError *error))block
{
    Reachability *reachConn = [Reachability reachabilityForInternetConnection];
    if (reachConn.currentReachabilityStatus == NotReachable) {
        NSLog(@"no internet");
        if (block) {
            NSString *msg = NSLocalizedString(@"NO INTERNET CONNECTION DETECTED. PLEASE CHECK YOUR INTERNET CONNECTION AND TRY AGAIN.", nil);
            NSString *code = @"100";
            NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
            NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
            block(nil, myError);
        }
        return;
    }
    
    
    NSString *serviceUrl = [NSString stringWithFormat:@"%@/%@", SERVICES_URL, SERVICE_GET_IAP_PRODUCTS];
    
    //    NSString *tokenStr = @"df270a224f1fc745b64115efe1a95c8d23e7cfd4";
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       userId, @"token[userid]",
                                       token, @"token[token]",
                                       nil];
    
    
    // DEBUG
    NSArray *result = [NSArray arrayWithObjects:@"com.byyuto.wofa.coinspack100", @"com.byyuto.wofa.coinspack300",  nil];
    block(result, nil);
    return;
    // END DEBUG
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:serviceUrl
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSDictionary *jsonResponse = nil;
              NSError *jsonError = nil;
              if ([responseObject isKindOfClass:[NSDictionary class]]) {
                  jsonResponse = (NSDictionary *)responseObject;
              } else if ([responseObject isKindOfClass:[NSArray class]]) {
                  NSArray *jsonArray = (NSArray *)responseObject;
                  jsonResponse = (NSDictionary *)[jsonArray objectAtIndex:0];
              } else if ([responseObject isKindOfClass:[NSString class]]) {
                  NSString *jsonStr = (NSString *)responseObject;
                  NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
                  jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
                  if (jsonError) {
                      block(nil, jsonError);
                      return;
                  }
              } else if ([responseObject isKindOfClass:[NSData class]]) {
                  NSData *jsonData = (NSData *)responseObject;
                  jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
                  if (jsonError) {
                      block(nil, jsonError);
                      return;
                  }
              }
              
              if (jsonResponse && block) {
                  int errorNo = [[jsonResponse objectForKey:@"error"] intValue];
                  NSString *msg = [jsonResponse objectForKey:@"message"];
                  
                  if (!errorNo) {
                      NSDictionary *userDict = [jsonResponse objectForKey:@"user"];
                      if (userDict) {
                          [UserData sharedUserData].userCoins = [[userDict objectForKey:@"money"] longLongValue];
                          [UserData sharedUserData].userExperience = [[userDict objectForKey:@"experience"] longLongValue];
                          [UserData sharedUserData].userSuperGoals = [[userDict objectForKey:@"super_goals"] longLongValue];
                      }
                      int qtyNoti = [[jsonResponse objectForKey:@"unread_notifications_count"] intValue];
                      [UserData sharedUserData].userNewNotifications = qtyNoti;
                      
                      NSArray *productsArray = [jsonResponse objectForKey:@"products"];
                      
                      if (productsArray) {
                          block(productsArray, nil);
                      } else {
                          NSString *code = [jsonResponse objectForKey:@"error"];
                          NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
                          NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
                          block(nil, myError);
                      }
                  } else {
                      NSString *code = [jsonResponse objectForKey:@"error"];
                      NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
                      NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
                      block(nil, myError);
                  }
              }
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if (block) {
                  block(nil, error);
              }
              return;
          }];
}




+ (void)requestBuyableProductsForUser:(NSString *)userId andToken:(NSString *)token withBlock:(void (^)(NSDictionary *userInfo, NSError *error))block
{
    Reachability *reachConn = [Reachability reachabilityForInternetConnection];
    if (reachConn.currentReachabilityStatus == NotReachable) {
        NSLog(@"no internet");
        if (block) {
            NSString *msg = NSLocalizedString(@"NO INTERNET CONNECTION DETECTED. PLEASE CHECK YOUR INTERNET CONNECTION AND TRY AGAIN.", nil);
            NSString *code = @"100";
            NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
            NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
            block(nil, myError);
        }
        return;
    }
    
    
    NSString *serviceUrl = [NSString stringWithFormat:@"%@/%@", SERVICES_URL, SERVICE_GET_BUYABLE_PRODUCTS];
    
    //    NSString *tokenStr = @"df270a224f1fc745b64115efe1a95c8d23e7cfd4";
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       userId, @"token[userid]",
                                       token, @"token[token]",
                                       nil];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:serviceUrl
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSDictionary *jsonResponse = nil;
              NSError *jsonError = nil;
              if ([responseObject isKindOfClass:[NSDictionary class]]) {
                  jsonResponse = (NSDictionary *)responseObject;
              } else if ([responseObject isKindOfClass:[NSArray class]]) {
                  NSArray *jsonArray = (NSArray *)responseObject;
                  jsonResponse = (NSDictionary *)[jsonArray objectAtIndex:0];
              } else if ([responseObject isKindOfClass:[NSString class]]) {
                  NSString *jsonStr = (NSString *)responseObject;
                  NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
                  jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
                  if (jsonError) {
                      block(nil, jsonError);
                      return;
                  }
              } else if ([responseObject isKindOfClass:[NSData class]]) {
                  NSData *jsonData = (NSData *)responseObject;
                  jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
                  if (jsonError) {
                      block(nil, jsonError);
                      return;
                  }
              }
              
              if (jsonResponse && block) {
                  int errorNo = [[jsonResponse objectForKey:@"error"] intValue];
                  NSString *msg = [jsonResponse objectForKey:@"message"];
                  
                  if (!errorNo) {
                      NSDictionary *userDict = jsonResponse;
                      if (userDict) {
                          block(userDict, nil);
                      } else {
                          NSString *code = [jsonResponse objectForKey:@"error"];
                          NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
                          NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
                          block(nil, myError);
                      }
                  } else {
                      NSString *code = [jsonResponse objectForKey:@"error"];
                      NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
                      NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
                      block(nil, myError);
                  }
              }
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if (block) {
                  block(nil, error);
              }
              return;
          }];
}





+ (void)requestTermsAndConditionsWithBlock:(void (^)(NSString *termsText, NSError *error))block
{
    Reachability *reachConn = [Reachability reachabilityForInternetConnection];
    if (reachConn.currentReachabilityStatus == NotReachable) {
        NSLog(@"no internet");
        if (block) {
            NSString *msg = NSLocalizedString(@"NO INTERNET CONNECTION DETECTED. PLEASE CHECK YOUR INTERNET CONNECTION AND TRY AGAIN.", nil);
            NSString *code = @"100";
            NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
            NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
            block(nil, myError);
        }
        return;
    }
    
    
    NSString *serviceUrl = [NSString stringWithFormat:@"%@/%@", SERVICES_URL, SERVICE_GET_TERMS_CONDITIONS];

    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:serviceUrl]];
    NSString *result = nil;
    if (data) {
        result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    
    if (block) {
        if (result) {
            block(result, nil);
        } else {
            NSString *code = @"500";
            NSString *msg = @"Error getting Terms And Conditions";
            NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
            NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
            block(nil, myError);
        }
    }
}




+ (void)requestUnreadNotificationsCountForUser:(NSString *)userId andToken:(NSString *)token withBlock:(void (^)(NSDictionary *notifications, NSError *error))block
{
    Reachability *reachConn = [Reachability reachabilityForInternetConnection];
    if (reachConn.currentReachabilityStatus == NotReachable) {
        NSLog(@"no internet");
        if (block) {
            NSString *msg = NSLocalizedString(@"NO INTERNET CONNECTION DETECTED. PLEASE CHECK YOUR INTERNET CONNECTION AND TRY AGAIN.", nil);
            NSString *code = @"100";
            NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
            NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
            block(nil, myError);
        }
        return;
    }
    
    
    NSString *serviceUrl = [NSString stringWithFormat:@"%@/%@", SERVICES_URL, SERVICE_GET_UNREAD_NOTIFICATIONS_COUNT];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       userId, @"token[userid]",
                                       token, @"token[token]",
                                       nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:serviceUrl
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSDictionary *jsonResponse = nil;
              NSError *jsonError = nil;
              if ([responseObject isKindOfClass:[NSDictionary class]]) {
                  jsonResponse = (NSDictionary *)responseObject;
              } else if ([responseObject isKindOfClass:[NSArray class]]) {
                  NSArray *jsonArray = (NSArray *)responseObject;
                  jsonResponse = (NSDictionary *)[jsonArray objectAtIndex:0];
              } else if ([responseObject isKindOfClass:[NSString class]]) {
                  NSString *jsonStr = (NSString *)responseObject;
                  NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
                  jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
                  if (jsonError) {
                      block(nil, jsonError);
                      return;
                  }
              } else if ([responseObject isKindOfClass:[NSData class]]) {
                  NSData *jsonData = (NSData *)responseObject;
                  jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
                  if (jsonError) {
                      block(nil, jsonError);
                      return;
                  }
              }
              
              if (jsonResponse && block) {
                  int errorNo = [[jsonResponse objectForKey:@"error"] intValue];
                  
                  if (!errorNo) {
                      if (jsonResponse) {
                          block(jsonResponse, nil);
                      } else {
                          NSString *msg = [jsonResponse objectForKey:@"message"];
                          NSString *code = [jsonResponse objectForKey:@"error"];
                          NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
                          NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
                          block(nil, myError);
                      }
                  } else {
                      NSString *msg = [jsonResponse objectForKey:@"message"];
                      NSString *code = [jsonResponse objectForKey:@"error"];
                      NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
                      NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
                      block(nil, myError);
                  }
              }
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if (block) {
                  block(nil, error);
              }
              return;
          }];
}




+ (void)requestNewsForUser:(NSString *)userId andToken:(NSString *)token withBlock:(void (^)(NSDictionary *userInfo, NSError *error))block
{
    Reachability *reachConn = [Reachability reachabilityForInternetConnection];
    if (reachConn.currentReachabilityStatus == NotReachable) {
        NSLog(@"no internet");
        if (block) {
            NSString *msg = NSLocalizedString(@"NO INTERNET CONNECTION DETECTED. PLEASE CHECK YOUR INTERNET CONNECTION AND TRY AGAIN.", nil);
            NSString *code = @"100";
            NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
            NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
            block(nil, myError);
        }
        return;
    }
    
    
    NSString *serviceUrl = [NSString stringWithFormat:@"%@/%@", SERVICES_URL, SERVICE_GET_NEWS];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       userId, @"token[userid]",
                                       token, @"token[token]",
                                       nil];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:serviceUrl
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSDictionary *jsonResponse = nil;
              NSError *jsonError = nil;
              if ([responseObject isKindOfClass:[NSDictionary class]]) {
                  jsonResponse = (NSDictionary *)responseObject;
              } else if ([responseObject isKindOfClass:[NSArray class]]) {
                  NSArray *jsonArray = (NSArray *)responseObject;
                  jsonResponse = (NSDictionary *)[jsonArray objectAtIndex:0];
              } else if ([responseObject isKindOfClass:[NSString class]]) {
                  NSString *jsonStr = (NSString *)responseObject;
                  NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
                  jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
                  if (jsonError) {
                      block(nil, jsonError);
                      return;
                  }
              } else if ([responseObject isKindOfClass:[NSData class]]) {
                  NSData *jsonData = (NSData *)responseObject;
                  jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
                  if (jsonError) {
                      block(nil, jsonError);
                      return;
                  }
              }
              
              if (jsonResponse && block) {
                  int errorNo = [[jsonResponse objectForKey:@"error"] intValue];
                  NSString *msg = [jsonResponse objectForKey:@"message"];
                  
                  if (!errorNo) {
                      NSDictionary *userDict = jsonResponse;
                      if (userDict) {
                          block(userDict, nil);
                      } else {
                          NSString *code = [jsonResponse objectForKey:@"error"];
                          NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
                          NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
                          block(nil, myError);
                      }
                  } else {
                      NSString *code = [jsonResponse objectForKey:@"error"];
                      NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
                      NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
                      block(nil, myError);
                  }
              }
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if (block) {
                  block(nil, error);
              }
              return;
          }];
}





+ (void)requestLeaderboardFriendsForUser:(NSString *)userId andToken:(NSString *)token andFBFriends:(NSArray *)fbFriends withBlock:(void (^)(NSDictionary *userInfo, NSError *error))block
{
    Reachability *reachConn = [Reachability reachabilityForInternetConnection];
    if (reachConn.currentReachabilityStatus == NotReachable) {
        NSLog(@"no internet");
        if (block) {
            NSString *msg = NSLocalizedString(@"NO INTERNET CONNECTION DETECTED. PLEASE CHECK YOUR INTERNET CONNECTION AND TRY AGAIN.", nil);
            NSString *code = @"100";
            NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
            NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
            block(nil, myError);
        }
        return;
    }
    
    
    NSString *serviceUrl = [NSString stringWithFormat:@"%@/%@", SERVICES_URL, SERVICE_GET_LEADERBOARD_FRIENDS];
    
    NSString *fbFriendsStr = [fbFriends componentsJoinedByString:@","];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       userId, @"token[userid]",
                                       token, @"token[token]",
                                       fbFriendsStr, @"get_friends_leaderboard[friends_ids]",
                                       nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:serviceUrl
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSDictionary *jsonResponse = nil;
              NSError *jsonError = nil;
              if ([responseObject isKindOfClass:[NSDictionary class]]) {
                  jsonResponse = (NSDictionary *)responseObject;
              } else if ([responseObject isKindOfClass:[NSArray class]]) {
                  NSArray *jsonArray = (NSArray *)responseObject;
                  jsonResponse = (NSDictionary *)[jsonArray objectAtIndex:0];
              } else if ([responseObject isKindOfClass:[NSString class]]) {
                  NSString *jsonStr = (NSString *)responseObject;
                  NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
                  jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
                  if (jsonError) {
                      block(nil, jsonError);
                      return;
                  }
              } else if ([responseObject isKindOfClass:[NSData class]]) {
                  NSData *jsonData = (NSData *)responseObject;
                  jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
                  if (jsonError) {
                      block(nil, jsonError);
                      return;
                  }
              }
              
              if (jsonResponse && block) {
                  int errorNo = [[jsonResponse objectForKey:@"error"] intValue];
                  
                  if (!errorNo) {
                      if (jsonResponse) {
                          block(jsonResponse, nil);
                      } else {
                          NSString *msg = [jsonResponse objectForKey:@"message"];
                          NSString *code = [jsonResponse objectForKey:@"error"];
                          NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
                          NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
                          block(nil, myError);
                      }
                  } else {
                      NSString *msg = [jsonResponse objectForKey:@"message"];
                      NSString *code = [jsonResponse objectForKey:@"error"];
                      NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
                      NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
                      block(nil, myError);
                  }
              }
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if (block) {
                  block(nil, error);
              }
              return;
          }];
}





+ (void)requestWorldLeaderboardsForUser:(NSString *)userId andToken:(NSString *)token withBlock:(void (^)(NSDictionary *userInfo, NSError *error))block
{
    Reachability *reachConn = [Reachability reachabilityForInternetConnection];
    if (reachConn.currentReachabilityStatus == NotReachable) {
        NSLog(@"no internet");
        if (block) {
            NSString *msg = NSLocalizedString(@"NO INTERNET CONNECTION DETECTED. PLEASE CHECK YOUR INTERNET CONNECTION AND TRY AGAIN.", nil);
            NSString *code = @"100";
            NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
            NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
            block(nil, myError);
        }
        return;
    }
    
    
    NSString *serviceUrl = [NSString stringWithFormat:@"%@/%@", SERVICES_URL, SERVICE_GET_LEADERBOARD_GLOBAL];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       userId, @"token[userid]",
                                       token, @"token[token]",
                                       nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:serviceUrl
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSDictionary *jsonResponse = nil;
              NSError *jsonError = nil;
              if ([responseObject isKindOfClass:[NSDictionary class]]) {
                  jsonResponse = (NSDictionary *)responseObject;
              } else if ([responseObject isKindOfClass:[NSArray class]]) {
                  NSArray *jsonArray = (NSArray *)responseObject;
                  jsonResponse = (NSDictionary *)[jsonArray objectAtIndex:0];
              } else if ([responseObject isKindOfClass:[NSString class]]) {
                  NSString *jsonStr = (NSString *)responseObject;
                  NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
                  jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
                  if (jsonError) {
                      block(nil, jsonError);
                      return;
                  }
              } else if ([responseObject isKindOfClass:[NSData class]]) {
                  NSData *jsonData = (NSData *)responseObject;
                  jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
                  if (jsonError) {
                      block(nil, jsonError);
                      return;
                  }
              }
              
              if (jsonResponse && block) {
                  int errorNo = [[jsonResponse objectForKey:@"error"] intValue];
                  
                  if (!errorNo) {
                      if (jsonResponse) {
                          block(jsonResponse, nil);
                      } else {
                          NSString *msg = [jsonResponse objectForKey:@"message"];
                          NSString *code = [jsonResponse objectForKey:@"error"];
                          NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
                          NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
                          block(nil, myError);
                      }
                  } else {
                      NSString *msg = [jsonResponse objectForKey:@"message"];
                      NSString *code = [jsonResponse objectForKey:@"error"];
                      NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
                      NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
                      block(nil, myError);
                  }
              }
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if (block) {
                  block(nil, error);
              }
              return;
          }];
}





+ (void)requestLinkAccountWithFBID:(NSString *)fbid andFBToken:(NSString *)tokenData andFirstname:(NSString *)fname andLastname:(NSString *)lname andEmail:(NSString *)email withDeviceID:(NSString *)deviceGuestId withBlock:(void (^)(NSDictionary *loginData, NSError *error))block
{
    Reachability *reachConn = [Reachability reachabilityForInternetConnection];
    if (reachConn.currentReachabilityStatus == NotReachable) {
        NSLog(@"no internet");
        if (block) {
            NSString *msg = NSLocalizedString(@"NO INTERNET CONNECTION DETECTED. PLEASE CHECK YOUR INTERNET CONNECTION AND TRY AGAIN.", nil);
            NSString *code = @"100";
            NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
            NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
            block(nil, myError);
        }
        return;
    }
    
    
    NSString *serviceUrl = [NSString stringWithFormat:@"%@/%@", SERVICES_URL, SERVICE_FB_LOGIN];
    
    NSString *loginDev = SERVICE_DEVICE;
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       fbid, @"login[facebook_id]",
                                       fname, @"login[firstname]",
                                       lname, @"login[lastname]",
                                       email, @"login[email]",
                                       tokenData, @"login[access_token]",
                                       //@"0", @"login[birthday]",
                                       loginDev, @"login[device]",
                                       nil];
    if (deviceGuestId) {
        [parameters setObject:deviceGuestId forKey:@"login[device_id]"];
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:serviceUrl
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSDictionary *jsonResponse = nil;
              NSError *jsonError = nil;
              if ([responseObject isKindOfClass:[NSDictionary class]]) {
                  jsonResponse = (NSDictionary *)responseObject;
              } else if ([responseObject isKindOfClass:[NSArray class]]) {
                  NSArray *jsonArray = (NSArray *)responseObject;
                  jsonResponse = (NSDictionary *)[jsonArray objectAtIndex:0];
              } else if ([responseObject isKindOfClass:[NSString class]]) {
                  NSString *jsonStr = (NSString *)responseObject;
                  NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
                  jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
                  if (jsonError) {
                      block(nil, jsonError);
                      return;
                  }
              } else if ([responseObject isKindOfClass:[NSData class]]) {
                  NSData *jsonData = (NSData *)responseObject;
                  jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
                  if (jsonError) {
                      block(nil, jsonError);
                      return;
                  }
              }
              
              if (jsonResponse && block) {
                  int errorNo = [[jsonResponse objectForKey:@"error"] intValue];
                  
                  if (!errorNo) {
                      NSDictionary *userDict = [jsonResponse objectForKey:@"user"];
                      NSDictionary *conflictDict = [jsonResponse objectForKey:@"account_conflict"];
                      
                      if (userDict || conflictDict) {
                          // Create or modify the UserData static object
                          if (userDict && !conflictDict) {
                              UserData *userDt = [UserData sharedUserData];
                              userDt.userFirstname = fname;
                              userDt.userLastname = lname;
                              userDt.userFacebookId = fbid;
                              userDt.userEmail = email;
                              userDt.sessionToken = [userDict objectForKey:@"token"];
                              userDt.userDeviceId = [userDict objectForKey:@"userid"];
                              userDt.userCoins = [[userDict objectForKey:@"momey"] intValue];
                              userDt.userExperience = [[userDict objectForKey:@"experience"] intValue];
                              userDt.userSuperGoals = [[userDict objectForKey:@"super_goals"] intValue];
                          }
                          
                          // Call the block success mode
                          block(jsonResponse, nil);
                      } else {
                          NSString *msg = [jsonResponse objectForKey:@"message"];
                          NSString *code = [jsonResponse objectForKey:@"error"];
                          NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
                          NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
                          block(jsonResponse, myError);
                      }
                  } else {
                      NSString *msg = [jsonResponse objectForKey:@"message"];
                      NSString *code = [jsonResponse objectForKey:@"error"];
                      NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
                      NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
                      block(jsonResponse, myError);
                  }
              }
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if (block) {
                  block(nil, error);
              }
              return;
          }];
}





+ (void)resolveLinkAccountWithFBID:(NSString *)fbid andFBToken:(NSString *)tokenData andFirstname:(NSString *)fname andLastname:(NSString *)lname andEmail:(NSString *)email withDeviceID:(NSString *)deviceGuestId withSelectedAccount:(NSString *)selectedAccount withBlock:(void (^)(NSDictionary *loginData, NSError *error))block
{
    Reachability *reachConn = [Reachability reachabilityForInternetConnection];
    if (reachConn.currentReachabilityStatus == NotReachable) {
        NSLog(@"no internet");
        if (block) {
            NSString *msg = NSLocalizedString(@"NO INTERNET CONNECTION DETECTED. PLEASE CHECK YOUR INTERNET CONNECTION AND TRY AGAIN.", nil);
            NSString *code = @"100";
            NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
            NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
            block(nil, myError);
        }
        return;
    }
    
    
    NSString *serviceUrl = [NSString stringWithFormat:@"%@/%@", SERVICES_URL, SERVICE_FB_LOGIN];
    
    NSString *loginDev = SERVICE_DEVICE;
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       fbid, @"login[facebook_id]",
                                       fname, @"login[firstname]",
                                       lname, @"login[lastname]",
                                       email, @"login[email]",
                                       tokenData, @"login[access_token]",
                                       //@"0", @"login[birthday]",
                                       loginDev, @"login[device]",
                                       selectedAccount, @"login[account_selected]",
                                       nil];
    if (deviceGuestId) {
        [parameters setObject:deviceGuestId forKey:@"login[device_id]"];
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:serviceUrl
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSDictionary *jsonResponse = nil;
              NSError *jsonError = nil;
              if ([responseObject isKindOfClass:[NSDictionary class]]) {
                  jsonResponse = (NSDictionary *)responseObject;
              } else if ([responseObject isKindOfClass:[NSArray class]]) {
                  NSArray *jsonArray = (NSArray *)responseObject;
                  jsonResponse = (NSDictionary *)[jsonArray objectAtIndex:0];
              } else if ([responseObject isKindOfClass:[NSString class]]) {
                  NSString *jsonStr = (NSString *)responseObject;
                  NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
                  jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
                  if (jsonError) {
                      block(nil, jsonError);
                      return;
                  }
              } else if ([responseObject isKindOfClass:[NSData class]]) {
                  NSData *jsonData = (NSData *)responseObject;
                  jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
                  if (jsonError) {
                      block(nil, jsonError);
                      return;
                  }
              }
              
              if (jsonResponse && block) {
                  int errorNo = [[jsonResponse objectForKey:@"error"] intValue];
                  
                  if (!errorNo) {
                      NSDictionary *userDict = [jsonResponse objectForKey:@"user"];
                      
                      if (userDict) {
                          // Create or modify the UserData static object
                          UserData *userDt = [UserData sharedUserData];
                          userDt.userFirstname = fname;
                          userDt.userLastname = lname;
                          userDt.userFacebookId = fbid;
                          userDt.userEmail = email;
                          userDt.sessionToken = [userDict objectForKey:@"token"];
                          userDt.userDeviceId = [userDict objectForKey:@"userid"];
                          userDt.userCoins = [[userDict objectForKey:@"momey"] intValue];
                          userDt.userExperience = [[userDict objectForKey:@"experience"] intValue];
                          userDt.userSuperGoals = [[userDict objectForKey:@"super_goals"] intValue];
                          
                          // Call the block success mode
                          block(jsonResponse, nil);
                      } else {
                          NSString *msg = [jsonResponse objectForKey:@"message"];
                          NSString *code = [jsonResponse objectForKey:@"error"];
                          NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
                          NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
                          block(jsonResponse, myError);
                      }
                  } else {
                      NSString *msg = [jsonResponse objectForKey:@"message"];
                      NSString *code = [jsonResponse objectForKey:@"error"];
                      NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg, NSLocalizedDescriptionKey, code, @"wofa-error", nil];
                      NSError *myError = [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:errorInfo];
                      block(jsonResponse, myError);
                  }
              }
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if (block) {
                  block(nil, error);
              }
              return;
          }];
}




@end
