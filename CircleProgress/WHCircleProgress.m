//
//  WHCircleProgress.m
//  CircleProgress
//
//  Created by 葛大婷 on 2020/2/19.
//  Copyright © 2020 葛大婷. All rights reserved.
//

#import "WHCircleProgress.h"
#define RangeNum 400.f

@interface WHCircleProgress (){
    /** 原点 */
    CGPoint _origin;
    /** 半径 */
    CGFloat _radius;
    /** 起始 */
    CGFloat _startAngle;
    /** 结束 */
    CGFloat _endAngle;
}
/** 进度显示View */
@property (nonatomic, strong) UIView *progressView;
/** 进度显示Label */
@property (nonatomic, strong) UILabel *progressLabel;
//@property (nonatomic, strong)
/** 认证显示Label */
@property (nonatomic, strong) UILabel *certifiedLabel;
/** 标题图片 */
@property (nonatomic, strong) UIImageView *showImageView;

/** 未认证进度显示View */
@property (nonatomic, strong) UIView *progressNoCertifiedView;
/** 未认证进度显示Label */
@property (nonatomic, strong) UILabel *progressNoCertifiedLabel;
//@property (nonatomic, strong)
/** 未认证认证显示Label */
@property (nonatomic, strong) UILabel *certifiedNoCertifiedLabel;
/** 未认证标题图片 */
@property (nonatomic, strong) UIImageView *showNoCertifiedImageView;
/** 开始认证按钮 */
@property (nonatomic, strong) UIButton *certifiedButton;
/** 认证按钮 */
@property (nonatomic, strong) UIButton *certifiedNewButton;

/** 底层显示层 */
@property (nonatomic, strong) CAShapeLayer *bottomLayer;
/** 顶层显示层2 */
@property (nonatomic, strong) CAShapeLayer *topLayer;
/** 顶层圆点 */
@property (nonatomic, strong) CAShapeLayer *topDotLayer;

@end

@implementation WHCircleProgress

- (instancetype)initWithFrame:(CGRect)frame currentScore:(CGFloat)currentScore highestScore:(CGFloat)highestScore{
    if (self) {
        self = [super initWithFrame:frame];
        self.backgroundColor = [UIColor clearColor];
        [self setUI];
        _highestScore = highestScore;
        self.currentScore = currentScore;
    }
    return self;
}

#pragma mark - 初始化页面
- (void)setUI {
    
    [self.layer addSublayer:self.bottomLayer];
    [self.layer addSublayer:self.topLayer];
    [self.layer addSublayer:self.topDotLayer];
    [self addSubview:self.progressView];
    [self addSubview:self.progressNoCertifiedView];
    [self addSubview:self.certifiedNewButton];
    _origin = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    _radius = self.bounds.size.width / 2 - 30;
    UIBezierPath *bottomPath = [UIBezierPath bezierPathWithArcCenter:_origin radius:_radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    _bottomLayer.path = bottomPath.CGPath;
    
}

#pragma mark - 懒加载
-(UIView *)progressView{
    if (!_progressView) {
        _progressView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 70)];
        _progressView.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        _progressView.backgroundColor = [UIColor clearColor];
        [_progressView addSubview:self.progressLabel];
        [_progressView addSubview:self.showImageView];
        [_progressView addSubview:self.certifiedLabel];
    }
    return _progressView;
}

- (UILabel *)progressLabel {
    if (!_progressLabel) {
        _progressLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _progressView.frame.size.width, 40)];
        _progressLabel.textAlignment = NSTextAlignmentCenter;
        _progressLabel.textColor = [UIColor whiteColor];
    }
    return _progressLabel;
}

-(UIImageView *)showImageView{
    if (!_showImageView) {
        _showImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 43, 21, 21)];
        _showImageView.image = [UIImage imageNamed:@"huomiaoWhite.png"];
        _showImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _showImageView;
}

-(UILabel *)certifiedLabel{
    if (!_certifiedLabel) {
        _certifiedLabel = [[UILabel alloc] initWithFrame:CGRectMake(34, 43, 65, 21)];
        _certifiedLabel.textAlignment = NSTextAlignmentCenter;
        _certifiedLabel.textColor = [UIColor whiteColor];
        _certifiedLabel.font = [UIFont systemFontOfSize:20];
        _certifiedLabel.text = @"未认证";
    }
    return _certifiedLabel;
}

