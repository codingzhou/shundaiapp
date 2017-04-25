//
//  MyCenterTableViewController.m
//  ShunDai
//
//  Created by Mac_Key on 16/5/7.
//  Copyright © 2016年 Key. All rights reserved.
//

#import "CustomActionSheet.h"
#import "AppDelegate.h"
//#import "QRCodeGenerator.h"

#define kActionBtnTag 10000

@implementation CustomActionSheet
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithType:(CustomActionSheetViewType)viewType withTitle:(NSString *)title withBtnInfo:(NSDictionary *)btnInfo,...
{
    self = [super init];
    if (self) {
        if (!btnInfo) {
            return self;
        }
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _backgroundView.alpha = 0.5;
        _backgroundView.backgroundColor = [UIColor blackColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHiddenGesture:)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
        [self addSubview:_backgroundView];
        
        _actionViewBg = [[UIImageView alloc] init];
        _actionViewBg.userInteractionEnabled = YES;
        [self addSubview:_actionViewBg];
        _viewType = viewType;
        switch (_viewType) {
            case ActionSheetViewTypeDefault:
            {
                va_list argList;
                va_start(argList, btnInfo);
                _count = 0;
                do {
                    UIButton *actionBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, _count *kActionBtnH, SCREEN_WIDTH, kActionBtnH)];
                    actionBtn.tag = kActionBtnTag + _count;
                    [actionBtn addTarget:self action:@selector(clickActionBtn:) forControlEvents:UIControlEventTouchUpInside];
                    UIImage *normalImage = [btnInfo valueForKey:kCustomActionBtnNormal];
                    UIImage *highlightImage = [btnInfo valueForKey:kCustomActionBtnHighlightImage];
                    [actionBtn setBackgroundImage:[normalImage stretchableImageWithLeftCapWidth:normalImage.size.width/2.0f topCapHeight:normalImage.size.height / 2.0f] forState:UIControlStateNormal];
                    [actionBtn setBackgroundImage:[highlightImage stretchableImageWithLeftCapWidth:highlightImage.size.width/2.0f topCapHeight:highlightImage.size.height / 2.0f] forState:UIControlStateHighlighted];
                    
                    NSString *title = [btnInfo valueForKey:kCustomActionBtnTitle];
                    [actionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    [actionBtn setTitle:title forState:UIControlStateNormal];
                    [actionBtn setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [_actionViewBg addSubview:actionBtn];
                    _count++;
                } while ((btnInfo = va_arg(argList, NSDictionary*)));
                va_end(argList);
                _actionViewBg.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, _count * kActionBtnH);
            }
                break;
            case ActionSheetViewTypeUndisturbed:
            {
                UILabel *titleLabel = [[UILabel alloc] init];
                titleLabel.backgroundColor = [UIColor clearColor];
                [titleLabel setFont:[UIFont systemFontOfSize:14]];
                titleLabel.shadowColor = [UIColor whiteColor];
                titleLabel.shadowOffset = CGSizeMake(0, 0.2);
                [titleLabel setText:title];
                [titleLabel sizeToFit];
                titleLabel.frame = CGRectMake((self.frame.size.width - titleLabel.frame.size.width)/  2.0f, 10, titleLabel.frame.size.width, titleLabel.frame.size.height);
                [_actionViewBg addSubview:titleLabel];
                
                va_list argList;
                va_start(argList, btnInfo);
                _count = 0;
                do {
                    UIButton *actionBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, _count *kActionBtnH + 40 + _count * 19, SCREEN_WIDTH - 20, kActionBtnH)];
                    actionBtn.tag = kActionBtnTag + _count;
                    [actionBtn addTarget:self action:@selector(clickActionBtn:) forControlEvents:UIControlEventTouchUpInside];
                    UIImage *normalImage = [btnInfo valueForKey:kCustomActionBtnNormal];
                    UIImage *highlightImage = [btnInfo valueForKey:kCustomActionBtnHighlightImage];
                    [actionBtn setBackgroundImage:[normalImage stretchableImageWithLeftCapWidth:normalImage.size.width/2.0f topCapHeight:normalImage.size.height / 2.0f] forState:UIControlStateNormal];
                    [actionBtn setBackgroundImage:[highlightImage stretchableImageWithLeftCapWidth:highlightImage.size.width/2.0f topCapHeight:highlightImage.size.height / 2.0f] forState:UIControlStateHighlighted];
                    
                    NSString *title = [btnInfo valueForKey:kCustomActionBtnTitle];
                    [actionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    [actionBtn setTitle:title forState:UIControlStateNormal];
                    [actionBtn setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [_actionViewBg addSubview:actionBtn];
                    _count++;
                } while ((btnInfo = va_arg(argList, NSDictionary*)));
                va_end(argList);
                
                _actionViewBg.backgroundColor = UIColorFromRGB(0xc6c6c6);
                _actionViewBg.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, _count * kActionBtnH + 40 + 19 * _count);
            }
                break;
            case ActionSheetViewTypeChatRoomType:
            {
                va_list argList;
                va_start(argList, btnInfo);
                _count = 0;
                do {
                    UIButton *actionBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, _count *kActionBtnH + 150, SCREEN_WIDTH, kActionBtnH)];
                    actionBtn.tag = kActionBtnTag + _count;
                    actionBtn.backgroundColor = [UIColor whiteColor];
                    [actionBtn addTarget:self action:@selector(clickActionBtn:) forControlEvents:UIControlEventTouchUpInside];
                    UIImage *highlightImage = [btnInfo valueForKey:kCustomActionBtnHighlightImage];
                    [actionBtn setBackgroundImage:[highlightImage stretchableImageWithLeftCapWidth:highlightImage.size.width/2.0f topCapHeight:highlightImage.size.height/2.0f] forState:UIControlStateHighlighted];
                    NSString *title = [btnInfo valueForKey:kCustomActionBtnTitle];
                    [actionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    [actionBtn setTitle:title forState:UIControlStateNormal];
                    [_actionViewBg addSubview:actionBtn];
                    
                    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, actionBtn.bounds.size.height - 1, SCREEN_WIDTH, 1)];
                    line.backgroundColor = kCommAppbackgroundColor;
                    [actionBtn addSubview:line];
                    _count++;
                } while ((btnInfo = va_arg(argList, NSDictionary*)));
                va_end(argList);
                _actionViewBg.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, _count * kActionBtnH + 160);
            }
                break;
            case ActionSheetViewTypeShareRouter:
            case ActionSheetViewTypeShare:
            {
                va_list argList;
                va_start(argList, btnInfo);
                _count = 0;
                UIImageView *imageViewQA = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 150)/2, 10, 0, 0)];
