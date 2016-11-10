//
//  AppDelegate.h
//  Shobha Asasr
//
//  Created by AscratechMacmini on 13/10/16.
//  Copyright © 2016 Ascra. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomerLogInVC,CollectionVC,EmployeeLoginVC,SplashScreen;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) CustomerLogInVC *customLogin;
@property (strong, nonatomic) CollectionVC *collectionVC;
@property (strong, nonatomic) EmployeeLoginVC *employeeLoginVC;
@property (strong,nonatomic) SplashScreen *splashScreen;

@property (strong, nonatomic) NSMutableArray *wishListCount,*cartListCount,*produstID,*productQuantity;



-(void)initializeScreen;
-(void)customerLoginCheck;



@end

