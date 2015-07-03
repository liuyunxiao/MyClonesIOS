//
//  CLSelf.m
//  MyClones
//
//  Created by lyx on 15/6/26.
//  Copyright (c) 2015年 Zhenwei. All rights reserved.
//

#import "CLSelf.h"
#import "HttpMgr.h"
#import "DataModel.h"

@interface CLSelf ()
{
    Task        *taskChangeHeadPic;
}
@end

@implementation CLSelf

-(void)viewDidAppear:(BOOL)animated
{
    UIActionSheet *sheet = nil;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        sheet = [[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"手机相册", nil] autorelease];
    }
    else {
        sheet = [[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"手机相册", nil] autorelease];
    }
    
    [sheet showInView:self.view];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == actionSheet.cancelButtonIndex)
    {
        return ;	// Cancel button pressed
    }
    
    UIImagePickerController *picker = [[[UIImagePickerController alloc] init] autorelease];
    [picker setAllowsEditing:NO];
    [picker setDelegate:self];
    
    NSString *name = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([name isEqualToString:@"手机相册"]) {
        [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [picker setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        [self presentModalViewController:picker animated:YES];
    }
    else if ([name isEqualToString:@"拍照"]) {
        [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [picker setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        [self presentModalViewController:picker animated:YES];
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *orginalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [picker dismissModalViewControllerAnimated:YES];
        //orginalImage=[orginalImage fixOrientation];
    NSData *dataObj = UIImageJPEGRepresentation(orginalImage, 0.25f);
    NSLog(@"--------%.2fM", [dataObj length]/1024.f/1024.f);
    if(!taskChangeHeadPic)
    {
        NSMutableArray *arry = [[NSMutableArray alloc] init];
        {
            NSMutableDictionary *dicObj = [NSMutableDictionary dictionaryWithCapacity:4];
            [dicObj setObject:@"jpg" forKey:@"type"];
            long long interval = [NSString getNowNSTimeInterval];
            NSString *fileName = [NSString stringWithFormat:@"%llu.jpg",interval*1000];
            [dicObj setObject:fileName forKey:@"name"];
            [dicObj setObject:@"file" forKey:@"key"];
            [dicObj setObject:dataObj forKey:@"data"];
            [arry addObject:dicObj];

        }
        
        taskChangeHeadPic = [[HttpMgr sharedInstance] send:@"SendChangeHeadPic" data:nil files:arry observer:self selector:@selector(onRevChangeHeadPic:context:) block:YES];
    }
}

-(void)onRevChangeHeadPic:(FBTaskResult *)aResult context:(id)aContext
{
    taskChangeHeadPic = nil;
    [[MIndicatorView sharedInstance] hide];
    RevChangeHeadPic *rev = aResult.resultValue;
    if(!rev)
        return;
    
    if(rev.resultCode == EHRC_Success)
    {
        NSString* str = [NSString stringWithFormat:@"%@%@", HTTP_Pic_Avatar, rev.headPic];
        [imgTest setImageWithURL:[NSURL URLWithString:str]];
    }
    else
    {
        [[MIndicatorView sharedInstance] showWithTitle:rev.resultMsg animated:NO];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
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

@end
