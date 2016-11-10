//
//  AppDelegate.m
//  Shobha Asasr
//
//  Created by AscratechMacmini on 13/10/16.
//  Copyright © 2016 Ascra. All rights reserved.
//

#import "AppDelegate.h"
#import "CustomerRegisterVC.h"
#import "CustomerLogInVC.h"
#import "CollectionVC.h"
#import "EmployeeLoginVC.h"
#import "SplashScreen.h"

@interface AppDelegate ()
{
    UIStoryboard *storyboard;
}

@end

@implementation AppDelegate
@synthesize window = _window;
@synthesize wishListCount,cartListCount,produstID,productQuantity;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
  
    
    wishListCount = [[NSMutableArray alloc]init];
    cartListCount = [[NSMutableArray alloc]init];
    produstID= [[NSMutableArray alloc]init];
    productQuantity= [[NSMutableArray alloc]init];
    
    
    //[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"login"];
    [self initializeScreen];
   
    
    return YES;
}



-(void)initializeScreen
{
   
    BOOL login =[[NSUserDefaults  standardUserDefaults]boolForKey:@"emplogininfo"];
    
    if(!login){
        
        
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        
        _employeeLoginVC = [storyBoard instantiateViewControllerWithIdentifier:@"EmployeeLoginVC"];
        
        self.window.rootViewController = _employeeLoginVC;
    }
    else{
        
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] ;
                ;
                _collectionVC = [storyBoard instantiateViewControllerWithIdentifier:@"collectionvc"];
                _navigationController =[[UINavigationController alloc]initWithRootViewController:_collectionVC];
                _navigationController.navigationBarHidden=true;
                self.window.rootViewController = _navigationController;
        
    }
}

-(void)customerLoginCheck
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"customerlogininfo"];
    
    BOOL login =[[NSUserDefaults  standardUserDefaults]boolForKey:@"customerlogininfo"];
    
    if(!login)
    {
        
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        
        _customLogin = [storyBoard instantiateViewControllerWithIdentifier:@"CustomerLogInVC"];
        
        [self.navigationController pushViewController:_customLogin animated:YES];
        
        
       }
    else{
        
    
        }
}




//-(void)initializeScreen
//{
//    
//    BOOL login =[[NSUserDefaults  standardUserDefaults]boolForKey:@"login"];
//    
//    if(!login){
//        
//        
//        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//        
//        _customLogin = [storyBoard instantiateViewControllerWithIdentifier:@"CustomerLogInVC"];
//        
//        self.window.rootViewController = _customLogin;
//    }
//    
//    else{
//        
//        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] ;
//        ;
//        _collectionVC = [storyBoard instantiateViewControllerWithIdentifier:@"collectionvc"];
//        _navigationController =[[UINavigationController alloc]initWithRootViewController:_collectionVC];
//        _navigationController.navigationBarHidden=true;
//        self.window.rootViewController = _navigationController;
//    }
//
//}





- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
