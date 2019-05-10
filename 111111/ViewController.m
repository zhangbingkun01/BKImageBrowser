//
//  ViewController.m
//  111111
//
//  Created by 张丙坤 on 2019/4/23.
//  Copyright © 2019 张丙坤. All rights reserved.
//

#import "ViewController.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong)UIScrollView *mainScrollView;
@property (nonatomic,strong)NSArray *imageArr;
@property (nonatomic,assign)NSInteger currentPage;//当前页
@property (nonatomic,assign)NSInteger forwardPage;//前一页

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.

    self.imageArr = @[[UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"],[UIImage imageNamed:@"3"],[UIImage imageNamed:@"4"],[UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"],[UIImage imageNamed:@"3"],[UIImage imageNamed:@"4"]];
    self.currentPage = 2;
    [self setUpView];
    if (self.currentPage) {
        [self.mainScrollView setContentOffset:CGPointMake(self.currentPage * ScreenWidth, 0) animated:YES];
    }
}

- (void)setUpView{
    for (int i = 0; i < self.imageArr.count; i++) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(i * ScreenWidth, 0, ScreenWidth, ScreenHeight)];
        scrollView.delegate = self;
        scrollView.minimumZoomScale = 1.0;
        scrollView.maximumZoomScale = 3;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        imageView.tag = 1000 + i;
        scrollView.tag = 2000 + i;
        imageView.image = self.imageArr[i];
        imageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [imageView addGestureRecognizer:tap];
        
        [scrollView addSubview:imageView];
        [self.mainScrollView addSubview:scrollView];
    }
    [self.view addSubview:self.mainScrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.mainScrollView) {
        self.currentPage = scrollView.contentOffset.x / ScreenWidth;
        NSLog(@"%ld",(long)self.currentPage);
        if (self.forwardPage != self.currentPage) {
            UIScrollView *scroll = [self.view viewWithTag:2000 + self.forwardPage];
            scroll.zoomScale = 1.0;
        }
        self.forwardPage = self.currentPage;
    }
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    if (scrollView != self.mainScrollView) {
        return [self.view viewWithTag:1000 + self.currentPage];
    }
    return nil;
}

- (void)tap:(UITapGestureRecognizer *)tap{
    NSLog(@"%ld",(long)self.currentPage);
}

-(UIScrollView *)mainScrollView{
    if (nil == _mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _mainScrollView.delegate = self;
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.scrollEnabled = YES;
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.contentSize = CGSizeMake( ScreenWidth * self.imageArr.count, 0);
    }
    return _mainScrollView;
}
@end
