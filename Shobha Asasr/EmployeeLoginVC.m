//
//  EmployeeLoginVC.m
//  Shobha Asasr
//
//  Created by Ascra on 10/20/16.
//  Copyright © 2016 Ascra. All rights reserved.
//

#import "EmployeeLoginVC.h"
#import "Validation.h"
#import "Constant.h"
#import "AppDelegate.h"
@interface EmployeeLoginVC ()
{
    Validation *validation;
}

@end

@implementation EmployeeLoginVC
@synthesize empID_TF,empPasswordTF;
@synthesize urlSession,urlSessionConfig,loginDataTask,mutableReq;


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self employeeUIDesign];
    
    appDel=[[UIApplication sharedApplication] delegate];
    
    urlSessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    urlSession = [NSURLSession sessionWithConfiguration:urlSessionConfig];
    
    UITapGestureRecognizer *tapScreen = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tapScreen];
    
    validation = [Validation validationManager];
    
    // Do any additional setup after loading the view.
}

-(void)dismissKeyboard {
    
    [empID_TF resignFirstResponder];
    [empPasswordTF resignFirstResponder];
    
}

-(void)employeeUIDesign
{
        empID_TF.textColor=[UIColor whiteColor];
        empPasswordTF.textColor=[UIColor whiteColor];
        
        
        
      empID_TF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Employee ID" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName :[UIFont fontWithName:@"ZapfHumanist601BT-Roman" size:14] }];
        
    empPasswordTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName :[UIFont fontWithName:@"ZapfHumanist601BT-Roman" size:14] }];
        
        
        
        
        [empID_TF setBackground:[[UIImage imageNamed:@"Text feild.png"] stretchableImageWithLeftCapWidth:0 topCapHeight:0]];
        
        [empPasswordTF setBackground:[[UIImage imageNamed:@"Text feild.png"] stretchableImageWithLeftCapWidth:0 topCapHeight:0]];
        
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        imgView.image = [UIImage imageNamed:@"Employee ID.png"];
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [paddingView addSubview:imgView];
        [empID_TF setLeftViewMode:UITextFieldViewModeAlways];
        [empID_TF setLeftView:paddingView];
        
        
        
        UIImageView *contactImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        contactImageView.image = [UIImage imageNamed:@"password.png"];
        
        UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [paddingView1 addSubview:contactImageView];
        [empPasswordTF setLeftViewMode:UITextFieldViewModeAlways];
        [empPasswordTF setLeftView:paddingView1];
        

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onTapEmployeeLogin_btn:(id)sender {
    
    
    NSString *message = @"";
    
    
    empID_TF.text = [empID_TF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    empPasswordTF.text = [empPasswordTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
    if([empID_TF.text length]< 1){
        
        message = @"Please Enter Valide ID";
        
    }
   else if([empPasswordTF.text length]< 1)
        
    {
        message = @"Please Enter password";
        
        
    }
    
    
    if([ message length]>0){
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
    }else
    {
        
        mutableReq = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:[BaseUrl stringByAppendingString:employee]]];
        
        
        [mutableReq setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [mutableReq setHTTPMethod:@"POST"];
        
        NSString *post = [[NSString alloc] initWithFormat:@"email=%@&password=%@",empID_TF.text,empPasswordTF.text];
        
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        
        NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
        
        [mutableReq setValue:postLength forHTTPHeaderField:@"Content-Length"];
        
        [mutableReq setHTTPBody:postData];
        
        
        loginDataTask = [urlSession dataTaskWithRequest:mutableReq completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            
            NSLog(@"got response from server %@",[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]);
            NSDictionary*json= [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            
        }];
        
        [loginDataTask resume];
        
        
        
        NSDictionary *dict = @{@"empID":empID_TF.text};
        
        NSLog(@"%@",dict);
        
        
        [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"emplogininfo"];
        
        
        [[NSUserDefaults standardUserDefaults]setBool:true forKey:@"emplogininfo"];
        
        [appDel initializeScreen];
        
        //[self switchToRoot];
    }
    
    
    

    
}

- (IBAction)onTapForgotPassword:(id)sender {
}
@end
