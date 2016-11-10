//
//  WebServiceParsing.m
//  kompanyKonnect
//
//  Created by appeal on 8/21/14.
//  Copyright (c) 2014 appeal. All rights reserved.
//

#import "WebServiceParsing.h"
#import "Reachability.h"
#import "AppDelegate.h"
#import <UIKit/UIView.h>

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)
BOOL internetActive;
BOOL hostActive;   // object for class method

Reachability* internetReachable;
Reachability* hostReachable;
@implementation WebServiceParsing


@synthesize webData = _webData;

//Json Parsing

-(id) getDataFromURLString :(NSMutableString*)urlString
{

      strUrl = urlString;
    
    [strUrl setString:[strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strUrl]];
    [request setHTTPMethod:@"GET"];
    
    postConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    if (postConnection)
    {
        _webData = [[NSMutableData alloc] init];
    }
    else
    {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Connection Error!" message:NETWORK_ERROR delegate:self cancelButtonTitle:@"Try again" otherButtonTitles:nil, nil];
//        [alertView show];
        
    }
return self;

}

-(id) getDataFromURLStringForPost :(NSMutableString*)urlString
{
    
    strUrl = urlString;
    [strUrl setString:[strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strUrl]];
    [request setHTTPMethod:@"POST"];
    postConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    if (postConnection)
    {
        _webData = [[NSMutableData alloc] init];
    }
    else
    {
        //        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Connection Error!" message:NETWORK_ERROR delegate:self cancelButtonTitle:@"Try again" otherButtonTitles:nil, nil];
        //        [alertView show];
    }
    return self;
    
}

-(id)getDataForPhotoUpload :(NSMutableURLRequest*)_request
{
    postConnection = [[NSURLConnection alloc] initWithRequest:_request delegate:self startImmediately:YES];
    if (postConnection)
    {
        _webData = [[NSMutableData alloc] init];
    }
    else
    {
        //        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Connection Error!" message:NETWORK_ERROR delegate:self cancelButtonTitle:@"Try again" otherButtonTitles:nil, nil];
        //        [alertView show];
    }
    return self;
    
}

#pragma mark-CONNECTION METHODS



-(void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse *)response
{
    [_webData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_webData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    postConnection = nil;
    _webData = nil;
    [_requestDelegate failedToGetResponce:error];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *error;
    jsonResponseData = [NSJSONSerialization JSONObjectWithData:_webData options:NSJSONReadingMutableContainers error:&error];
    [_requestDelegate getResponce:jsonResponseData];
    postConnection = nil;
    _webData = nil;
}

+(BOOL)InternetCheck
{
    internetReachable=[Reachability reachabilityForInternetConnection];
    
    NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
    
    internetReachable = [Reachability reachabilityForInternetConnection];
    [internetReachable startNotifier];
    
    // check if a pathway to a random host exists
    //hostReachable = [Reachability reachabilityWithHostName:@"www.google.com"];
    hostReachable=[Reachability reachabilityWithHostname:@"www.apple.com"];
    [hostReachable startNotifier];
    
    switch (internetStatus)
    {
        case NotReachable:
        {
            NSLog(@"The internet is down.");
            internetActive = NO;
            return internetActive;
            break;
        }
        case ReachableViaWiFi:
        {
            
            NSLog(@"The internet is working via WiFi");
            internetActive = YES;
            return internetActive;
        }
            break;
            
        case ReachableViaWWAN:
        {
            NSLog(@"The internet is working via lan");
            
            internetActive = YES;
            
            return internetActive;
            
            break;
        }
            
    }
    /*
     NetworkStatus hostStatus = [hostReachable currentReachabilityStatus];
     switch (hostStatus)
     {
     case NotReachable:
     {
     NSLog(@"A gateway to the host server is down.");
     internetActive = NO;
     
     break;
     }
     case ReachableViaWiFi:
     {
     NSLog(@"A gateway to the host server is working via WIFI.");
     internetActive = YES;
     
     break;
     }
     case ReachableViaWWAN:
     {
     NSLog(@"A gateway to the host server is working via WWAN.");
     internetActive = YES;
     break;
     }
     }
     */
    
}

+(void)InternetFailErrorMessage
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Error!"
                                                    message:@"Device is currently not connected to service.Please verify you are connected to a WIFI or 3G enabled Network."
                                                   delegate:self
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
    [[UIView appearance] setTintColor: [UIColor colorWithRed:0.0/255.0 green:177.0/255.0 blue:176.0/255.0 alpha:1.0]];
    [alert show];
}



@end
