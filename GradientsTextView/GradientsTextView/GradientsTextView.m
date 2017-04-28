//
//  GradientsTextView.m
//  GradientsTextView
//
//  Created by 刘硕 on 2017/4/27.
//  Copyright © 2017年 刘硕. All rights reserved.
//

#import "GradientsTextView.h"

@interface GradientsTextView ()<UITextViewDelegate>
@property (nonatomic, strong) CAGradientLayer *topGradientLayer;
@property (nonatomic, strong) CAGradientLayer *bottomGradientLayer;

@end
@implementation GradientsTextView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createTextView];
        [self createGradientLayer];
    }
    return self;
}

- (void)createTextView {
    _textView = [[UITextView alloc]initWithFrame:CGRectZero];
    _textView.delegate = self;
    [self addSubview:_textView];
}

- (void)createGradientLayer {
    NSArray *layerColors = @[(__bridge id)RGB(255, 255, 255, 0.0).CGColor, (__bridge id)RGB(255, 255, 255, 0.5).CGColor, (__bridge id)RGB(255, 255, 255, 0.95).CGColor];
    NSArray *layerLocations = @[@(0.0), @(0.8), @(1.0)];
    _topGradientLayer = [CAGradientLayer layer];
    _topGradientLayer.borderWidth = 0;
    _topGradientLayer.frame = CGRectZero;
    _topGradientLayer.colors = layerColors;
    _topGradientLayer.locations  = layerLocations;
    _topGradientLayer.startPoint = CGPointMake(0.5, 1.0);
    _topGradientLayer.endPoint = CGPointMake(0.5, 0.0);
    [self.layer addSublayer:_topGradientLayer];
    
    _bottomGradientLayer = [CAGradientLayer layer];
    _bottomGradientLayer.borderWidth = 0;
    _bottomGradientLayer.frame = CGRectZero;
    _bottomGradientLayer.colors = layerColors;
    _bottomGradientLayer.locations  = layerLocations;
    _bottomGradientLayer.startPoint = CGPointMake(0.5, 0.0);
    _bottomGradientLayer.endPoint = CGPointMake(0.5, 1.0);
    [self.layer addSublayer:_bottomGradientLayer];
    
    _topGradientLayer.hidden = YES;
    _bottomGradientLayer.hidden = YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    _textView.frame = self.bounds;
    _topGradientLayer.frame = CGRectMake(0, 0, width, height / 2);
    _bottomGradientLayer.frame = CGRectMake(0, height / 2, width, height / 2);
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6];
    CGSize size = [_textView.text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_textView.font,NSParagraphStyleAttributeName:paragraphStyle} context:NULL].size;
    if (size.height > height) {
        _topGradientLayer.hidden = YES;
        _bottomGradientLayer.hidden = NO;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y > 15) {
        _topGradientLayer.hidden = NO;
    }else{
        _topGradientLayer.hidden = YES;
    }
    if (scrollView.contentOffset.y < scrollView.contentSize.height - 15 - scrollView.frame.size.height) {
        _bottomGradientLayer.hidden = NO;
    }else{
        _bottomGradientLayer.hidden = YES;
    }
}

static inline UIColor* RGB(CGFloat r,CGFloat g,CGFloat b,CGFloat a)
{
    return  [UIColor
             colorWithRed:r/255.0
             green:g/255.0
             blue:b/255.0
             alpha:a];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
