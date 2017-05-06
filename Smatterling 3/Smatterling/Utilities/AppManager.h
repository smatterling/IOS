//
//  AppManager.h
//  Smatterling
//
//  Created by Muhammad Usama on 23/03/2017.
//  Copyright © 2017 AlphaAlgorithms. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppManager : NSObject

@property (nonatomic) float userLatitude;
@property (nonatomic) float userLongitude;
@property (nonatomic) NSString* userCity;
@property (nonatomic) BOOL isHostingProcessComplete;
@property (nonatomic) BOOL isLocationHidden;

+ (AppManager *) sharedInstance;
@end
