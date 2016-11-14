//
//  Validation.h
//  Shobha Asasr
//
//  Created by Ascra on 10/26/16.
//  Copyright © 2016 Ascra. All rights reserved.

#import <Foundation/Foundation.h>

@interface Validation : NSObject

+(id)validationManager;



-(BOOL)validateEmail:(NSString*)emailString;
-(BOOL)validatePassword:(NSString*)password;
-(BOOL)validateBlankField:(NSString*)string;
-(BOOL)validatePhoneNumber:(NSString*)phoneString;
-(BOOL)validateZipCode:(NSString*)zipcodeString;
-(BOOL)validateCharacters:(NSString*)string;
-(BOOL)validateString:(NSString*)string equalTo:(NSString*)match ;
-(BOOL)validateUsername:(NSString*)usernameString;
-(BOOL)validateUsernameLength:(NSString*)usernameStringLength;
-(BOOL)validateNumber:(NSString*)numberString;
-(BOOL)validateNumberDigits:(NSString*)numberString;
- (NSArray *) filterObjectsByKey:(NSString *) key;

@end
