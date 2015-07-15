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
#import "UserMgr.h"
#import "Common.h"
#import "CellSelfHead.h"
#import "CellSelf.h"

typedef enum {
    ESIT_Head       = 0,
    ESIT_Sec_0      = 0,
    ESIT_Sec_0_All  = 1,
    
    ESIT_Auth       = 0,
    ESIT_Set        = 1,
    ESIT_About      = 2,
    ESIT_Sec_1_All     ,
    ESIT_Sec_1      = 1,
    
    ESIT_Quit       = 0,
    ESIT_Sec_2_All     ,
    ESIT_Sec_2      = 2,

    ESIT_Sec_All    = 3,
} ESelfItemType;

@interface CLSelf ()
{
    
}

@end

@implementation CLSelf

-(void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserverForName:Notification_HeadPicChange object:nil queue:nil usingBlock:^(NSNotification *note) {
        [viewTalbe reloadData];
            }];
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
    else if(ESIT_Sec_2 == section)
    {
        return ESIT_Sec_2_All;
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
        CellSelfHead *cell = (CellSelfHead *)[tableView dequeueReusableCellWithIdentifier:@"CellSelfHead"];
        if (cell != nil)
        {
            cell=nil;
        }
        cell = (CellSelfHead *)[[[NSBundle mainBundle] loadNibNamed:@"CellSelfHead" owner:nil options:nil] lastObject];
        
        if([[UserMgr sharedInstance] userData].headPic)
        {
            NSString *str = [NSString stringWithFormat:@"%@%@", HTTP_Pic_Avatar, [[UserMgr sharedInstance] userData].headPic];
            [cell.imgHead setImageWithURL:[NSURL URLWithString:str]];
        }
        else
        {
            
        }
        
        if([[UserMgr sharedInstance] userData].name)
        {
            cell.labName.text = [[UserMgr sharedInstance] userData].name;
        }
        
        if([[UserMgr sharedInstance] userData].nickName)
        {
            cell.labNickname.text = [[UserMgr sharedInstance] userData].nickName;
        }
        else
        {
            cell.labNickname.text = @"未设置";
        }
        return cell;
    }
    else
    {
        CellSelf *cell = (CellSelf *)[tableView dequeueReusableCellWithIdentifier:@"CellSelf"];
        if (cell != nil)
        {
            cell=nil;
        }
        cell = (CellSelf *)[[[NSBundle mainBundle] loadNibNamed:@"CellSelf" owner:nil options:nil] lastObject];
        
        if(ESIT_Sec_1 == indexPath.section)
        {
            if(ESIT_Auth == indexPath.row)
            {
                cell.labTitle.text = @"实名认证";
            }
            else if(ESIT_Set == indexPath.row)
            {
                cell.labTitle.text = @"设置";
            }
            else if(ESIT_About == indexPath.row)
            {
                cell.labTitle.text = @"关于";
            }
        }
        else if(ESIT_Sec_2 == indexPath.section)
        {
            if(ESIT_Quit == indexPath.row)
            {
                cell.labTitle.text = @"退出登录";
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
        UIViewController *vc= [mainStoryboard instantiateViewControllerWithIdentifier:@"CLSelfInfo"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        if(ESIT_Sec_1 == indexPath.section)
        {
            if(ESIT_Auth == indexPath.row)
            {
                UIViewController *vc= [mainStoryboard instantiateViewControllerWithIdentifier:@"CLAuth"];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
        else if(ESIT_Sec_2 == indexPath.section)
        {
            
        }
    }
}

-(void)dealloc
{
    [super dealloc];
    [viewTalbe release];
}

@end
