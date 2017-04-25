//
//  MyIdentifyViewController.m
//  ShunDai
//
//  Created by Mac_Key on 16/5/29.
//  Copyright © 2016年 Key. All rights reserved.
//

#import "MyIdentifyViewController.h"
#import "MyCenterManager.h"
#import "UserInfo.h"
#import <objc/runtime.h>
#import "CameraController.h"
#import "ImageUtil.h"
#import "CutAvatarImgViewController.h"

@interface MyIdentifyViewController ()<UIPickerViewDataSource,UIPickerViewDelegate,UIActionSheetDelegate>
{
    UITextField *_textName;
    UITextField *_textXH;
    UITextField *_textIDNumber;
    UITextField *_textRomInfo;
    UILabel *_school;
    NSMutableArray *_values;
    NSString *_schoolValue;
    
    UIButton *_btnaddXHImg;
    UIButton *_btnaddIDNumImg;
    UIButton *_cornelBtn;
    
}

@end

@implementation MyIdentifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"身份认证";
    
    if ([[Config Instance] getUserIdentityState] == 2) {
        [self showNOneed];
    }
    if ([[Config Instance] getUserIdentityState] == 0) {
        [self initView];
    }
    
    if ([[Config Instance] getUserIdentityState] == 1) {
        [self didIdentity];
    }
    
    
    
       // Do any additional setup after loading the view.
}

- (void)showNOneed{
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    lbl.textColor = [UIColor blackColor];
    lbl.text = @"认证信息审核中。。。。。";
    lbl.numberOfLines = 0;
    lbl.font = [UIFont systemFontOfSize:18];
    lbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lbl];
}

- (void)didIdentity{
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    lbl.textColor = [UIColor blackColor];
    lbl.text = @"认证信息审核成功，你已经通过认证。可以领取任务";
     lbl.numberOfLines = 2;
    lbl.font = [UIFont systemFontOfSize:18];
    lbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lbl];
}

