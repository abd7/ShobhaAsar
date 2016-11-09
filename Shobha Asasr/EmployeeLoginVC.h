//
//  EmployeeLoginVC.h
//  Shobha Asasr
//
//  Created by Ascra on 10/20/16.
//  Copyright © 2016 Ascra. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppDelegate;
@interface EmployeeLoginVC : UIViewController
{
    AppDelegate *appDel;
}
@property (strong, nonatomic) IBOutlet UITextField *empID_TF;
@property (strong, nonatomic) IBOutlet UITextField *empPasswordTF;
- (IBAction)onTapEmployeeLogin_btn:(id)sender;
- (IBAction)onTapForgotPassword:(id)sender;

@property NSURLSession * urlSession;
@property NSURLSessionConfiguration * urlSessionConfig;
@property NSURLSessionDataTask * loginDataTask;
@property NSMutableURLRequest * mutableReq;

@end
