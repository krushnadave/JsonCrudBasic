//
//  ViewController.h
//  JsonCrudBasic
//
//  Created by Tops on 12/21/15.
//  Copyright (c) 2015 Tops. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlClass.h"
@interface ViewController : UIViewController<UrlProtocol,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UrlClass *urlclass;
    NSArray *arr_st;
    UIPickerView *pkr_st;
    
    NSArray *arr_ct;
    UIPickerView *pkr_ct;
}
- (NSString *)encodeToBase64String:(UIImage *)image;
@property (weak, nonatomic) IBOutlet UITextField *txt_state;
@property (weak, nonatomic) IBOutlet UITextField *txt_ct;
@property (weak, nonatomic) IBOutlet UIImageView *img_vw;
- (IBAction)btn_upload:(id)sender;
- (IBAction)btn_submit:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txt_fnm;
@property (weak, nonatomic) IBOutlet UITextField *txt_lnm;
@property (weak, nonatomic) IBOutlet UITextField *txt_nm;
@property (weak, nonatomic) IBOutlet UITextField *txt_upass;
@end