-(UIView *)progressNoCertifiedView{
    if (!_progressNoCertifiedView) {
        _progressNoCertifiedView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width - 50, 150)];
        _progressNoCertifiedView.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        _progressNoCertifiedView.backgroundColor = [UIColor clearColor];
        [_progressNoCertifiedView addSubview:self.progressNoCertifiedLabel];
        [_progressNoCertifiedView addSubview:self.certifiedNoCertifiedLabel];
        [_progressNoCertifiedView addSubview:self.showNoCertifiedImageView];
        [_progressNoCertifiedView addSubview:self.certifiedButton];
    }
    return _progressNoCertifiedView;
}

-(UILabel *)progressNoCertifiedLabel{
    if (!_progressNoCertifiedLabel) {
        _progressNoCertifiedLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _progressNoCertifiedView.frame.size.width, 68)];
        _progressNoCertifiedLabel.textAlignment = NSTextAlignmentCenter;
        _progressNoCertifiedLabel.textColor = [UIColor whiteColor];
        [_progressNoCertifiedLabel setAttributedText:[self changeLabelNewWithText:@"0" withOneSize:80 withEndSize:39 withYuan:YES]];
    }
    return _progressNoCertifiedLabel;
}

-(UIImageView *)showNoCertifiedImageView{
    if (!_showNoCertifiedImageView) {
        _showNoCertifiedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.certifiedNoCertifiedLabel.frame) - 24, 78, 21, 21)];
        _showNoCertifiedImageView.image = [UIImage imageNamed:@"huomiaoWhite.png"];
        _showNoCertifiedImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _showNoCertifiedImageView;
}

-(UILabel *)certifiedNoCertifiedLabel{
    if (!_certifiedNoCertifiedLabel) {
        _certifiedNoCertifiedLabel = [[UILabel alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.progressNoCertifiedView.frame) - 80) / 2, 78, 80, 21)];
        _certifiedNoCertifiedLabel.textAlignment = NSTextAlignmentCenter;
        _certifiedNoCertifiedLabel.textColor = [UIColor whiteColor];
        _certifiedNoCertifiedLabel.font = [UIFont systemFontOfSize:13];
        _certifiedNoCertifiedLabel.text = @"您还没有认证";
    }
    return _certifiedNoCertifiedLabel;
}

-(UIButton *)certifiedButton{
    if (!_certifiedButton) {
        _certifiedButton = [[UIButton alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.progressNoCertifiedView.frame) - 90) / 2, 109, 90, 41)];
        [_certifiedButton addTarget:self action:@selector(certifiedButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_certifiedButton setTitle:@"开始认证" forState:UIControlStateNormal];
        [_certifiedButton.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
        [_certifiedButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_certifiedButton setBackgroundColor:UIColor.clearColor];
//        _certifiedButton.layer.shadowColor = [StaticResources resourceInstance].whiteColor.CGColor;
        _certifiedButton.layer.cornerRadius = 6;
//        _certifiedButton.layer.shadowOffset = CGSizeMake(2, 2);
//        _certifiedButton.layer.shadowOpacity = 0.8;
        _certifiedButton.layer.borderWidth = 1.f;
        _certifiedButton.layer.borderColor = UIColor.whiteColor.CGColor;
    }
    
    return _certifiedButton;
}

