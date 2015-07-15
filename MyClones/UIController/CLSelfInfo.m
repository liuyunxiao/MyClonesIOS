//
//  CLSelfInfo.m
//  MyClones
//
//  Created by lyx on 15/7/3.
//  Copyright (c) 2015年 Zhenwei. All rights reserved.
//

#import "CLSelfInfo.h"
#import "HttpMgr.h"
#import "DataModel.h"
#import "CellSelfInfo.h"
#import "CellSelfHeadInfo.h"
#import "UserMgr.h"
#import "CropImagePopoverView.h"

typedef enum {
    ESIT_Head           = 0,
    ESIT_Name           = 1,
    ESIT_Nickname       = 2,
    ESIT_QcCode         = 3,
    ESIT_Account        = 4,
    ESIT_Phone          = 5,
    ESIT_Sec_0_All         ,
    ESIT_Sec_0          = 0,
    
    
    ESIT_Sex            = 0,
    ESIT_Distinct       = 1,
    ESIT_Signature      = 2,
    ESIT_Sec_1_All         ,
    ESIT_Sec_1          = 1,
    
    ESIT_Sec_All        = 2,
} ESelfInfoType;

@interface CLSelfInfo ()
{
    Task        *taskChangeHeadPic_;
    CropImagePopoverView *cropImageView_;
    
}
@end

@implementation CLSelfInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
-(void)onUpdatePicHead:(UIImageView*)img
{
    
}

-(void)onRevChangeHeadPic:(FBTaskResult *)aResult context:(id)aContext
{
    taskChangeHeadPic_ = nil;
    //CANCEL_AND_RELEASE_TASK(taskChangeHeadPic_);
    [[MIndicatorView sharedInstance] hide];
    RevChangeHeadPic *rev = aResult.resultValue;
    if(!rev)
        return;
    
    if(rev.resultCode != EHRC_Success)
    {
        [[MIndicatorView sharedInstance] showWithTitle:rev.resultMsg animated:NO];
        return;
    }
    
    [[[UserMgr sharedInstance] userData] setHeadPic:rev.headPic];
    [viewTable reloadData];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_HeadPicChange object:nil];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == actionSheet.cancelButtonIndex)
    {
        return;
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
    
    cropImageView_ = [[[NSBundle mainBundle] loadNibNamed:@"CropImagePopoverView" owner:nil options:nil] lastObject];
    if(orginalImage.imageOrientation==UIImageOrientationRight)
    {
        //orginalImage=[orginalImage rotate90CounterClockwise];
    }
    //orginalImage=[orginalImage fixOrientation];
    NSData *dataObj = UIImageJPEGRepresentation(orginalImage, 0.5f);
    NSLog(@"--------%.2fM", [dataObj length]/1024.f/1024.f);
    UIImage *image = [UIImage imageWithData:dataObj];
    [cropImageView_ setImage:image];
    [cropImageView_ setCropViewRect:200.f height:200.f];
    [cropImageView_ setCropImage];
    [cropImageView_ setDelegate:self];
    [[[UIApplication sharedApplication] keyWindow] addSubview:cropImageView_];
    
}



- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
}

- (void)cropImageFinished:(NSData *)aData
{
    if(cropImageView_!=nil)
    {
        [cropImageView_ dismissWithAnimated:YES];
        cropImageView_ = nil;
    }
    
    //fileData=[aData retain];
    
    if(!taskChangeHeadPic_)
    {
        NSMutableArray *arry = [[NSMutableArray alloc] init];
        {
            NSMutableDictionary *dicObj = [NSMutableDictionary dictionaryWithCapacity:4];
            [dicObj setObject:@"jpg" forKey:@"type"];
            long long interval = [NSString getNowNSTimeInterval];
            NSString *fileName = [NSString stringWithFormat:@"%llu.jpg",interval*1000];
            [dicObj setObject:fileName forKey:@"name"];
            [dicObj setObject:@"file" forKey:@"key"];
            [dicObj setObject:aData forKey:@"data"];
            [arry addObject:dicObj];
            
        }
        
        taskChangeHeadPic_ = [[HttpMgr sharedInstance] send:@"SendChangeHeadPic" data:nil files:arry observer:self selector:@selector(onRevChangeHeadPic:context:) block:YES];
    }
}

