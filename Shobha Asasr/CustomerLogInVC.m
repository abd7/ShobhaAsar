//
//  CustomerLogInVC.m
//  Shobha Asasr
//
//  Created by Ascra on 10/20/16.
//  Copyright © 2016 Ascra. All rights reserved.
//

#import "CustomerLogInVC.h"
#import "CustomerRegisterVC.h"
#import "Validation.h"
#import "Constant.h"
#import "AppDelegate.h"

@interface CustomerLogInVC ()<UIApplicationDelegate>
{
    
    Validation *validation;
}


@end

@implementation CustomerLogInVC
@synthesize loginNameTF,loginMobileTF;
@synthesize urlSession,urlSessionConfig,loginDataTask,mutableReq;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    app = [[UIApplication sharedApplication] delegate];
    
    [self uiComponentsDesign];
    
    UITapGestureRecognizer *tapScreen = [[UITapGestureRecognizer alloc]
                                         initWithTarget:self
                                         action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tapScreen];
    
    validation = [Validation validationManager];
    
    //self.customerRegister=[[CustomerRegisterVC alloc]init];
    
    
    
    
    
    urlSessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    urlSession = [NSURLSession sessionWithConfiguration:urlSessionConfig];
    
    
    
    // Do any additional setup after loading the view.
}

-(void)dismissKeyboard {
    
    [loginNameTF resignFirstResponder];
    [loginMobileTF resignFirstResponder];
    
}

-(void)uiComponentsDesign
{
    loginNameTF.textColor=[UIColor whiteColor];
    loginMobileTF.textColor=[UIColor whiteColor];
    
    
    
    loginNameTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Name" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName :[UIFont fontWithName:@"ZapfHumanist601BT-Roman" size:14] }];
    
    loginMobileTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Mobile Number" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName :[UIFont fontWithName:@"ZapfHumanist601BT-Roman" size:14]}];
    
    
    [loginNameTF setBackground:[[UIImage imageNamed:@"Text feild.png"] stretchableImageWithLeftCapWidth:0 topCapHeight:0]];
    
    [loginMobileTF setBackground:[[UIImage imageNamed:@"Text feild.png"] stretchableImageWithLeftCapWidth:0 topCapHeight:0]];
    
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    imgView.image = [UIImage imageNamed:@"Employee ID.png"];
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [paddingView addSubview:imgView];
    [loginNameTF setLeftViewMode:UITextFieldViewModeAlways];
    [loginNameTF setLeftView:paddingView];
    
    
    
    UIImageView *contactImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    contactImageView.image = [UIImage imageNamed:@"Contact Icon.png"];
    
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [paddingView1 addSubview:contactImageView];
    [loginMobileTF setLeftViewMode:UITextFieldViewModeAlways];
    [loginMobileTF setLeftView:paddingView1];
    
    
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

- (IBAction)onTapLogIb_btn:(id)sender {
    
    
    NSString *message = @"";
    
    
    loginNameTF.text = [loginNameTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    loginMobileTF.text = [loginMobileTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                                                                                                                                                                                                 
    
    if([loginNameTF.text length]< 1){
        
        message = @"Please Enter Valide Name";
        
    } else if([loginMobileTF.text length]< 1)
        
    {
        message = @"Please Enter 10 Digit mobile number";
        
        
    }
    else if (![validation validatePhoneNumber:loginMobileTF.text])
    {
        message = @"Please Enter 10 Digit register mobile number";
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
        
        NSString *post = [[NSString alloc] initWithFormat:@"mobile_no=%@&name=%@",loginMobileTF.text,loginNameTF.text];
        
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        
        NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
        
        [mutableReq setValue:postLength forHTTPHeaderField:@"Content-Length"];
        
        [mutableReq setHTTPBody:postData];
        
        
        loginDataTask = [urlSession dataTaskWithRequest:mutableReq completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            
            NSLog(@"got response from server %@",[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]);
            NSDictionary*json= [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            
        }];
        
        [loginDataTask resume];
        
        
        
        NSDictionary *dict = @{@"name":loginNameTF.text,@"mobile":loginMobileTF.text};
        
        NSLog(@"%@",dict);
        
        
        [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"login"];
        
        
        [[NSUserDefaults standardUserDefaults]setBool:true forKey:@"login"];
        
        [app initializeScreen];
        
        //[self switchToRoot];
    }
    
    
    
    
    
}


- (IBAction)onTapnewUserButton:(id)sender
{
    
    customerRegister=[[self storyboard]instantiateViewControllerWithIdentifier:@"CustomerRegisterVC"];
    
    [self.navigationController pushViewController:customerRegister animated:YES];
    
}
@end