-(UIButton *)certifiedNewButton{
    if (!_certifiedNewButton) {
        _certifiedNewButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        [_certifiedNewButton addTarget:self action:@selector(certifiedNewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_certifiedNewButton setBackgroundColor:UIColor.clearColor];
    }
    return _certifiedNewButton;
}

- (CAShapeLayer *)bottomLayer {
    if (!_bottomLayer) {
        _bottomLayer = [CAShapeLayer layer];
        _bottomLayer.fillColor = [UIColor clearColor].CGColor;
        
    }
    return _bottomLayer;
}

- (CAShapeLayer *)topLayer {
    if (!_topLayer) {
        _topLayer = [CAShapeLayer layer];
        _topLayer.lineCap = kCALineCapRound;
        _topLayer.fillColor = [UIColor clearColor].CGColor;
    }
    return _topLayer;
}

-(CAShapeLayer *)topDotLayer{
    if (!_topDotLayer) {
        _topDotLayer = [CAShapeLayer layer];
        _topDotLayer.lineCap = kCALineCapRound;
        _topDotLayer.fillColor = [UIColor clearColor].CGColor;
    }
    return _topDotLayer;
}



#pragma mark - setMethod
//- (void)setProgress:(CGFloat)progress {
//    _progress = progress;
//    _progressLabel.text = [NSString stringWithFormat:@"%.0f%%",progress * 100];
//
//    _startAngle = - M_PI_2;
//    _endAngle = _startAngle + _progress * M_PI * 2;
//
//    UIBezierPath *topPath = [UIBezierPath bezierPathWithArcCenter:_origin radius:_radius startAngle:_startAngle endAngle:_endAngle clockwise:YES];
//    _topLayer.path = topPath.CGPath;
//}

-(void)setHighestScore:(CGFloat)highestScore{
    _highestScore = highestScore;
    _endAngle = _currentScore / _highestScore * M_PI * 2;
}

-(void)setCurrentScore:(CGFloat)currentScore{
    _currentScore = currentScore;
    
    if (currentScore < self.highestScore) {
        [_progressNoCertifiedLabel setAttributedText:[self changeLabelWithText:[NSString stringWithFormat:@"%.f",_currentScore] withOneSize:80 withEndSize:39 withYuan:YES]];
    }else{
        [_progressLabel setAttributedText:[self changeLabelWithText:[NSString stringWithFormat:@"%.f",_currentScore] withOneSize:40 withEndSize:20 withYuan:YES]];
    }
    
    
    
    _startAngle = - M_PI_2;
    _endAngle = _currentScore / _highestScore * M_PI * 2;
    [self setNeedsDisplay];
    
}


- (void)setBottomColor:(UIColor *)bottomColor {
    _bottomColor = bottomColor;
    _bottomLayer.strokeColor = _bottomColor.CGColor;
    
}

- (void)setTopColor:(UIColor *)topColor {
    _topColor = topColor;
    _topLayer.strokeColor = _topColor.CGColor;
}

-(void)setTopDotColor:(UIColor *)topDotColor{
    _topDotColor = topDotColor;
    _topDotLayer.fillColor = _topDotColor.CGColor;
}

- (void)setProgressWidth:(CGFloat)progressWidth {
    
    _progressWidth = progressWidth;
    _topLayer.lineWidth = progressWidth;
    _bottomLayer.lineWidth = progressWidth;
    CGPoint _topDotorigin = CGPointMake(_origin.x, _origin.y - _radius);
    UIBezierPath *topDotPath = [UIBezierPath bezierPathWithArcCenter:_topDotorigin radius:_progressWidth startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    _topDotLayer.path = topDotPath.CGPath;
}

-(void)setCertifiedName:(NSString *)certifiedName{
    _certifiedName = certifiedName;
    [_certifiedButton setTitle:_certifiedName == nil ? @"开始认证" : _certifiedName forState:UIControlStateNormal];
}

-(void)setIsCertified:(BOOL)isCertified{
    _isCertified = isCertified;
    if (_isCertified == NO) {
        _certifiedLabel.text = @"未认证";
        _progressView.hidden = YES;
        _progressNoCertifiedView.hidden = NO;
        _certifiedNewButton.hidden = NO;
    }else{
        _certifiedLabel.text = @"已认证";
        _progressView.hidden = NO;
        _progressNoCertifiedView.hidden = YES;
        _certifiedNewButton.hidden = YES;
    }
}

-(void)setShowImage:(UIImage *)showImage{
    _showImage = showImage;
    _showImageView.image = showImage;
}

//创建一个返回富文本的方法
-(NSMutableAttributedString*) changeLabelWithText:(NSString*)needText withOneSize:(CGFloat)oneSize withEndSize:(CGFloat)endSize withYuan:(BOOL)isYuan
{
    if (isYuan == YES) {
        needText = [NSString stringWithFormat:@"%@分",needText];
    }
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:needText];
    UIFont *font = [UIFont boldSystemFontOfSize:oneSize];
    [attrString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0,needText.length - 1)];
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:endSize] range:NSMakeRange(needText.length - 1,1)];
    
    return attrString;
}

