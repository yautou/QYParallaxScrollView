//
//  QYParallaxScrollView.m
//  QYParallaxScrollViewDemo
//
//  Created by Qeye Wang on 22/02/2018.
//  Copyright © 2018 Qeye Wang. All rights reserved.
//

#import "QYParallaxScrollView.h"

@interface QYParallaxScrollView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation QYParallaxScrollView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self customInit];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self customInit];
    }
    return self;
}

- (void)customInit {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = self.backgroundColor;
    self.collectionView.clipsToBounds = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerClass:QYParallaxScrollViewCell.class forCellWithReuseIdentifier:QYParallaxCellIdentifier];
    [self addSubview:self.collectionView];
    
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    QYLayoutCenter(self.collectionView, self);
    QYLayoutSize(self.collectionView, self);
}

- (QYParallaxScrollViewCell *)dequeueCellWithReuseIdentifier:(NSString *)identifier forIndex:(NSInteger)index {
    QYParallaxScrollViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    [cell rotateByYVector:0];
    [cell moveByXVector:0];
    return cell;
}

- (void)scrollToIndex:(NSInteger)index {
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

- (void)reloadData {
    [_collectionView reloadData];
    [_collectionView.collectionViewLayout invalidateLayout];
    [self updateInterface];
}

- (void)updateInterface {
    CGFloat tableMinY = _collectionView.contentOffset.x;
    CGFloat tableMaxY = tableMinY + CGRectGetWidth(self.bounds);
    [self.collectionView.visibleCells enumerateObjectsUsingBlock:^(__kindof QYParallaxScrollViewCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger index = [self.collectionView indexPathForCell:cell].row;
        CGFloat minY = index * CGRectGetWidth(cell.bounds);
        CGFloat midY = minY + CGRectGetWidth(cell.bounds)/2;
        CGFloat multiplier = 2 * (tableMaxY-midY)/(tableMaxY-tableMinY) - 1;
        
        //rotate whole card
        if (_rotationAngle != 0) {
            [cell rotateByYVector:_rotationAngle * multiplier];
        }
        
        //adjust background image
        if (_movementOffset != 0) {
            [cell moveByXVector:_movementOffset * multiplier];
        }
    }];
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self updateInterface];
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataSource numberOfItemsInQYPScrollView:self];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.dataSource QYPScrollView:self cellForItemAtIndex:indexPath.row];
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate QYPScrollView:self didSelectItemAtIndex:indexPath.row];
}

#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.delegate QYPScrollView:self sizeForItemAtIndex:indexPath.row];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return _cellsGap == 0 ? CGFLOAT_MIN : _cellsGap;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(_cellsGap, 1);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(_cellsGap, 1);
}
@end
