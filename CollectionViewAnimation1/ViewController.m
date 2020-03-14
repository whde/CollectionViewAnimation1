//
//  ViewController.m
//  CollectionViewAnimation1
//
//  Created by whde on 2018/7/6.
//  Copyright © 2018年 whde. All rights reserved.
//

#import "ViewController.h"
#import "WhdeFlowLayout.h"
@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (assign, nonatomic) NSInteger currentIndex; // 当前Index
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WhdeFlowLayout *layout = [[WhdeFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 50, 0, 50);
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    self.collectionView.bounces = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.allowsSelection = NO;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.view insertSubview:self.collectionView atIndex:0];
    [NSNotificationCenter]
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    
    UIImageView *imageV = [cell.contentView viewWithTag:100];
    if (!imageV) {
        imageV = [[UIImageView alloc] initWithFrame:cell.contentView.bounds];
        imageV.contentMode = UIViewContentModeScaleAspectFit;
        [cell.contentView addSubview:imageV];
        imageV.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    }
    imageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.png", (long)indexPath.row]];
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = self.view.bounds.size.width-100;
    return CGSizeMake(width, collectionView.frame.size.height);
}


- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    UICollectionView *collectionView = (UICollectionView *)scrollView;
    CGFloat cellWidth = self.view.bounds.size.width-100;
    CGFloat cellPadding = ((UICollectionViewFlowLayout *)collectionView.collectionViewLayout).minimumLineSpacing;
    NSInteger page = roundf(targetContentOffset->x/(cellWidth+cellPadding));
    if (self.currentIndex==page) {
        if (velocity.x > 0) {
            page++;
        } else if (velocity.x < 0){
            page--;
        }
    } else if (page>self.currentIndex) {
        page = self.currentIndex+1;
    } else {
        page = self.currentIndex-1;
    }
    page = MAX(page,0);
    page = MIN(page, 9-1);
    CGFloat newOffset = page * (cellWidth + cellPadding)-collectionView.contentInset.left;
    targetContentOffset->x = newOffset;
    self.currentIndex = page;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
