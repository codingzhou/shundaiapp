//
//  ChangeInfoViewController.m
//  ShunDai
//
//  Created by Mac_Key on 16/5/25.
//  Copyright © 2016年 Key. All rights reserved.
//

#import "ChangeInfoViewController.h"
#import "MyCenterManager.h"

@interface ChangeInfoViewController ()

{
    NSString *_value;
    UITextField *_valueTextF;
    NSMutableArray *_checkBtns;
    UIButton *_cornerBtn;
}


@end

@implementation ChangeInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [Common setNavigationBarRightButtonTitleCenter:self withTitle:@"确定" withAction:@selector(changeInfo)];
    [self initView];
    
    // Do any additional setup after loading the view.
}

- (void)initView{
    if (!self.values) {
        //昵称 手机，地址等
        UITextField *text = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 20, 40)];
        text.backgroundColor = [UIColor whiteColor];
        _valueTextF = text;
        if (self.changeIndex == 2) {
            _valueTextF.keyboardType = UIKeyboardTypePhonePad ;
        }
        [self.view addSubview:text];
    }else{
        _cornerBtn = [[UIButton alloc] init];
        _checkBtns = [NSMutableArray array];
        CGFloat baseX = 20;
        CGFloat baseY = 20;
        for (NSInteger i = 0; i < self.values.count ; i++) {
            NSString *value = self.values[i];
            
            UIButton *checkBtn = [[UIButton alloc] initWithFrame:CGRectMake(baseX, baseY, 220, 35)];
            [checkBtn setTitle:value forState:UIControlStateNormal];
            [checkBtn setTitleColor:UIColorFromRGB(0xe2e2e2) forState:UIControlStateNormal];
            checkBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            checkBtn.layer.masksToBounds = YES;
            checkBtn.layer.cornerRadius = 13;
            checkBtn.layer.borderColor = UIColorFromRGB(0xf4f4f4).CGColor;
            checkBtn.layer.borderWidth = 2;
            [checkBtn setBackgroundColor:[UIColor grayColor]];
            [self.view addSubview:checkBtn];
            [_checkBtns addObject:checkBtn];
            checkBtn.tag = i;
//            baseY += 45;
            
            if (baseX + 440 >SCREEN_WIDTH) {
                baseX = 20;
                baseY += 45;
            }else{
                baseX += 220;
            }

            
//            checkBtn.tag = i;
            [checkBtn addTarget:self action:@selector(changeCheckValue:) forControlEvents:UIControlEventTouchUpInside];
        }

    }
   
}

- (void)changeInfo{
//    NSLog(@"%@",_valueTextF.text);
    NSString *strKey = @"";
    NSString *value = _valueTextF.text;
    switch (self.changeIndex) {
        case 1:
            strKey = @"nickName";
            break;
        case 2:
            strKey = @"phone";
            break;
        case 3:
            strKey = @"sex";
             value = _values[_cornerBtn.tag];
            break;
        case 4:
            strKey = @"school";
           value = _values[_cornerBtn.tag];
            break;
        case 6:
            strKey = @"nickName";
            break;
        case 7:
            strKey = @"mail";
            break;
            
        default:
            break;
    }
//    [[MyCenterManager shared].requestDic setObject:value forKey:strKey];
    [self.presentVc changeInfoWithIndex:self.changeIndex AndValue:value];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)changeCheckValue:(UIButton *)btn
{
//    _value = btn.tag;
    _cornerBtn = btn;
    for (UIButton *subBtn in _checkBtns) {
        if ([btn isEqual:subBtn]) {
            [subBtn setBackgroundColor:UIColorFromRGB(0x13a8ed)];
        }else{
            [subBtn setBackgroundColor:[UIColor grayColor]];
        }
    }
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
