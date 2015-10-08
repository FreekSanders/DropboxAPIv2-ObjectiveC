//
//  AppDelegate.m
//  Test Dropbox APIv2
//
//  Created by Freek Sanders on 08-10-15.
//  Copyright © 2015 Freek Sanders. All rights reserved.
//

#import "AppDelegate.h"
#import "Test_Dropbox_APIv2-Swift.h"

@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    DropboxService *dropbox = [[DropboxService alloc] init];
    bool result = [dropbox handleRedirectURL:url];
    if(result) {
        NSLog(@"Successfully connected");
    }
    else {
        NSLog(@"Problem connecting");
    }
     
    return NO;
}

@end