//                imageViewQA.image = [Common QRImageForShare:150];
                [_actionViewBg addSubview:imageViewQA];
                do {
                    UIButton *actionBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/3 * (_count%3),(_count > 2?kActionBtnH:0), SCREEN_WIDTH/3, kActionBtnH)];
                    actionBtn.tag = kActionBtnTag + _count;
                    actionBtn.backgroundColor = [UIColor whiteColor];
                    [actionBtn addTarget:self action:@selector(clickActionBtn:) forControlEvents:UIControlEventTouchUpInside];
                    
                    UIImage *highlightImage = [btnInfo valueForKey:kCustomActionBtnNormal];
                    [actionBtn setImage:highlightImage forState:UIControlStateNormal];
                    NSString *title = [btnInfo valueForKey:kCustomActionBtnTitle];
                    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(actionBtn.frame.origin.x, CGRectGetMaxY(actionBtn.frame) - 15, SCREEN_WIDTH/3, 30)];
                    label.text = title;
                    label.tag = 20000 + _count;
                    label.textAlignment = NSTextAlignmentCenter;
                    label.font = [UIFont systemFontOfSize:13];
                    actionBtn.backgroundColor = [UIColor clearColor];
                    [_actionViewBg addSubview:actionBtn];
                    [_actionViewBg addSubview:label];
                    _count++;
                } while ((btnInfo = va_arg(argList, NSDictionary*)));
                va_end(argList);
                _actionViewBg.backgroundColor = [UIColor whiteColor];
                _actionViewBg.frame = CGRectMake(0,
                                                 SCREEN_HEIGHT,
                                                 SCREEN_WIDTH,
                                                 (_count > 3)?(kActionBtnH * 2 + 30):(kActionBtnH) + 30);
            }
                break;
            default:
                break;
        }
    }
    return self;
}

