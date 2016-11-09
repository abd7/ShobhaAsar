//
//  CustomerLogInVC.h
//  Shobha Asasr
//
//  Created by Ascra on 10/20/16.
//  Copyright © 2016 Ascra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerRegisterVC.h"

@class AppDelegate;

@interface CustomerLogInVC : UIViewController
{
    AppDelegate *app;
    CustomerRegisterVC *customerRegister;
}
@property (strong, nonatomic) IBOutlet UITextField *loginNameTF;
@property (strong, nonatomic) IBOutlet UITextField *loginMobileTF;



- (IBAction)onTapLogIb_btn:(id)sender;

@property NSURLSession * urlSession;
@property NSURLSessionConfiguration * urlSessionConfig;
@property NSURLSessionDataTask * loginDataTask;
@property NSMutableURLRequest * mutableReq;

- (IBAction)onTapnewUserButton:(id)sender;


@end
