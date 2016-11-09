//
//  SplashScreen.h
//  Shobha Asasr
//
//  Created by Ascra on 11/8/16.
//  Copyright © 2016 Ascra. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppDelegate;
@interface SplashScreen : UIViewController
{
    AppDelegate *splashApp;
}

@property NSURLSession * urlSession,*urlSession1,*urlSession2;
@property NSURLSessionConfiguration * urlSessionConfig,*urlSessionConfig1,*urlSessionConfig2;
@property NSURLSessionDataTask * collectionDataTask,*collectionDataTask1,*collectionDataTask2;
@property NSMutableURLRequest * mutableReq,*mutableReq1,*mutableReq2;

@end
