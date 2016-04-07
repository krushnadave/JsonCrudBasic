//
//  ViewController.m
//  JsonCrudBasic
//
//  Created by Tops on 12/21/15.
//  Copyright (c) 2015 Tops. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize txt_state,txt_ct,txt_fnm,txt_lnm,img_vw,txt_nm,txt_upass;
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    arr_st=[[NSArray alloc]init];
    pkr_st=[[UIPickerView alloc]init];
    pkr_st.delegate=self;
    pkr_st.dataSource=self;
    [txt_state setInputView:pkr_st];
    
    txt_ct.delegate=self;
    arr_ct=[[NSArray alloc]init];
    pkr_ct=[[UIPickerView alloc]init];
    pkr_ct.delegate=self;
    pkr_ct.dataSource=self;
    [txt_ct setInputView:pkr_ct];
    
    urlclass=[[UrlClass alloc]init];
    urlclass.delegate=self;
    [urlclass ConntectWithURL:@"http://ios8192014.somee.com/webservice.asmx/JsonCrud1GetAllStates" Flag:@"state"];
}
-(void)GetUrlData:(NSArray *)arrget Flag:(NSString *)stflag
{
    if ([stflag isEqual:@"state"])
    {
        arr_st=arrget;
        [pkr_st reloadAllComponents];
    }
    if ([stflag isEqual:@"city"])
    {
        arr_ct=arrget;
        [pkr_ct reloadAllComponents];
    }
}
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    int index=0;
    if ([pickerView isEqual:pkr_st])
    {
        index=(int)arr_st.count;
    }
    else if ([pickerView isEqual:pkr_ct])
    {
        index=(int)arr_ct.count;
    }
    return index;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *index=@"";
    if ([pickerView isEqual:pkr_st])
    {
        index=[[arr_st objectAtIndex:row]objectForKey:@"state_nm"];
    }
    else if ([pickerView isEqual:pkr_ct])
    {
        index=[[arr_ct objectAtIndex:row]objectForKey:@"city_nm"];
    }
    return index;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([pickerView isEqual:pkr_st])
    {
        txt_state.text=[[arr_st objectAtIndex:row]objectForKey:@"state_nm"];
    }
    else if ([pickerView isEqual:pkr_ct])
    {
        txt_ct.text=[[arr_ct objectAtIndex:row]objectForKey:@"city_nm"];
    }

}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:txt_ct])
    {
        if (txt_state.text.length>0)
        {
            NSArray *arr_st_key=[arr_st valueForKey:@"state_nm"];
            
            NSInteger index=[arr_st_key indexOfObject:txt_state.text];
            
            NSString *st_id=[[arr_st objectAtIndex:index]objectForKey:@"state_id"];
            
            NSString *st_url=[NSString stringWithFormat:@"http://ios8192014.somee.com/webservice.asmx/JsonCrud2GetCityByState?state_id=%@",st_id];
            [urlclass ConntectWithURL:st_url Flag:@"city"];
            
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btn_upload:(id)sender
{
    UIImagePickerController *imgpkr=[[UIImagePickerController alloc]init];
    imgpkr.delegate=self;
    imgpkr.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:imgpkr animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *img=info[UIImagePickerControllerOriginalImage];
    img_vw.image=img;
}
- (NSString *)encodeToBase64String:(UIImage *)image
{
    NSData *data = UIImagePNGRepresentation(image);
    
    return [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}
- (IBAction)btn_submit:(id)sender
{
    //NSLog(@"%@",[self encodeToBase64String:img_vw.image]);
    NSArray *arr_st_key=[arr_st valueForKey:@"state_nm"];
    NSInteger index=[arr_st_key indexOfObject:txt_state.text];
    NSString *st_id=[[arr_st objectAtIndex:index]objectForKey:@"state_id"];
    
    
    NSArray *arr_ct_key=[arr_ct valueForKey:@"city_nm"];
    NSInteger indexct=[arr_ct_key indexOfObject:txt_ct.text];
    NSString *ct_id=[[arr_ct objectAtIndex:indexct]objectForKey:@"city_id"];
    
    NSString *st_url=[NSString stringWithFormat:@"http://ios8192014.somee.com/webservice.asmx/JsonCrud3InsertUserData?txt_fnm=%@&txt_lnm=%@&u_st=%@&u_ct=%@&u_photo=%@&u_unm=%@&u_pass=%@",txt_fnm.text,txt_lnm.text,st_id,ct_id,[self encodeToBase64String:img_vw.image],txt_nm.text,txt_upass.text];
    
    [urlclass ConntectWithURL:st_url Flag:@"insert"];
    
}
@end
