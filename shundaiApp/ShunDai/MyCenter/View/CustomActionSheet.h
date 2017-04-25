//
//  MyCenterTableViewController.m
//  ShunDai
//
//  Created by Mac_Key on 16/5/7.
//  Copyright © 2016年 Key. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kCustomActionBtnTitle @"title"
#define kCustomActionBtnNormal @"normalImage"
#define kCustomActionBtnHighlightImage @"highlistImage"
#define kActionBtnH 80

typedef enum {
    ActionSheetViewTypeDefault,
    ActionSheetViewTypeUndisturbed,
    ActionSheetViewTypeChatRoomType,
    ActionSheetViewTypeShare,
    ActionSheetViewTypeShareRouter,
}CustomActionSheetViewType;

@protocol CustomActionSheetDelegate <NSObject>

@optional
- (void)clickCustonActionSheetIndex:(NSInteger)index;

- (void)clickCustonActionSheetName:(NSString *)nameStr;

@end

@interface CustomActionSheet : UIView<UIGestureRecognizerDelegate>
{
    UIView *_backgroundView;
    UIImageView *_actionViewBg;
    id<CustomActionSheetDelegate>_delegate;
    CustomActionSheetViewType _viewType;
    NSInteger _count;
}

@property(nonatomic,retain)id<CustomActionSheetDelegate>delegate;

-(id)initWithType:(CustomActionSheetViewType)viewType withTitle:(NSString *)title withBtnInfo:(NSDictionary *)btnInfo,...;
-(void)showCustomActionSheet;
-(void)setBtnTitleColor:(UIColor *)color;
-(void)setBtnTitleFont:(UIFont *)font;
@end
