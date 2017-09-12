//
//  GuideViewController.m
//  Guidance
//
//  Created by ddSoul on 2017/9/12.
//  Copyright © 2017年 dxl. All rights reserved.
//
//尺寸
#define BAScreenHeight [UIScreen mainScreen].bounds.size.height//屏幕高度
#define BAScreenWidth [UIScreen mainScreen].bounds.size.width//屏幕宽度
#import "GuideViewController.h"
#import "HomeViewController.h"
#import "UIView+Extension.h"

@interface GuideViewController ()<UIScrollViewDelegate>

#pragma mark - Property
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *phoneImageView;
@property (nonatomic, strong) UIView *phoneMaskView;
@property (nonatomic, strong) UIImageView *phoneContentView;
@property (nonatomic, strong) UIButton *starButton;

@end

@implementation GuideViewController

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpViews];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - Init UI
- (void)setUpViews {
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.phoneImageView];
    [self.phoneImageView addSubview:self.phoneMaskView];
    [self.phoneMaskView addSubview:self.phoneContentView];
    [self.scrollView addSubview:self.starButton];
}

#pragma mark - Private Methods
-(void)showStarButton {
    [UIView animateWithDuration:1.0f animations:^{
        _starButton.alpha = 1.0f;
    }];
}
- (void)hiddenStarButton {
    [UIView animateWithDuration:1.0f animations:^{
        _starButton.alpha = 0.0f;
    }];
}

#pragma makr - Touch Event
- (void)start {
    
    [UIView animateWithDuration:1.0 animations:^{
        CATransform3D transform = CATransform3DMakeScale(1.2, 1.2, 1.0);
        self.view.layer.transform = transform;
    } completion:^(BOOL finished) {
        HomeViewController *homeVc = [[HomeViewController alloc] init];
        UINavigationController *navgationVc = [[UINavigationController alloc] initWithRootViewController:homeVc];
        [[UIApplication sharedApplication].keyWindow setRootViewController:navgationVc];

    }];

}

#pragma mark - Setter、Getter
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"guideBg1"]];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(BAScreenWidth * 3, 0);
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
    }
    return _scrollView;
}
- (UIImageView *)phoneImageView {
    if (!_phoneImageView) {
        _phoneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(60, 50, BAScreenWidth-120 , BAScreenHeight-100)];
        _phoneImageView.image = [UIImage imageNamed:@"guidePhone"];
    }
    return _phoneImageView;
}
- (UIView *)phoneMaskView {
    if (!_phoneMaskView) {
        _phoneMaskView = [[UIView alloc] initWithFrame:CGRectMake(30, 30, BAScreenWidth-180, BAScreenHeight-210)];
        _phoneMaskView.clipsToBounds = YES;
    }
    return _phoneMaskView;
}
- (UIImageView *)phoneContentView {
    if (!_phoneContentView) {
        _phoneContentView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (BAScreenWidth-180)*3, BAScreenHeight-210)];
        _phoneContentView.image = [UIImage imageNamed:@"guideContent"];
    }
    return _phoneContentView;
}
- (UIButton *)starButton {
    if (!_starButton) {
        _starButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _starButton.backgroundColor = [UIColor redColor];
        _starButton.frame = CGRectMake(2*BAScreenWidth + 30, BAScreenHeight - 100, BAScreenWidth - 60, 60);
        _starButton.alpha = 0.0f;
        _starButton.layer.cornerRadius = 5;
        [_starButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    }
    return _starButton;
}

#pragma mark - scrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat scale = (BAScreenWidth-180)/BAScreenWidth;
    _phoneContentView.x = - offsetX * scale;
    _phoneImageView.x = offsetX + 60;
    
    if (offsetX > 0 && offsetX < BAScreenWidth) {
        CGFloat bgScale = (offsetX - BAScreenWidth * 2) / BAScreenWidth + 1;
        if (offsetX <= BAScreenWidth/2) {
            _phoneImageView.transform = CGAffineTransformMakeScale(-bgScale, -bgScale);
        }
        [self hiddenStarButton];
    } else if (offsetX >= 2*BAScreenWidth) {
        
        [self showStarButton];
    } else if (offsetX >= BAScreenWidth && offsetX <2*BAScreenWidth){
        
        [self hiddenStarButton];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
