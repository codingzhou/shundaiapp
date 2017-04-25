//
//  UserDatialInfoViewController.m
//  ShunDai
//
//  Created by Mac_Key on 16/5/16.
//  Copyright © 2016年 Key. All rights reserved.
//

#import "UserDatialInfoViewController.h"
//#import "DoImagePickerController.h"
//#import "ImageUtil.h"
#import "ChangeInfoViewController.h"
#import "MyCenterManager.h"
#import "UserInfo.h"

#import <objc/runtime.h>
#import "CameraController.h"
#import "ImageUtil.h"
#import "CutAvatarImgViewController.h"



@interface UserDatialInfoViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate>
{
    UITableView *_tableView;
    UIImageView *_iconV;
    UserInfo *_userInfo;
    UserInfo *_cashInfo;
    BOOL _isNeedUpdate;
}

@end

@implementation UserDatialInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initTableView];
    self.title = @"个人信息";
    _isNeedUpdate = NO;
    [Common setNavigationBarRightButtonTitleCenter:self withTitle:@"保存" withAction:@selector(saveInfo)];
    // Do any additional setup after loading the view.
}

- (void)initData{
//    _userInfo =  [[MyCenterManager shared].requestDic objectForKey:@"userInfo"];
    
    if (!_userInfo) {
        _userInfo = [[Config Instance] getUserInfo];
        NSString *userId = [[Config Instance] getID];
        NSLog(@"%@",userId);
    }
    _cashInfo = [UserInfo userInfoWithDic:[_userInfo getDictionary] ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)initTableView{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.backgroundColor=kCommAppbackgroundColor;
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.translatesAutoresizingMaskIntoConstraints=NO;
    NSLayoutConstraint *tWidth=[NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    NSLayoutConstraint *theight=[NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    [_tableView.superview addConstraint:tWidth];
    [_tableView.superview addConstraint:theight];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 9;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 80;
    }
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"detialCell"];
    [self setCellCententWithCell:cell andeIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        return cell;
    }
   
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        [self changeIconImage];
        return;
    }
//    //地址管理
//    if (indexPath.row == 5) {
//        return;
//    }
    //绑定QQ
    if (indexPath.row == 8) {

        return;
    }
     NSString *title = @"";
    NSArray *values;
    switch (indexPath.row) {
        case 1:
            title = @"修改昵称";
            break;
        case 2:
            title = @"修改手机";
            
            break;
        case 3:
            title = @"修改性别";
            values = @[@"男",@"女",@"保密"];
            break;
        case 4:
            title = @"修改学校";
            values = @[@"贵州财经大学(花溪校区)",@"贵州医科大学(花溪校区)",@"贵州师范大学(花溪校区)",@"贵州城市学院(花溪校区)",@"贵州轻工职业技术学院",@"贵州民族大学花溪校区(花溪校区)"];
            break;
        case 5:
            title = @"修改地址";
            
            break;
        case 6:
            title = @"修改个性签名";
            
            break;
        case 7:
            title = @"修改邮箱";
            
            break;
        default:
            break;
    }
    
    ChangeInfoViewController *vc = [[ChangeInfoViewController alloc] init];
    vc.title = title;
    vc.changeIndex = indexPath.row;
    vc.presentVc = self;
    vc.values = values;
    [self.navigationController pushViewController:vc animated:YES];

}

- (void)setCellCententWithCell:(UITableViewCell *)cell andeIndexPath:(NSIndexPath *)indexPath{
    //头像
    if (indexPath.row == 0) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.text = @"头像";
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 70, 70)];
        imgV.userInteractionEnabled = YES;
        _iconV = imgV;
        [imgV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeIconImage)]];
        imgV.layer.masksToBounds = YES;
        imgV.layer.cornerRadius = 15;

        UIImage *iconImg = [self getIconImg];
        if (iconImg) {
            imgV.image = iconImg;
        }else{
            [imgV sd_setImageWithURL: [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",KUrlBaseUrl,  _userInfo.iconImageUrl]] placeholderImage:[UIImage imageNamed:@"defalut_logo"]];
        }
        cell.accessoryView = imgV;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return;
    }
//    //地址管理
//    if (indexPath.row == 5) {
//        cell.textLabel.text = @"地址管理";
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return;
//    }
    //绑定QQ
    if (indexPath.row == 8) {
        cell.textLabel.text = @"QQ";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return;
    }
    NSString *strKey = @"";
     NSString *title = @"";
    NSString *value  = @"";
    switch (indexPath.row) {
        case 1:
            title = @"昵称";
            strKey = @"nickName";
            value = _userInfo.nickName;
            break;
        case 2:
            title = @"手机";
              strKey = @"phone";
            value = _userInfo.phone;
            break;
        case 3:
            title = @"性别";
             strKey = @"sex";
            value = _userInfo.sex == 0 ? @"男":@"女";
            break;
        case 4:
            title = @"学校";
             strKey = @"school";
            value = _userInfo.school;
            break;
        case 5:
            title = @"地址管理";
            strKey = @"address";
            value = _userInfo.address;
            break;
        case 6:
            title = @"个性签名";
            strKey = @"nickName";
            value = _userInfo.nickName;
            break;
        case 7:
            title = @"邮箱";
             strKey = @"mail";
            value = _userInfo.mail;
            break;
        default:
            break;
    }
    
    cell.textLabel.text = title;
    cell.detailTextLabel.text =  value;//[[MyCenterManager shared].requestDic objectForKey:strKey];
    
}


