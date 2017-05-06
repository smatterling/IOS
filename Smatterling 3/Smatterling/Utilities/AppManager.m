//
//  AppManager.m
//  Smatterling
//
//  Created by Muhammad Usama on 23/03/2017.
//  Copyright © 2017 AlphaAlgorithms. All rights reserved.
//

#import "AppManager.h"

@implementation AppManager
@synthesize userLatitude, userLongitude, isHostingProcessComplete, isLocationHidden, userCity;

static AppManager* sharedInstance;

+ (AppManager *) sharedInstance
{
    if (!sharedInstance){
        @synchronized(self)
        {
            if (!sharedInstance)
            {
                sharedInstance = [[AppManager alloc] init];
            }
        }
    }
    return sharedInstance;
}

+(id) alloc
{
    @synchronized(self)
    {
        NSAssert(sharedInstance == nil, @"Attempted to allocate a second instance of a singleton SettingsManager.");
        sharedInstance = [super alloc];
    }
    
    return sharedInstance;
}



@end
