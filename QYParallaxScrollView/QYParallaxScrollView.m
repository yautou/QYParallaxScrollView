//
//  QYParallaxScrollView.m
//  QYParallaxScrollViewDemo
//
//  Created by Qeye Wang on 22/02/2018.
//  Copyright © 2018 Qeye Wang. All rights reserved.
//

#import "QYParallaxScrollView.h"

@interface QYParallaxScrollView () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation QYParallaxScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.tableView.clipsToBounds = NO;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.transform = CGAffineTransformMakeRotation(-M_PI / 2);
        self.tableView.showsVerticalScrollIndicator = NO;
        self.tableView.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.tableView];
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
        QYLayoutDiffAttr(self.tableView, NSLayoutAttributeWidth, self, NSLayoutAttributeHeight, 0);
        QYLayoutDiffAttr(self.tableView, NSLayoutAttributeHeight, self, NSLayoutAttributeWidth, -20);
        QYLayoutCenterX(self.tableView, self, 0);
        QYLayoutCenterY(self.tableView, self, 0);
    }
    return self;
}

- (QYParallaxScrollViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier {
    QYParallaxScrollViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) cell = [[QYParallaxScrollViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    return cell;
}

- (void)scrollToIndex:(NSInteger)index {
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat tableMinY = scrollView.contentOffset.y;
    CGFloat tableMaxY = tableMinY + CGRectGetWidth(self.bounds);
    [self.tableView.visibleCells enumerateObjectsUsingBlock:^(__kindof QYParallaxScrollViewCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        //rotate whole card
        NSInteger index = [_tableView indexPathForCell:cell].row;
        CGFloat minY = index * QYParallaxScrollViewCell.cellHeight;
        CGFloat midY = minY + QYParallaxScrollViewCell.cellHeight/2;
        
        CGFloat angle = 20*(tableMaxY-midY)/(tableMaxY-tableMinY) - 10;
        [cell rotateByYVector:angle];
        
        //adjust background image
        CGFloat offset = 40*(tableMaxY-midY)/(tableMaxY-tableMinY) - 20;
        [cell adjustBackgroundImageByXVector:offset];
    }];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource numberOfItemsInQYPScrollView:self];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.dataSource QYPScrollView:self cellForItemAtIndex:indexPath.row];
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return QYParallaxScrollViewCell.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate QYPScrollView:self didSelectItemAtIndex:indexPath.row];
}
@end
