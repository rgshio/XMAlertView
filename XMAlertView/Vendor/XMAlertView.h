//
//  XMAlertView.h
//  XMAlertView
//
//  Created by rgshio on 15/8/19.
//  Copyright (c) 2015年. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMAlertView : UIView

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
  cancelButtonTitle:(NSString *)cancelButtonTitle
  otherButtonTitles:(NSString *)otherButtonTitles;


- (void)show;

@property (nonatomic , copy) void (^actionBlock)(NSInteger buttonIndex);

/**
 *  标题字体
 */
@property (nonatomic, strong) UIFont *titleFont;

/**
 *  消息字体
 */
@property (nonatomic, strong) UIFont *messageFont;

/**
 *  取消按钮字体
 */
@property (nonatomic, strong) UIFont *cancelFont;

/**
 *  其他按钮字体
 */
@property (nonatomic, strong) UIFont *otherFont;


@end
