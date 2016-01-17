//
//  ZDDCustomLayout.m
//  自定义布局（中间的图片大，两边小）
//
//  Created by zz on 16/1/4.
//  Copyright © 2016年 zz. All rights reserved.
//

#import "ZDDCustomLayout.h"

@implementation ZDDCustomLayout
//基本设置
-(instancetype)init{

    if (self = [super init]) {
        self.itemSize = CGSizeMake(100, 100);
        self.minimumLineSpacing = 50;
        self.minimumInteritemSpacing = 50;
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
    }
    return self;
}
/**
 //  用来设置布局我们所有的cell的属性。
 // UICollectionViewLayoutAttributes：代表了了每一个cell的属性,可以确定cell的大小，透明度，还有transform
 // 在这个方法中可以用来设置每一个cell的属性，每一cell的属性由UICollectionViewLayoutAttributes决定
 */

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{

    //调用父类方法，获取属性数组
    NSArray *attrArr = [super layoutAttributesForElementsInRect:rect];
    //遍历数组修改cell的transform
       //1.获取屏幕中间的x值
    CGFloat screenCenterX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
      //2.修改属性值
//    NSMutableArray *tempArr = [NSMutableArray array];
    for (UICollectionViewLayoutAttributes *attr in attrArr) {
       
        // 计算每个cell和中心点的距离
        CGFloat distance = ABS(attr.center.x - screenCenterX);
        
        // 距离越大, 缩放比越小, 距离越小，缩放比越大
        CGFloat factor = 0.003;
        CGFloat scale =1 / (1 + distance * factor);


        attr.transform = CGAffineTransformMakeScale(scale, scale);
//        [tempArr addObject:attr];
    }
    return attrArr;
}

//当返回yes的时候，当显示布局发生改变，就会重新调用上面的layoutAttributesForElementsInRect，给每一个cell重写设置属性。
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{

    return YES;
}
//根据偏移量决定cell最终停留的位置
-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{

    CGFloat screenCenterX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    //获得可视范围
    CGRect visibleRect ;
    visibleRect.origin = proposedContentOffset;
    visibleRect.size = self.collectionView.bounds.size;
//    CGRect visibleRect = CGRectMake(visibleX, visibleY, visibleW, visibleH);
    //获取可视范围内cell的属性值
    NSArray *attrArr = [self layoutAttributesForElementsInRect:visibleRect];
    //计算距离中心点的最小偏移距离
    CGFloat delat = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attr in attrArr) {
        
        delat = ABS(attr.center.x - screenCenterX)<delat?ABS(attr.center.x - screenCenterX):delat;

    }
    return CGPointMake(proposedContentOffset.x + delat, proposedContentOffset.y);
}
@end
