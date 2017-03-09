//
//  AppDelegate.h
//  Smatterling
//
//  Created by Muhammad Usama on 03/03/2017.
//  Copyright © 2017 AlphaAlgorithms. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#define USER_TYPE  @"fan"

#define USER_TYPE_FAN           1
#define USER_TYPE_CELEB         2
#define PAGE_SIZE         @"10"

enum sideBarItems{
    
    SIDEBAR_MYCHANNEL = 0,
    SIDEBAR_SETTINGS = 1,
    SIDEBAR_BILLING = 2,
    SIDEBAR_LOGOUT = 3,
    SIDEBAR_MENU = 4,
};

#define DEFAULT_PAGE_SIZE           10
#define NO_OF_PAGES           4





#define THEME_COLOR_BACKGROUND                 [UIColor colorWithRed:77.0/255.0 green:188.0/255.0 blue:233.0/255.0 alpha:0.8]
#define THEME_COLOR_BLUE            [UIColor colorWithRed:62.0f/255.0f green:101.0f/255.0f blue:160.0f/255.0f alpha:1.0f]
#define THEME_COLOR_GREEN           [UIColor colorWithRed:21.0f/255.0f green:130.0f/255.0f blue:56.0f/255.0f alpha:1.0f]
#define THEME_COLOR_BLUE_SEPERATOR  [UIColor colorWithRed:24.0f/255.0f green:66.0f/255.0f blue:100.0f/255.0f alpha:1.0f]
#define THEME_COLOR_GREEN_SEPERATOR [UIColor colorWithRed:24.0f/255.0f green:109.0f/255.0f blue:66.0f/255.0f alpha:1.0f]
#endif /* Constants_h */
