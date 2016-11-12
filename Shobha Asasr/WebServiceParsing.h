//
//  WebServiceParsing.h
//  kompanyKonnect
//
//  Created by appeal on 8/21/14.
//  Copyright (c) 2014 appeal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIView.h>

@class Reachability;

@protocol WebServiceParsingDelegate


-(void)getProductResponce:(id)getProductResponce;




-(void) failedToGetResponce:(NSError *) error;


@end

@interface WebServiceParsing : NSObject
{
	NSString *string1;
    NSURLConnection *postConnection;
    id jsonResponseData;
    NSMutableString  * strUrl;
    NSMutableURLRequest *request;
    Reachability* internetReachable;
    Reachability* hostReachable;


}



+(BOOL)InternetCheck;
+(void)InternetFailErrorMessage;


-(id)getDataFromURLString :(NSMutableString*)urlString;
-(id) getDataFromURLStringForPost :(NSMutableString*)urlString;
-(id)getDataForPhotoUpload :(NSMutableURLRequest*)_request;

@property (nonatomic,strong) NSMutableData * webData;
@property (nonatomic, weak) id<WebServiceParsingDelegate> requestDelegate;


@end
