//
//  ZDDCollectionViewCell.m
//  自定义布局（中间的图片大，两边小）
//
//  Created by zz on 16/1/4.
//  Copyright © 2016年 zz. All rights reserved.
//

#import "ZDDCollectionViewCell.h"
#import "UIView+DSImages.h"

@interface ZDDCollectionViewCell ()
@property (strong, nonatomic) UIImageView *imgView;
@end
@implementation ZDDCollectionViewCell


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

    UIImageView *imgView = [[UIImageView alloc]init];
    [self.contentView addSubview:imgView];
    self.imgView = imgView;
    }
    return self;
}
-(void)layoutSubviews{
[super layoutSubviews];
    
    NSLog(@"%@",NSStringFromCGRect(self.frame));
    CGRect frame1 = CGRectMake(0, 0, 100, 100);
    self.imgView.frame = frame1;
    //镜面效果
    [self.imgView clearReflecitonLayer];
    [self.imgView addReflectionToSuperLayer];
}
-(void)setImag:(UIImage *)imag{

    _imag = imag;
    self.imgView.image = imag;
}
@end
