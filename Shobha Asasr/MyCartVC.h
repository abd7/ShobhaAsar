//
//  MyCartVC.h
//  Shobha Asasr
//
//  Created by Ascra on 10/26/16.
//  Copyright © 2016 Ascra. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppDelegate;
@interface MyCartVC : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UIApplicationDelegate>
{AppDelegate *appDel;
    
    IBOutlet UIButton *wishlist_btn;
    
    IBOutlet UIButton *cart_btn;
}
@property (strong, nonatomic) IBOutlet UICollectionView *myCartCollection;
@property NSMutableArray *myCartImageArray;

- (IBAction)onTapMyCart_closeBtn:(id)sender;

- (IBAction)onTapLeftMenu_btn:(id)sender;


@end
