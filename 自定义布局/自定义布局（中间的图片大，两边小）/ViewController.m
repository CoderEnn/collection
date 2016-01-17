//
//  ViewController.m
//  自定义布局（中间的图片大，两边小）
//
//  Created by zz on 16/1/4.
//  Copyright © 2016年 zz. All rights reserved.
//

#import "ViewController.h"
#import "ZDDCustomLayout.h"
#import "ZDDCollectionViewCell.h"
@interface ViewController ()<UICollectionViewDataSource>
@property (strong, nonatomic) NSArray *imgNameArr;
@end

static NSString *ID = @"cell";

@implementation ViewController
-(NSArray *)imgNameArr{

    if (_imgNameArr == nil) {
        _imgNameArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"app.plist" ofType:nil]];
    }
    return _imgNameArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZDDCustomLayout *layout = [[ZDDCustomLayout alloc]init];
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 200, 375, 200) collectionViewLayout:layout];
    
    collectionView.dataSource = self;
    
    [self.view addSubview:collectionView];
    [collectionView registerClass:[ZDDCollectionViewCell class] forCellWithReuseIdentifier:ID];
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.imgNameArr.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    NSDictionary *app = self.imgNameArr[indexPath.item];
    ZDDCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.imag = [UIImage imageNamed:app[@"icon"]];
//    cell.imgView.image = [UIImage imageNamed:app[@"icon"]];
    
    return cell;
}
@end
