//
//  UIColor+ColorCategory.h
//  Shobha Asasr
//
//  Created by Ascra on 11/14/16.
//  Copyright © 2016 Ascra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ColorCategory)


+ (UIColor *)colorWithHex:(UInt32)col;
+ (UIColor *)colorWithHexString:(NSString *)str;
@end