- (void)initView{
    UILabel *lblName = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 40, 15)];
    lblName.font = [UIFont systemFontOfSize:12];
    lblName.text = @"姓  名";
    [self.view addSubview:lblName];
    UITextField *textName = [[UITextField alloc] initWithFrame:CGRectMake(65, 15, SCREEN_WIDTH - 80, 30)];
    _textName = textName;
    textName.placeholder = @"请填写您的真实姓名";
    textName.font = [UIFont systemFontOfSize:16];
    textName.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textName];
    
    UILabel *lblXH = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(lblName.frame) +35, 40, 15)];
    lblXH.font = [UIFont systemFontOfSize:12];
    lblXH.text = @"学  号";
    [self.view addSubview:lblXH];
    UITextField *textXH = [[UITextField alloc] initWithFrame:CGRectMake(65, CGRectGetMaxY(textName.frame) + 20, SCREEN_WIDTH - 80, 30)];
    _textXH = textXH;
    textXH.placeholder = @"请输入你的学号";
    textXH.font = [UIFont systemFontOfSize:16];
    textXH.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textXH];
    
    UILabel *lblIDNumber = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(lblXH.frame) +35, 40, 15)];
    lblIDNumber.font = [UIFont systemFontOfSize:12];
    lblIDNumber.text = @"证件号";
    [self.view addSubview:lblIDNumber];
    UITextField *textIDNumber = [[UITextField alloc] initWithFrame:CGRectMake(65, CGRectGetMaxY(textXH.frame) + 20, SCREEN_WIDTH - 80, 30)];
    _textIDNumber = textIDNumber;
    textIDNumber.placeholder = @"请输入你的身份证号码";
    textIDNumber.font = [UIFont systemFontOfSize:16];
    textIDNumber.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textIDNumber];
    
    UILabel *lblSchool = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(lblIDNumber.frame) +35, 40, 15)];
    lblSchool.font = [UIFont systemFontOfSize:12];
    lblSchool.text = @"学  校";
    [self.view addSubview:lblSchool];
    UILabel *school = [[UILabel alloc] initWithFrame:CGRectMake(65, CGRectGetMaxY(textIDNumber.frame) + 20, SCREEN_WIDTH - 80, 30)];
    [school addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showCheckSchool)]];
    school.userInteractionEnabled = YES;
    _school = school;
    school.font = [UIFont systemFontOfSize:16];
    school.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:school];
    
    UILabel *lblRomNumber = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(lblSchool.frame) +35, 40, 15)];
    lblRomNumber.font = [UIFont systemFontOfSize:12];
    lblRomNumber.text = @"宿  舍";
    [self.view addSubview:lblRomNumber];
    UITextField *textRoomNumber = [[UITextField alloc] initWithFrame:CGRectMake(65, CGRectGetMaxY(school.frame) + 20, SCREEN_WIDTH - 80, 30)];
    _textRomInfo = textRoomNumber;
    textRoomNumber.placeholder = @"请输入你的身份证号码";
    textRoomNumber.font = [UIFont systemFontOfSize:16];
    textRoomNumber.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textRoomNumber];
    
    UILabel *lblIDNumImg = [[UILabel alloc] initWithFrame:CGRectMake(25, CGRectGetMaxY(textRoomNumber.frame) + 10, 0, 0)];
    lblIDNumImg.font = [UIFont systemFontOfSize:14];
    lblIDNumImg.text = @"身份证正面照片";
    [lblIDNumImg sizeToFit];
    [self.view addSubview:lblIDNumImg];
    CGFloat addImgW = SCREEN_WIDTH/2 - 60;
    UIButton *addIDNumImg = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(lblIDNumImg.frame) + 5, addImgW, addImgW)];
    [addIDNumImg setBackgroundImage:[UIImage imageNamed:@"selImg_sle"] forState:UIControlStateNormal];
    [addIDNumImg setBackgroundImage:[UIImage imageNamed:@"selImg_normal"] forState:UIControlStateHighlighted];
    [addIDNumImg addTarget:self action:@selector(showImgPhoto:) forControlEvents:UIControlEventTouchUpInside];
    _btnaddIDNumImg = addIDNumImg;
    [self.view addSubview:addIDNumImg];
    
    UILabel *lblXHImg = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 + 5, CGRectGetMaxY(textRoomNumber.frame) + 10, 0, 0)];
    lblXHImg.font = [UIFont systemFontOfSize:14];
    lblXHImg.text = @"学生证照片";
    [lblXHImg sizeToFit];
    [self.view addSubview:lblXHImg];
    UIButton *addXHImg = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(addIDNumImg.frame) + 40, CGRectGetMaxY(lblIDNumImg.frame) + 5, addImgW, addImgW)];
    [addXHImg setBackgroundImage:[UIImage imageNamed:@"selImg_sle"] forState:UIControlStateNormal];
    [addXHImg setBackgroundImage:[UIImage imageNamed:@"selImg_normal"] forState:UIControlStateHighlighted];
        _btnaddXHImg  = addXHImg;
        [addXHImg addTarget:self action:@selector(showImgPhoto:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addXHImg];
    
    UIButton *btnSubmit = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(addXHImg.frame) + 30, SCREEN_WIDTH - 40, 30)];
    btnSubmit.backgroundColor = UIColorFromRGB(0x0091d2);
    btnSubmit.layer.masksToBounds = YES;
    btnSubmit.layer.cornerRadius = 10;
    [btnSubmit setTitle:@"提交" forState:UIControlStateNormal];
    [btnSubmit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:btnSubmit];
    [btnSubmit addTarget:self action:@selector(submitAppeal) forControlEvents:UIControlEventTouchUpInside];
}


- (void)showImgPhoto:(UIButton*)btn{
    _cornelBtn = btn;
    [self showAlumb];
}

