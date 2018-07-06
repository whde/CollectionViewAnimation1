//
//  WhdeFlowLayout.m
//  Whde
//
//  Created by Whde on 16/5/25.
//  Copyright © 2016年 Whde. All rights reserved.
//

#import "WhdeFlowLayout.h"

@implementation WhdeFlowLayout
- (void)prepareLayout {
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumLineSpacing = 5;
}

// 当bounds发生变化的时候是否应该重新进行布局
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

// 这个方法在滚动的过程当中, 系统会根据需求来调用
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    CGFloat contentOffsetX = self.collectionView.contentOffset.x;
    CGFloat centerX = contentOffsetX+self.collectionView.frame.size.width/2;
    NSArray *original = [super layoutAttributesForElementsInRect:rect];
    NSArray *arrayAttrs = [[NSArray alloc] initWithArray:original copyItems:YES];;
    CGFloat factor = 0.0003;
    for (UICollectionViewLayoutAttributes *attr in arrayAttrs) {
        CGFloat cell_centerX = attr.center.x;
        CGFloat distance = ABS(cell_centerX - centerX);
        CGFloat scale = 1 / (1 + distance * factor);
        attr.transform = CGAffineTransformMakeScale(scale, scale);
        attr.alpha = 1/(1+distance*0.003);
    }
    return arrayAttrs;
}
@end
