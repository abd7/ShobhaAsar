//
//  CustomerRegisterVC.m
//  Shobha Asasr
//
//  Created by Ascra on 10/20/16.
//  Copyright © 2016 Ascra. All rights reserved.
//

#import "CustomerRegisterVC.h"
#import "CustomerLogInVC.h"
#import "Validation.h"
#import "Constant.h"
#import "AppDelegate.h"

@interface CustomerRegisterVC ()
{
    CustomerLogInVC *customerLoginVC;
    Validation *validation;
}
@end

@implementation CustomerRegisterVC
@synthesize nameTF,mobileNumberTF,emailTF,registerView;
@synthesize urlSession,urlSessionConfig,registerDataTask,mutableReq;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self uiComponentsDesign];
    app=[[UIApplication sharedApplication] delegate];
    
    UITapGestureRecognizer *tapScreen = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tapScreen];
   
    validation=[Validation validationManager];
    
    
    
    urlSessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    urlSession = [NSURLSession sessionWithConfiguration:urlSessionConfig];
    
    // Do any additional setup after loading the view.
}
-(void)dismissKeyboard {
    
    [nameTF resignFirstResponder];
    [mobileNumberTF resignFirstResponder];
    [emailTF resignFirstResponder];
}

-(void)uiComponentsDesign
{
    nameTF.textColor=[UIColor whiteColor];
    mobileNumberTF.textColor=[UIColor whiteColor];
    emailTF.textColor=[UIColor whiteColor];
    
    
    nameTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Name" attributes:@{ NSForegroundColorAttributeName : [UIColor lightTextColor],NSFontAttributeName :[UIFont fontWithName:@"ZapfHumanist601BT-Roman" size:14] }];
    
    mobileNumberTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Mobile Number" attributes:@{ NSForegroundColorAttributeName : [UIColor lightTextColor],NSFontAttributeName :[UIFont fontWithName:@"ZapfHumanist601BT-Roman" size:14] }];
    
    emailTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email ID" attributes:@{ NSForegroundColorAttributeName : [UIColor lightTextColor],NSFontAttributeName :[UIFont fontWithName:@"ZapfHumanist601BT-Roman" size:14] }];
    
    
    
    [nameTF setBackground:[[UIImage imageNamed:@"Text feild.png"] stretchableImageWithLeftCapWidth:0 topCapHeight:0]];
    
    [mobileNumberTF setBackground:[[UIImage imageNamed:@"Text feild.png"] stretchableImageWithLeftCapWidth:0 topCapHeight:0]];
    
    [emailTF setBackground:[[UIImage imageNamed:@"Text feild.png"] stretchableImageWithLeftCapWidth:0 topCapHeight:0]];
    
    
    
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    imgView.image = [UIImage imageNamed:@"Employee ID.png"];
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [paddingView addSubview:imgView];
    [nameTF setLeftViewMode:UITextFieldViewModeAlways];
    [nameTF setLeftView:paddingView];
    
    
    
    UIImageView *contactImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    contactImageView.image = [UIImage imageNamed:@"Contact Icon.png"];
    
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [paddingView1 addSubview:contactImageView];
    [mobileNumberTF setLeftViewMode:UITextFieldViewModeAlways];
    [mobileNumberTF setLeftView:paddingView1];
    
    
    
    UIImageView *emailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    emailImageView.image = [UIImage imageNamed:@"email.png"];
    
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [paddingView2 addSubview:emailImageView];
    [emailTF setLeftViewMode:UITextFieldViewModeAlways];
    [emailTF setLeftView:paddingView2];
    
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

-(void)switchToRoot{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UITabBarController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"collectionvc"];
    
    [[UIApplication sharedApplication].keyWindow setRootViewController:rootViewController];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (IBAction)onTapRegister_btn:(id)sender {
    
    
    NSString *message = @"";
    
    
    nameTF.text = [nameTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    mobileNumberTF.text = [mobileNumberTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
    
    if([nameTF.text length]< 1){
        
        message = @"Please Enter Valid Name";
        
    } else if([mobileNumberTF.text length]< 1)
    
    {
        message = @"Please Enter 10 Digit mobile number";
        
        
    }
    else if (![validation validatePhoneNumber:mobileNumberTF.text])
    {
        message = @"Please Enter 10 Digit mobile number";
    }
    
    else if([emailTF.text length]< 1)
        
    {
        message = @"Please enter valid email ID";
        
        
}
    else if(![validation validateEmail:emailTF.text])
        
    {
        message = @"Please fill your valid email.";
        
        
        
    }
    
    if([ message length]>0){
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
    }else
    {
        
       
        
          mutableReq = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:[BaseUrl stringByAppendingString:register_user]]];
        
        
        [mutableReq setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [mutableReq setHTTPMethod:@"POST"];
        
        NSString *post = [[NSString alloc] initWithFormat:@"mobile_no=%@&email=%@&name=%@",mobileNumberTF.text,emailTF,nameTF.text];
        
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        
        NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
        
        [mutableReq setValue:postLength forHTTPHeaderField:@"Content-Length"];
        
        [mutableReq setHTTPBody:postData];
        
        
        registerDataTask = [urlSession dataTaskWithRequest:mutableReq completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            
            NSLog(@"got response from server %@",[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]);
            NSDictionary*servDic= [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

            
            if ([[servDic valueForKey:@"success"]isEqualToString:@"successfully inserted"])
            {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Successfully Registered" preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                        [app initializeScreen];
                        
                    }];
                    
                    [alert addAction:ok];
                    
                    [self presentViewController:alert animated:YES completion:nil];

                    
                    
                });
               
                
              
                
            }
            
            else
            {
                
                
            }
          
        }];
        
        [registerDataTask resume];
        
        
        
        NSDictionary *dict = @{@"name":nameTF.text,@"mobile":mobileNumberTF.text,@"user_email":emailTF.text};
        
        NSLog(@"%@",dict);
        
        
        [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"login"];
        
        
        [[NSUserDefaults standardUserDefaults]setBool:true forKey:@"login"];

        
        
        
    }
    
    
    
    
}
- (IBAction)onTapAlreadyCustomer:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
