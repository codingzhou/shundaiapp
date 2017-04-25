//
//  UMImage+Scaling.h
//  PengPeng
//
//  Created by luoyang on 13-10-22.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImage(UIImage_Scaling)
- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize;
@end
