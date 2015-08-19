//
//  XMAlertView.m
//  XMAlertView
//
//  Created by rgshio on 15/8/19.
//  Copyright (c) 2015年. All rights reserved.
//

#import "XMAlertView.h"

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

#define offsetX 10

#define kAlertWidth (kScreenWidth-50)
#define kButtonHeight 45.0f

@interface XMAlertView ()

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *cancelTitle;
@property (nonatomic, strong) NSString *otherTitle;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIView *backImageView;

@end

@implementation XMAlertView

#define kContentOffset 30.0f
#define kBetweenLabelOffset 20.0f

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles
{
    if (self = [super init]) {
        
        self.title = title;
        self.message = message;
        self.cancelTitle = cancelButtonTitle;
        self.otherTitle = otherButtonTitles;
        
        self.titleFont = [UIFont boldSystemFontOfSize:17];
        self.messageFont = [UIFont systemFontOfSize:15];
        self.cancelFont = [UIFont systemFontOfSize:17];
        self.otherFont = [UIFont systemFontOfSize:17];
        
        self.layer.cornerRadius = 5.0;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(10, 10);
        self.layer.shadowOpacity = 0.3;
        self.layer.shadowRadius = 10;
        self.backgroundColor = [UIColor colorWithRed:(float)1 green:(float)1 blue:(float)1 alpha:1.0];
        
        [self loadMainView];
    }
    
    return self;
}

#pragma mark - 创建标题
- (void)loadTitle
{
    CGFloat height = 0.0f;//标题高度
    if (self.title.length > 0) {
        if (self.message.length > 0) {
            height = 20;
        }else {
            height = 60;
        }
    }
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(offsetX, 5, kAlertWidth-offsetX*2, height)];
    self.titleLabel.font = self.titleFont;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.text = self.title;
    [self addSubview:self.titleLabel];
    
    self.titleLabel.backgroundColor = [UIColor clearColor];
}

#pragma mark - 创建消息
- (void)loadMessage
{
    CGFloat height = 0.0f;//内容高度
    if (self.message.length > 0) {
        if (self.title.length > 0) {
            height = 80-self.titleLabel.frame.size.height;
        }else {
            height = 60;
        }
    }
    
    self.messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(offsetX, CGRectGetMaxY(self.titleLabel.frame), kAlertWidth-offsetX*2, height)];
    self.messageLabel.numberOfLines = 0;
    self.messageLabel.font = self.messageFont;
    self.messageLabel.textAlignment = NSTextAlignmentCenter;
    self.messageLabel.text = self.message;
    [self addSubview:self.messageLabel];
    
    self.messageLabel.backgroundColor = [UIColor clearColor];
}

#pragma mark - 创建Button
- (void)loadButton
{
    CGRect leftBtnFrame;
    CGRect rightBtnFrame;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.messageLabel.frame), kAlertWidth, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineView];
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];

    if (self.otherTitle.length == 0 || self.cancelTitle.length == 0) {
        if (self.otherTitle.length == 0) {
            leftBtnFrame = CGRectMake(0, CGRectGetMaxY(self.messageLabel.frame), kAlertWidth, kButtonHeight);
        }else {
            rightBtnFrame = CGRectMake(0, CGRectGetMaxY(self.messageLabel.frame), kAlertWidth, kButtonHeight);
        }
        
    }else {
        leftBtnFrame = CGRectMake(0, CGRectGetMaxY(self.messageLabel.frame), kAlertWidth * 0.5, kButtonHeight);
        rightBtnFrame = CGRectMake(CGRectGetMaxX(leftBtnFrame), CGRectGetMaxY(self.messageLabel.frame), kAlertWidth * 0.5, kButtonHeight);
        UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(kAlertWidth * 0.5, CGRectGetMaxY(self.messageLabel.frame), 1, kButtonHeight)];
        lineView1.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:lineView1];
    }
    
    self.leftBtn.frame = leftBtnFrame;
    [self.leftBtn setTitle:self.cancelTitle forState:UIControlStateNormal];
    self.leftBtn.titleLabel.font = self.cancelFont;
    [self.leftBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.leftBtn.tag = 0;
    [self.leftBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.leftBtn];

    self.rightBtn.frame = rightBtnFrame;
    [self.rightBtn setTitle:self.otherTitle forState:UIControlStateNormal];
    self.leftBtn.titleLabel.font = self.otherFont;
    [self.rightBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.rightBtn.tag = 1;
    [self.rightBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.rightBtn];
    
    self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
}

- (void)loadMainView
{

    [self loadTitle];
    
    [self loadMessage];
    
    [self loadButton];
}

- (void)buttonClick:(UIButton *)button
{
    if (self.actionBlock) {
        self.actionBlock(button.tag);
    }
    [self dismissAlert];
}

- (void)show
{
    UIViewController *topVC = [self appRootViewController];
    self.frame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - kAlertWidth) * 0.5, (kScreenHeight-CGRectGetMaxY(self.leftBtn.frame))*0.5, kAlertWidth, CGRectGetMaxY(self.leftBtn.frame));
    [topVC.view addSubview:self];
    
    self.alpha = 0.0f;
    [UIView animateWithDuration:0.17 animations:^{
        self.layer.transform = CATransform3DMakeScale(1.1, 1.1, 1.0);
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.12 animations:^{
            self.layer.transform = CATransform3DMakeScale(0.9, 0.9, 1.0);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                self.layer.transform = CATransform3DIdentity;
            } completion:^(BOOL finished) {
                
            }];
        }];
    }];
}

- (void)dismissAlert
{
    [self.backImageView removeFromSuperview];
    self.backImageView = nil;
    [self removeFromSuperview];
}

- (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview == nil) {
        return;
    }
    UIViewController *topVC = [self appRootViewController];
    
    if (!self.backImageView) {
        self.backImageView = [[UIView alloc] initWithFrame:topVC.view.bounds];
        self.backImageView.backgroundColor = [UIColor blackColor];
        self.backImageView.alpha = 0.3f;
        self.backImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    [topVC.view addSubview:self.backImageView];
    
    self.transform = CGAffineTransformMakeRotation(-M_1_PI / 2);
    CGRect afterFrame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - kAlertWidth) * 0.5, (CGRectGetHeight(topVC.view.bounds) - CGRectGetMaxY(self.leftBtn.frame)) * 0.5, kAlertWidth, CGRectGetMaxY(self.leftBtn.frame));
    [UIView animateWithDuration:0.0f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.transform = CGAffineTransformMakeRotation(0);
        self.frame = afterFrame;
    } completion:^(BOOL finished) {
    }];
    [super willMoveToSuperview:newSuperview];
}

@end
