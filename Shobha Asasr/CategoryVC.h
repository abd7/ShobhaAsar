//
//  CategoryVC.h
//  Shobha Asasr
//
//  Created by Ascra on 11/5/16.
//  Copyright © 2016 Ascra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryVC : UIViewController
{
    
    IBOutlet UIButton *collection_btn;
    IBOutlet UIButton *category_btn;
    IBOutlet UIView *underLineView;
    UIButton *tab_btn,*tab_btn2;
}
- (IBAction)onTapLeftMenu_btn:(id)sender;
- (IBAction)onTapCollection_btn:(id)sender;
- (IBAction)onTapCategory_btn:(id)sender;

@end