#pragma mark - UITableView Delegate & Datasrouce -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(ESIT_Sec_0 == section)
    {
        return ESIT_Sec_0_All;
    }
    else if(ESIT_Sec_1 == section)
    {
        return ESIT_Sec_1_All;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return ESIT_Sec_All;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == ESIT_Sec_0 && indexPath.row == ESIT_Head)
    {
        CellSelfHeadInfo *cell = (CellSelfHeadInfo *)[tableView dequeueReusableCellWithIdentifier:@"CellSeCellSelfHeadInfolfHead"];
        if (cell != nil)
        {
            cell=nil;
        }
        cell = (CellSelfHeadInfo *)[[[NSBundle mainBundle] loadNibNamed:@"CellSelfHeadInfo" owner:nil options:nil] lastObject];
        
        if([[UserMgr sharedInstance] userData].headPic)
        {
            NSString *str = [NSString stringWithFormat:@"%@%@", HTTP_Pic_Avatar, [[UserMgr sharedInstance] userData].headPic];
            [cell.imgHead setImageWithURL:[NSURL URLWithString:str]];
        }
        else
        {
            
        }

        return cell;
    }
    else
    {
        CellSelfInfo *cell = (CellSelfInfo *)[tableView dequeueReusableCellWithIdentifier:@"CellSelfInfo"];
        if (cell != nil)
        {
            cell=nil;
        }
        cell = (CellSelfInfo *)[[[NSBundle mainBundle] loadNibNamed:@"CellSelfInfo" owner:nil options:nil] lastObject];
        
        if(ESIT_Sec_0 == indexPath.section)
        {
            switch (indexPath.row) {
                case ESIT_Name:
                {
                    cell.labTitle.text = @"名字";
                    if([[UserMgr sharedInstance] userData].name)
                    {
                        cell.labDes.text = [[UserMgr sharedInstance] userData].name;
                    }
                    else
                    {
                        cell.labDes.text = @"未设置";
                    }
                }
                    break;
                case ESIT_Nickname:
                {
                    cell.labTitle.text = @"昵称";
                    if([[UserMgr sharedInstance] userData].nickName)
                    {
                        cell.labDes.text = [[UserMgr sharedInstance] userData].nickName;
                    }
                    else
                    {
                        cell.labDes.text = @"未设置";
                    }
                }
                    break;
                case ESIT_QcCode:
                {
                    cell.labTitle.text = @"我的二维码";
                }
                    break;
                    
                case ESIT_Account:
                {
                    cell.labTitle.text = @"账号";
                    if([[UserMgr sharedInstance] userData].account)
                    {
                        cell.labDes.text = [[UserMgr sharedInstance] userData].account;
                    }
                    [cell.labNext setHidden:YES];
                }
                    break;
                case ESIT_Phone:
                {
                    cell.labTitle.text = @"手机";
                    if([[UserMgr sharedInstance] userData].phone)
                    {
                        cell.labDes.text = [[UserMgr sharedInstance] userData].phone;
                    }
                    else
                    {
                        cell.labDes.text = @"未设置";
                    }
                }
                    break;
                    
                default:
                    break;
            }
        }
        else if(ESIT_Sec_1 == indexPath.section)
        {
            switch (indexPath.row) {
                case ESIT_Sex:
                {
                    cell.labTitle.text = @"性别";
                    if(EST_Male == [[UserMgr sharedInstance] userData].sex)
                    {
                        cell.labDes.text = @"男";
                        [cell.labNext setHidden:YES];
                    }
                    else if(EST_Female == [[UserMgr sharedInstance] userData].sex)
                    {
                        cell.labDes.text = @"女";
                        [cell.labNext setHidden:YES];
                    }
                    else
                    {
                        cell.labDes.text = @"未设置";
                        [cell.labNext setHidden:NO];
                    }
                }
                    break;
                case ESIT_Distinct:
                {
                    cell.labTitle.text = @"地域";
                    cell.labDes.text = @"未设置";
                }
                    break;
                case ESIT_Signature:
                {
                    cell.labTitle.text = @"个性签名";
                    cell.labDes.text = @"未设置";
                }
                    break;
                default:
                    break;
            }
        }
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == ESIT_Sec_0 && indexPath.row == ESIT_Head)
    {
        return 80.0;
    }
    
    return 44.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone"
                                                             bundle: nil];
    
    if(ESIT_Sec_0 == indexPath.section && ESIT_Head == indexPath.row)
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
    else
    {
        if(ESIT_Sec_0 == indexPath.section)
        {
            switch (indexPath.row) {
                case ESIT_Name:
                {
                    
                }
                    break;
                case ESIT_Nickname:
                {
                    
                }
                    break;
                case ESIT_QcCode:
                {
                    UIViewController *vc= [mainStoryboard instantiateViewControllerWithIdentifier:@"CLQcCode"];
                    
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                    
                case ESIT_Account:
                {
                    
                }
                    break;
                case ESIT_Phone:
                {
                    
                }
                    break;
                    
                default:
                    break;
            }
        }
        else if(ESIT_Sec_1 == indexPath.section)
        {
            switch (indexPath.row) {
                case ESIT_Sex:
                {
                    
                }
                case ESIT_Distinct:
                {
                    
                }
                    break;
                case ESIT_Signature:
                {
                    
                }
                    break;
                default:
                    break;
            }
        }

    }
}

-(void)dealloc
{
    [viewTable release];
    [super dealloc];
}

@end
