//
//  WHCircleProgress.h
//  CircleProgress
//
//  Created by 葛大婷 on 2020/2/19.
//  Copyright © 2020 葛大婷. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol WHCircleProgressDelegate <NSObject>

-(void)startCertificationFunction;

@end

@interface WHCircleProgress : UIView
{
    
}

/** 当前分 */
@property (nonatomic, assign) CGFloat currentScore;
/** 最大分 */
@property (nonatomic, assign) CGFloat highestScore;
/** 底层颜色 */
@property (nonatomic, strong) UIColor *bottomColor;
/** 顶层颜色 */
@property (nonatomic, strong) UIColor *topColor;
/** 顶层圆点颜色 */
@property (nonatomic, strong) UIColor *topDotColor;
/** 宽度 */
@property (nonatomic, assign) CGFloat progressWidth;
/** 是否认证 */
@property (nonatomic, assign) BOOL isCertified;
/** 标题图片 */
@property (nonatomic, strong) UIImage *showImage;
/** 认证 */
@property (nonatomic, strong) NSString *certifiedName;

@property (nonatomic, weak) id<WHCircleProgressDelegate>delegate;

/** 初始化 */
- (instancetype)initWithFrame:(CGRect)frame currentScore:(CGFloat)currentScore highestScore:(CGFloat)highestScore;

@end

NS_ASSUME_NONNULL_END
