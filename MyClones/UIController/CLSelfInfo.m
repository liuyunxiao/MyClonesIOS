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

typedef enum {
    ESIT_Sec_Start_0    = 0,
    ESIT_Head           = 0,
    ESIT_Name           = 1,
    ESIT_Nickname       = 2,
    ESIT_Account        = 3,
    ESIT_Phone          = 4,
    ESIT_Sec_End_0      = 5,
    
    ESIT_Sec_Start_1    = ESIT_Sec_End_0,
    ESIT_Sex            = ESIT_Sec_End_0,
    ESIT_Distinct       = 6,
    ESIT_Signature      = 7,
    ESIT_Sec_End_1      = 8,
    
    ESIT_All            = ESIT_Sec_End_1,
} ESelfInfoType;

#define SelfInfoSectionNum    2

#define kHeader @"header" // 头部标题对应的key
#define kFooter @"footer" // 尾部标题对应的key
#define kCities @"cities" // 城市数组对应的key

#define kRows       @"rows"
#define kName       @"name"
#define kTitle      @"title"
#define kDes        @"des"
#define kPic        @"pic"



@interface CLSelfInfo ()
{
    Task        *taskChangeHeadPic;
     NSArray    *_allCells; // 所有的省份
}
@end

@implementation CLSelfInfo


-(void)viewDidAppear:(BOOL)animated
{
    //UIActionSheet *sheet = nil;
    
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        sheet = [[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"手机相册", nil] autorelease];
//    }
//    else {
//        sheet = [[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"手机相册", nil] autorelease];
//    }
//    
//    [sheet showInView:self.view];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //NSSelectorFromString("on")
    // 2.初始化数据
    _allCells = @[
                      @[
                          @{
                              kName     : @"head",
                              kTitle    : @"头像",
                              kPic      : @"default.png",
                              },
                          @{
                              kName     : @"name",
                              kTitle    : @"姓名",
                              kDes      : @"未设置"
                              },
                          @{
                              kName     : @"nickname",
                              kTitle    : @"昵称",
                              kDes      : @"未设置",
                              },
                          @{
                              kName     : @"account",
                              kTitle    : @"账号",
                              kDes      : @"未设置",
                              },
                          @{
                              kName     : @"phone",
                              kTitle    : @"手机",
                              kDes      : @"未设置",
                              },
                          ],
                      @[
                          @{
                              kName     : @"sex",
                              kTitle    : @"性别",
                              kPic      : @"未设置",
                              },
                          @{
                              kName     : @"distinct",
                              kTitle    : @"地区",
                              kDes      : @"未设置"
                              },
                          @{
                              kName     : @"signature",
                              kTitle    : @"签名",
                              kDes      : @"未设置",
                              },
                          ],
                      ];
    [_allCells retain];
}

-(void)onSelHead
{
    
}

-(void)onUpdatePicHead:(UIImageView*)img
{
    
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
        //[imgTest setImageWithURL:[NSURL URLWithString:str]];
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

#pragma mark - 数据源方法
#pragma mark 一共有多少组（section == 区域\组）
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _allCells.count;
}
#pragma mark 第section组一共有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 1.取得第section组的省份
    NSArray *sectionCells = _allCells[section];
    
    return sectionCells.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 1)
        return 50;
}

#pragma mark 返回每一行显示的内容(每一行显示怎样的cell)
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    //    NSString *text = _allCities[indexPath.section][indexPath.row];
    //    NSArray *sectionCities = _allCities[indexPath.section];
    
    // 1.取出第section组第row行的文字数据
    // 取出第section组的省份 中 城市数组里面 第 row行的 数据

    NSArray *sectionCells = _allCells[indexPath.section];
    
    NSDictionary *data = sectionCells[indexPath.row];
    
    // 2.展示文字数据
    cell.textLabel.text = [data objectForKey:kTitle];
    return cell;
}
#pragma mark 第section组显示的头部标题
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    //    if (section == 0) return @"广东";
//    //    if (section == 1) return @"湖南";
//    //    if (section == 2) return @"湖北";
//    //    if (section == 3) return @"广西";
//    //    if (section == 4) return @"浙江";
//    //    if (section == 5) return @"安徽";
//    
//    NSDictionary *province = _allProvinces[section];
//    
//    return province[kHeader];
//}
#pragma mark 第section组显示的尾部标题
//- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
//{
//    //    if (section == 0) return @"广东好";
//    //    if (section == 1) return @"湖南也好";
//    //    if (section == 2) return @"湖北更好";
//    //    if (section == 3) return @"广西一般般";
//    //    if (section == 4) return @"浙江应该可以吧";
//    //    if (section == 5) return @"安徽确实有点坑爹";
//    
//    return _allProvinces[section][kFooter];
//}

@end