- (void)submitAppeal{
    
    NSString *name = _textName.text;
    NSString *xH = _textXH.text;
    NSString *idCard = _textIDNumber.text;
    NSString *school = _schoolValue;
//    NSString *
    [[MyCenterManager shared] upLoadIndenityInfo:[[Config Instance] getID] name:name idcard:idCard idCardImg:@"身份证图片图片太uptown" xhCardImg:@"学生证图片图片图片丿" xH:xH school:school success:^(NSInteger code) {
        [self showWarnMessage:@"认证信息提交成功，‘顺带’工作人员会在两个工作日内进行处理 ！"];
        [[Config Instance]setUserIdentityState:2];
        UserInfo *info = [[Config Instance]getUserInfo];
        info.indentity = 2;
        [[Config Instance] setUserInfo:info];
        
    } failure:^(NSString *info) {
        NSLog(@"%@",info);
        [self showWarnMessage:info];
    }];

}

//显示dataPiacker
- (void)showCheckSchool{
    [self showPiceViewWithArray:@[@"贵州财经大学(花溪校区)",@"贵州医科大学(花溪校区)",@"贵州师范大学(花溪校区)",@"贵州城市学院(花溪校区)",@"贵州轻工职业技术学院",@"贵州民族大学花溪校区(花溪校区)"] andIndex:0];
    NSLog(@"asdf");
}

- (void)showPiceViewWithArray:(NSArray *)array andIndex: (NSInteger)index{
    if (!_values) {
        _values = [NSMutableArray array];
    }
    [_values removeAllObjects];
    [_values addObjectsFromArray:array];
    _schoolValue = _values[0];
    UIView *backView = [self getBackView];
    [self closeAllKeyBoard];
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 280, SCREEN_WIDTH, 200)];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    pickerView.backgroundColor = [UIColor whiteColor];
    [backView addSubview:pickerView];
    pickerView.showsSelectionIndicator = YES;
    UIView *toobal = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 310, SCREEN_WIDTH, 30)];
    toobal.backgroundColor = UIColorFromRGB(0xf7f7f7);
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 80, 0, 80, 30)];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [toobal addSubview:button];
    button.tag = index;
    [button addTarget:self action:@selector(changeSchoolValue) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:toobal];
    
    [self.view addSubview:backView];
}

- (void)changeSchoolValue{
    _school.text = _schoolValue;
    [self.baceView removeFromSuperview];
}

//关闭所有键盘
- (void)closeAllKeyBoard{
    [_textName resignFirstResponder];
    [_textXH resignFirstResponder];
    [_textIDNumber resignFirstResponder];
    [_textRomInfo resignFirstResponder];
}

#pragma makr  UIPickerView Function

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _values.count;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *title = title = _values[row];
    
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _schoolValue  = _values[row];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)showAlumb
{
    [self showAvatarSettingSheet];
}

- (void)showAvatarSettingSheet
{
    //    if (IOS8) {
    //
    //        UIAlertController *alertContoller = [[UIAlertController alloc] init];
    //        [alertContoller addAction:[UIAlertAction actionWithTitle:@"拍照发布"
    //                                                           style:UIAlertActionStyleDefault
    //                                                         handler:^(UIAlertAction *action) {
    //                                                             [self showCamera];
    //                                                         }]];
    //
    //        [alertContoller addAction:[UIAlertAction actionWithTitle:@"从手机相册选择"
    //                                                           style:UIAlertActionStyleDefault
    //                                                         handler:^(UIAlertAction *action) {
    //                                                             [self showPhotoAlbumWithAnimation:YES];
    //                                                         }]];
    //        [alertContoller addAction:[UIAlertAction actionWithTitle:@"取消"
    //                                                           style:UIAlertActionStyleCancel
    //                                                         handler:nil]];
    //        [self presentViewController:alertContoller animated:YES completion:nil];
    //    } else {
    
    UIActionSheet *_avatarSheet = [[UIActionSheet alloc] initWithTitle:nil/*NSLocalizedStringEx(@"SettingAvatar", @"设置头像")*/ delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles: @"拍照发布", @"从手机相册选择", nil];
    _avatarSheet.tag = 100001;
    _avatarSheet.delegate = self;
    [_avatarSheet showInView:self.view];
    //    }
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
    if (_cornelBtn == _btnaddIDNumImg) {
        _btnaddIDNumImg.backgroundColor = [UIColor colorWithPatternImage:image];
    }else{
        _btnaddXHImg.backgroundColor = [UIColor colorWithPatternImage:image];
    }
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



@end