-(void)tapHiddenGesture:(UIGestureRecognizer *)gesture
{
    [self hiddenCustomActionSheet];
}

#pragma mark - 
#pragma mark UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    //UIButton则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UIButton"]) {
        return NO;
    }
    return YES;
}
#pragma mark

-(void)showCustomActionSheet
{
    [ApplicationDelegate.window addSubview:self];
    NSLog(@"----------show custom actionSheet view and keyWindow = %@ and self frame = {x = %f y = %f w = %f h = %f}",[UIApplication sharedApplication].keyWindow,self.frame.origin.x,self.frame.origin.y,self.frame.size.width,self.frame.size.height);
    
    float actionBgY = 0;
    switch (_viewType) {
        case ActionSheetViewTypeDefault:
        {
            actionBgY = SCREEN_HEIGHT - _count * kActionBtnH;
        }
            break;
        case ActionSheetViewTypeUndisturbed:
        {
            actionBgY = SCREEN_HEIGHT - (_count * kActionBtnH + 40 + 19 * _count);
        }
            break;
        case ActionSheetViewTypeChatRoomType:
        {
            actionBgY = SCREEN_HEIGHT - _count * kActionBtnH;
        }
            break;
        case ActionSheetViewTypeShareRouter:
        case ActionSheetViewTypeShare:
        {
            actionBgY =  SCREEN_HEIGHT - _actionViewBg.frame.size.height;
        }
            break;
        default:
            break;
    }
    [UIView animateWithDuration:0.25 animations:^{
        _actionViewBg.frame = CGRectMake(0, actionBgY, _actionViewBg.frame.size.width, _actionViewBg.frame.size.height);
        _backgroundView.alpha = 0.5;
    } completion:^(BOOL finished) {
    }];
}


-(void)setBtnTitleColor:(UIColor *)color
{
    for (UIView *btnView in _actionViewBg.subviews) {
        if ([btnView isMemberOfClass:[UIButton class]]) {
            [((UIButton *)btnView) setTitleColor:color forState:UIControlStateNormal];
        }
    }
}

-(void)setBtnTitleFont:(UIFont *)font
{
    for (UIView *btnView in _actionViewBg.subviews) {
        if ([btnView isMemberOfClass:[UIButton class]]) {
            ((UIButton *)btnView).titleLabel.font = font;
        }
    }
}


-(void)hiddenCustomActionSheet
{
    [UIView animateWithDuration:0.3 animations:^{
        _actionViewBg.frame = CGRectMake(0, SCREEN_HEIGHT, _actionViewBg.frame.size.width, _actionViewBg.frame.size.height);
        _backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)clickActionBtn:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickCustonActionSheetIndex:)]) {
        NSInteger index = ((UIButton *)sender).tag - kActionBtnTag;
        [_delegate clickCustonActionSheetIndex:index];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(clickCustonActionSheetName:)]) {
        NSInteger index = ((UIButton *)sender).tag - kActionBtnTag;
        UILabel *lable = (UILabel *)[_actionViewBg viewWithTag:index + 20000];
        [_delegate clickCustonActionSheetName:lable.text];
        
    }
    [self hiddenCustomActionSheet];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
