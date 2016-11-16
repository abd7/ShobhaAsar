//
//  AppDelegate.h
//  Shobha Asasr
//
//  Created by AscratechMacmini on 13/10/16.
//  Copyright © 2016 Ascra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "ShobhaAsarDataBase.h"
@class CustomerLogInVC,CollectionVC,EmployeeLoginVC,SplashScreen;
@class ShobhaAsarDataBase;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    ShobhaAsarDataBase *shobhaasarDB;
    
    
    NSString * imgString;
    Reachability* internetReachable;
    Reachability* hostReachable;
    BOOL offlineMessageEnabled;
    ShobhaAsarDataBase * database;
    BOOL alertDisplay;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) CustomerLogInVC *customLogin;
@property (strong, nonatomic) CollectionVC *collectionVC;
@property (strong, nonatomic) EmployeeLoginVC *employeeLoginVC;
@property (strong,nonatomic) SplashScreen *splashScreen;

@property (strong, nonatomic) NSMutableArray *wishListCount,*cartListCount,*produstID,*productQuantity,*ProductArray;



-(void)initializeScreen;
-(void)customerLoginCheck;



@end

