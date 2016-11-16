//
//  AppsDataVC.h
//  Shobha Asasr
//
//  Created by Ascra on 11/11/16.
//  Copyright © 2016 Ascra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServiceParsing.h"
#import "ShobhaAsarDataBase.h"

@interface AppsDataVC : UIViewController<WebServiceParsingDelegate>

@property (nonatomic, retain)  WebServiceParsing   * requesteAPI;


-(void)addSTYLE_MASTER:(NSMutableArray *)STYLE_MASTERArray;
-(void)addCollectionDetails:(NSMutableArray *)collectionDetailsArray;
-(void)addCategoryDetails:(NSMutableArray *)categoryArray;

- (IBAction)onTapCategory_btn:(id)sender;
- (IBAction)onTapCollection_btn:(id)sender;


@end
