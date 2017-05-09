# GradientsTextView
######前言
最近用小黄车发现地图界面下方的渐变模糊效果不错，遂想尝试实现一下。目的为**TextView**添加渐变模糊层以便提示用户阅读进度。效果如下：

![效果图1](http://upload-images.jianshu.io/upload_images/1767950-3e7517bb9c0ac3e7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![效果图2](http://upload-images.jianshu.io/upload_images/1767950-f262260a78d6bd4b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![效果图3](http://upload-images.jianshu.io/upload_images/1767950-b38cfe4955646016.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

对于渐变模糊效果我们要通过**CAGradientLayer**类进行实现。推荐一篇文章[CAGradientLayer的一些属性解析](http://www.tuicool.com/articles/RZBFBn)书写的比较详细。

该效果结构为主体TextView加上侧与下侧的渐变模糊层，并在**TextView**滚动时候调节渐变层显隐性即可。

首先分别创建**TextView**与渐变层，TextView创建代码已忽略。
```
- (void)createGradientLayer {
    //颜色分布
    NSArray *layerColors = @[(__bridge id)RGB(255, 255, 255, 0.0).CGColor, (__bridge id)RGB(255, 255, 255, 0.5).CGColor, (__bridge id)RGB(255, 255, 255, 0.95).CGColor];
    //分割位置
    NSArray *layerLocations = @[@(0.2), @(0.8), @(1.0)];

    _topGradientLayer = [CAGradientLayer layer];
    _topGradientLayer.borderWidth = 0;
    _topGradientLayer.frame = CGRectZero;
    _topGradientLayer.colors = layerColors;
    _topGradientLayer.locations  = layerLocations;
    //自下而上
    _topGradientLayer.startPoint = CGPointMake(0.5, 1.0);
    _topGradientLayer.endPoint = CGPointMake(0.5, 0.0);
    [self.layer addSublayer:_topGradientLayer];
    
    _bottomGradientLayer = [CAGradientLayer layer];
    _bottomGradientLayer.borderWidth = 0;
    _bottomGradientLayer.frame = CGRectZero;
    _bottomGradientLayer.colors = layerColors;
    _bottomGradientLayer.locations  = layerLocations;
     //自上而下
    _bottomGradientLayer.startPoint = CGPointMake(0.5, 0.0);
    _bottomGradientLayer.endPoint = CGPointMake(0.5, 1.0);
    [self.layer addSublayer:_bottomGradientLayer];
    
    _topGradientLayer.hidden = YES;
    _bottomGradientLayer.hidden = YES;
}
```
这里简单讲述下**CAGradientLayer**的一些重要属性
- **colors：**颜色分布，可将所需颜色存入数组中
- **locations：**颜色间隔位置
- **startPoint：**开始点
- **endPoint：**结束点
⚠️需要注意的是Layer的坐标系与通常坐标系有所不同，见下图

![Layer坐标系](http://upload-images.jianshu.io/upload_images/1767950-1948a4f90ff079a4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

因此比如**startPoint为（0，0）** **endPoint为（1，0）**，颜色渐变即为由左向右的方向，以此类推。

接下来在**layoutSubviews**方法中设置控件坐标并判断当前**TextView**文字占比是否高于当前**TextView**本身高度，若高于说明有未显示文字则显示下侧渐变层。这里简单调节了**TextView**的行间距，需要注意的是**TextView**设置行间距后系统会给文字上下各加**2px**，因此假设设置行间距为10，paragraphStyle需设置为**6px**。
```
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
```
最后我们都知道**TextView**继承于**UIScrollView**，所以我们可以在**scrollViewDidScroll**代理方法中调整上侧下侧渐变层的显隐性以达到我们想要的效果。
```
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
```
这里简单的判断偏移量大于15隐藏上侧显示下侧，偏移量距底部15显示下侧隐藏上侧。

效果实现到此结束，功能比较简单，娱乐一下。。。
[demo下载地址](https://github.com/LSure/GradientsTextView)
