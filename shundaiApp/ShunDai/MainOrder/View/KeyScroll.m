//
//  KeyScroll.m
//  ShunDai
//
//  Created by Mac_key on 17/2/11.
//  Copyright © 2017年 com.ios. All rights reserved.
//

#import "KeyScroll.h"

#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

@interface KeyScroll () <UIScrollViewDelegate>
{
    CGFloat imgW;
    CGFloat imgH;
}
//@property (strong, nonatomic)  UIScrollView *scrollView;
@property (strong, nonatomic)  UIPageControl *pageView;
//声明计时器
@property (strong,nonatomic) NSTimer *timer;

@end

@implementation KeyScroll




- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
     imgW=frame.size.width;
     imgH=frame.size.height;
}

-(void)StartScroll{
    self.pageView = [[UIPageControl alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 120)/2, imgH - 30, 120, 20)];
    [self.superview addSubview:self.pageView];
//    self.pageView.backgroundColor = [UIColor blackColor];
    CGFloat imgY=0;
    for(int i=0;i<8;i++)
    {
        CGFloat imgX=i*imgW;
        UIImageView *img=[[UIImageView alloc] init];
        img.frame=CGRectMake(imgX, imgY, imgW, imgH);
        
        NSString *imgname=[NSString stringWithFormat:@"psb-%d",(i+1) ];
        img.image=[UIImage imageNamed:imgname];
        [self addSubview:img];
    }
    //设置contentsize
    self.contentSize=CGSizeMake(imgW*8, 0);
    
    //设置分页
    self.pagingEnabled=YES;
    //隐藏水平条
    self.showsHorizontalScrollIndicator=NO;
    //设置pagecount
    self.pageView.numberOfPages=8;
    self.pageView.currentPage=0;
    //设置自动换页
    [self.timer invalidate];
    self.timer=nil;
    self.timer=[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(changeImg) userInfo:nil repeats:YES];
    //设置计时器的优先级
    //获取消息循环对象
    NSRunLoop *runLoop=[NSRunLoop currentRunLoop];
    [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
    self.delegate = self;
}


//实现即将开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer invalidate];
    self.timer=nil;
}


//实现拖拽完成方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //再次创建计时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(changeImg) userInfo:nil repeats:YES];
    //设置计时器的优先级
    //获取消息循环对象
    NSRunLoop *runLoop=[NSRunLoop currentRunLoop];
    [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void) changeImg
{
    //获得页🐴
    NSInteger page=self.pageView.currentPage;
    //判断是否到最后一页
    if(page==(self.pageView.numberOfPages-1))
    {
        page=0;
    }
    else
    {
        page++;
    }
    //计算offset
    CGFloat offX=self.frame.size.width*(page);
    //设置偏移
    [self setContentOffset:CGPointMake(offX, 0) animated:YES];
    
}
//实现滚动的监听事件
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //获得偏移量
    CGFloat x=scrollView.contentOffset.x;
    
    //计算当前页数
    int page=(x+0.5*self.frame.size.width)/scrollView.frame.size.width;
    //NSLog(@"%d",page);
    //设置pageCount
    self.pageView.currentPage=page;
    
}


@end
