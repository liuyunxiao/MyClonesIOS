//
//  CLPhantasm.m
//  MyClones
//
//  Created by lyx on 15/6/26.
//  Copyright (c) 2015年 Zhenwei. All rights reserved.
//

#import "CLPhantasm.h"
#import "VPhantasmItem.h"

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Delegate & Datasrouce -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VPhantasmItem *cell = (VPhantasmItem *)[tableView dequeueReusableCellWithIdentifier:@"VPhantasmItem"];
    if (cell != nil)
    {
        cell = nil;
    }
    
    cell = (VPhantasmItem *)[[[NSBundle mainBundle] loadNibNamed:@"VPhantasmItem" owner:nil options:nil] lastObject];
    
    
    if(indexPath.row == 0)
    {
        cell.labName.text = @"淘淘";
    }
    else if(indexPath.row == 1)
    {
        cell.labName.text = @"碰碰";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone"
                                                             bundle: nil];
    UIViewController *vc = nil;
    if(indexPath.row == 0)
    {
        vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"CLEShopping"];
    }
    else if(indexPath.row == 1)
    {
        vc= [mainStoryboard instantiateViewControllerWithIdentifier:@"CLPengpeng"];
    }
    
    [self.navigationController pushViewController:vc animated:YES];
    [self.navigationController.navigationBar setHidden:NO];
    
    //[self.tabBarController.tabBar setHidden:YES];
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
