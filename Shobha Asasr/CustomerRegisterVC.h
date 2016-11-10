//
//  CustomerRegisterVC.h
//  Shobha Asasr
//
//  Created by Ascra on 10/20/16.
//  Copyright © 2016 Ascra. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppDelegate;
@interface CustomerRegisterVC : UIViewController<UITextFieldDelegate>
{
    AppDelegate *app;
}

@property (strong, nonatomic) IBOutlet UITextField *nameTF;
@property (strong, nonatomic) IBOutlet UITextField *mobileNumberTF;
@property (strong, nonatomic) IBOutlet UITextField *emailTF;
@property (strong, nonatomic) IBOutlet UIView *registerView;

- (IBAction)onTapRegister_btn:(id)sender;

@property NSURLSession * urlSession;
@property NSURLSessionConfiguration * urlSessionConfig;
@property NSURLSessionDataTask * registerDataTask;
@property NSMutableURLRequest * mutableReq;

@end
