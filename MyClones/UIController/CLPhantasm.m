//
//  CLPhantasm.m
//  MyClones
//
//  Created by lyx on 15/6/26.
//  Copyright (c) 2015年 Zhenwei. All rights reserved.
//

#import "CLPhantasm.h"
#import "CellPhantasm.h"
#import "Common.h"
@interface CLPhantasm ()

@end

@implementation CLPhantasm

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"+"
                                                                    style:UIBarButtonItemStyleDone
                                                                   target:self
                                                                   action:@selector(clickRightButton)];

    // Do any additional setup after loading the view.
}

-(void)clickRightButton
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone"
                                                             bundle: nil];
    UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"NavPhantasmCreate"];
    [vc setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:vc animated:YES completion:^(void){
        
    }];
    
}

#pragma mark - UITableView Delegate & Datasrouce -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return EPT_All;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellPhantasm *cell = (CellPhantasm *)[tableView dequeueReusableCellWithIdentifier:@"CellPhantasm"];
    if (cell != nil)
    {
        cell = nil;
    }
    
    cell = (CellPhantasm *)[[[NSBundle mainBundle] loadNibNamed:@"CellPhantasm" owner:nil options:nil] lastObject];
    
    switch (indexPath.row) {
        case EPT_EShopping:
            cell.labTitle.text = @"淘淘";
            break;
        case EPT_RentHouse:
            cell.labTitle.text = @"租房";
            break;
        case EPT_Pengpeng:
            cell.labTitle.text = @"碰碰";
            break;
        case EPT_Flea:
            cell.labTitle.text = @"二手";
            break;
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone"
                                                             bundle: nil];
    UIViewController *vc = nil;
    
    switch (indexPath.row) {
        case EPT_EShopping:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"CLEShopping"];
            break;
        case EPT_RentHouse:
            
            break;
        case EPT_Pengpeng:
            vc= [mainStoryboard instantiateViewControllerWithIdentifier:@"CLPengpeng"];
            break;
        case EPT_Flea:
            
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:vc animated:YES];
    [self.navigationController.navigationBar setHidden:NO];
    
}


@end