//创建一个返回富文本的方法 新
-(NSMutableAttributedString*) changeLabelNewWithText:(NSString*)needText withOneSize:(CGFloat)oneSize withEndSize:(CGFloat)endSize withYuan:(BOOL)isYuan
{
    if (isYuan == YES) {
        needText = [NSString stringWithFormat:@"%@分",needText];
    }
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:needText];
    UIFont *font = [UIFont systemFontOfSize:oneSize];
    [attrString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0,needText.length - 1)];
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:endSize] range:NSMakeRange(needText.length - 1,1)];
    
    return attrString;
}

- (void)drawRect:(CGRect)rect
{
    
    CGFloat radius = self.bounds.size.width / 2;
    CGFloat drawLength = 8;
    //获得处理的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //指定直线样式

    CGContextSetLineCap(context, kCGLineCapSquare);
    //直线宽度
    CGContextSetLineWidth(context, 3.0);
    for (int i = 0; i < 11; i++) {
        
        CGFloat intervali = M_PI / 10 * i;
        CGFloat pointsX = radius * (1 - cos(intervali));
        CGFloat pointsY = radius * (1 - sin(intervali));
        NSLog(@"%.2f  %.2f",pointsX,pointsY);
        CGFloat alpha = 0.2 * (i + 1);
        if (alpha > 1) {
            alpha = 2 - alpha;
        }
        //设置颜色
        CGContextSetRGBStrokeColor(context,
                                   1, 1, 1, 1);
        //开始绘制
        CGContextBeginPath(context);
        //画笔移动到点(31,170)
        CGContextMoveToPoint(context, pointsX, pointsY);
        pointsX = radius - (radius - drawLength) * cos(intervali);
        pointsY = radius - (radius - drawLength) * sin(intervali);
        NSLog(@"%.2f  %.2f",pointsX,pointsY);
        //下一点
        CGContextAddLineToPoint(context,
                                pointsX, pointsY);
        //绘制完成
        CGContextStrokePath(context);

    }
    
    NSArray *array = [self getRGBComponentsForColor:_topColor];
    NSString *str = [array objectAtIndex:0];
    CGFloat red = str.floatValue;
    str = [array objectAtIndex:1];
    CGFloat green = str.floatValue;
    str = [array objectAtIndex:2];
    CGFloat blue = str.floatValue;
    str = [array objectAtIndex:3];
    CGFloat alpha = str.floatValue;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    
    for (int i = 1; i < RangeNum; i++) {
        CGContextSetLineWidth(context, _progressWidth);
        CGContextSetStrokeColorWithColor(context, color.CGColor);
        CGContextAddArc(context, _origin.x, _origin.y, _radius, _startAngle + _endAngle * (i - 1) / RangeNum, _startAngle + _endAngle * i / RangeNum, 0);
        CGContextDrawPath(context, kCGPathStroke);
        CGFloat biLi = i / RangeNum;
//        NSLog(@"%f",biLi);
        CGFloat alphaBiLi = (1 - biLi) < 0.1 ? 0.1 : (1 - biLi);
        color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha * alphaBiLi];
        
    }
    
    
    
    
}

- (NSArray*)getRGBComponentsForColor:(UIColor *)color {
    NSMutableArray *components = [NSMutableArray array];
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char resultingPixel[4];
    CGContextRef context = CGBitmapContextCreate(&resultingPixel, 1, 1, 8, 4, rgbColorSpace, kCGImageAlphaNoneSkipLast);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    CGContextRelease(context);
    CGColorSpaceRelease(rgbColorSpace);
    for (int component = 0; component < 4; component++) {
        [components addObject:[NSNumber numberWithFloat:(resultingPixel[component] / 255.0f)]];
        
    }
    return components;
    
}

-(void)certifiedButtonAction:(UIButton*)sender{
    [_delegate startCertificationFunction];
}

-(void)certifiedNewButtonAction:(UIButton*)sender{
    [_delegate startCertificationFunction];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