/**
 *头像设置方法
 */

- (void)changeIconImage
{
    UIActionSheet *avatarSheet = [[UIActionSheet alloc] initWithTitle:nil/*NSLocalizedStringEx(@"SettingAvatar", @"设置头像")*/ delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles: @"拍照发布", @"从手机相册选择", nil];
    avatarSheet.tag = 100001;
    [avatarSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 100001) {
        switch (buttonIndex) {
            case 0:
            {
                //相机
                [self showCamera];
            }
                break;
            case 1:
            {
                //相册
                [self showPhotoAlbumWithAnimation:YES];
            }
                break;
            default:
                break;
                
        }
    }
}

- (void)showPhotoAlbumWithAnimation:(BOOL)animate
{
    UIImagePickerController* imgPicker = [[UIImagePickerController alloc] init];
    imgPicker.delegate = self;
    imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imgPicker animated:animate completion:nil];
}

-(void)cameraControllerDidPhoto:(CameraController *)camera
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [camera dismissViewControllerAnimated:NO completion:nil];
    //从相册选择
    //    SAFE_RELEASE(_albumController);
    //    if (!_albumController) {
    //        _albumController = [[ImagePickerMultiSelector alloc] init];
    //        _albumController.delegate=self;
    //    }
    //    [self presentModalViewController:_albumController.imagePicker animated:YES];
    [self showPhotoAlbumWithAnimation:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"取消相册选择框");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"获得选中图片");
    UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //    if(image.size.height > SCREEN_HEIGHT || image.size.width > SCREEN_WIDTH) {
    //        image=[ImageUtil compressImageProportional:image compressSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
    //    }
    if(UIImageOrientationUp != image.imageOrientation) {
        image = [ImageUtil AdjustOrientationToUpReturnNew:image];
    }
    [picker dismissViewControllerAnimated:NO completion:nil];
    [self getImage:image];
}

- (void)getImage:(UIImage *)image
{
    NSLog(@"给子类调用");

   image = [self imageCompressForWidth:image targetWidth:160];
        _iconV.image = image;
        //上传图片到服务器
        [self showControllerMasterView:@"上传中..."];
        [[MyCenterManager shared] upLoadIconImage:image andUserId:_userInfo.userId success:^(NSString *iconImgFile) {
            [self hiddenControllerMaskView];
            _userInfo.iconImageUrl = iconImgFile;
            [[Config Instance] setUserInfo:_userInfo];
            [[Config Instance] setIconImgeUrl:iconImgFile];
            NSLog(@"asdfasd");
        } failure:^(NSString *info) {
        [self hiddenControllerMaskView];
        }];
}

-(void)cameraController:(CameraController *)camera didFinishImage:(UIImage *)image
{
    if(UIImageOrientationUp != image.imageOrientation)
    {
        image = [ImageUtil AdjustOrientationToUpReturnNew:image];
    }
    CutAvatarImgViewController *cutpic = [[CutAvatarImgViewController alloc] init];
    cutpic.delegate = self;
    cutpic.sourceImage = image;
    cutpic.backImageViewRect = CGRectMake(0, 50, SCREEN_WIDTH, SCREEN_WIDTH);
    [camera pushViewController:cutpic animated:YES];
    
}

- (void)showCamera
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
    picker.delegate = self;
    picker.allowsEditing = YES;//设置可编辑
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:^{
        
    }];
}

/**
 *更新View信息
 */
- (void)changeInfoWithIndex:(NSInteger)index AndValue:(NSString *)value{
    NSIndexPath *indePath = [NSIndexPath indexPathForItem:index inSection:0];
    
    UITableViewCell *cell = [_tableView cellForRowAtIndexPath:indePath];
    cell.detailTextLabel.text = value;
    //保存临时数据
    switch (index) {
        case 1:
            _cashInfo.nickName = value;
            break;
        case 2:
             _cashInfo.phone = value;
            break;
        case 3:
            if ([value isEqualToString:@"男"]) {
                _cashInfo.sex = 0;
            }else if([value isEqualToString:@"女"]){
                _cashInfo.sex = 1;
            }else{
                _cashInfo.sex = 2;
            }
          
            break;
        case 4:
            _cashInfo.school = value;
            break;
        case 5:
            _cashInfo.address = value;
            break;
        case 6:
           _cashInfo.nickName = value;
            break;
        case 7:
            _cashInfo.mail = value;
            break;
        default:
            break;
    }
    _isNeedUpdate = YES;
}

/**
 *保存信息
 */
- (void)saveInfo{
    if (!_isNeedUpdate) {
        return;
    }
    [self showControllerMasterView: @"更新中。。。"];
    [[MyCenterManager shared] upLoadUserInfo:_cashInfo success:^(NSInteger returnCode) {
        [self hiddenControllerMaskView];
        [[Config Instance] setUserInfo:_cashInfo];
//        [[MyCenterManager shared].requestDic setObject:_cashInfo forKey:@"userInfo"];
        [self.navigationController popViewControllerAnimated:YES];
        NSLog(@"success");
    } failure:^(NSString *info) {
         [self hiddenControllerMaskView];
        [self.warnV removeFromSuperview];
        NSLog(@"failure,,,%@",info);
    }];
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
