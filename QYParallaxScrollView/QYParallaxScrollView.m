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
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.transform = CGAffineTransformMakeRotation(-M_PI / 2);
        self.tableView.showsVerticalScrollIndicator = NO;
        self.tableView.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.tableView];
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
        QYLayoutDiffAttr(self.tableView, NSLayoutAttributeWidth, self, NSLayoutAttributeHeight, 0);
        QYLayoutDiffAttr(self.tableView, NSLayoutAttributeHeight, self, NSLayoutAttributeWidth, 0);
        QYLayoutCenterX(self.tableView, self, 0);
        QYLayoutCenterY(self.tableView, self, 0);
    }
    return self;
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat tableMinY = scrollView.contentOffset.y;
    CGFloat tableMaxY = tableMinY + CGRectGetWidth(self.bounds);
    CGFloat tableMidY = tableMinY + CGRectGetWidth(self.bounds)/2;
//    NSLog(@"%f", offsetY);
    [self.tableView.visibleCells enumerateObjectsUsingBlock:^(__kindof QYParallaxScrollViewCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger index = [_tableView indexPathForCell:cell].row;
        CGFloat minY = index * QYParallaxScrollViewCell.cellHeight;
        CGFloat maxY = (index+1) * QYParallaxScrollViewCell.cellHeight;
        CGFloat midY = index * QYParallaxScrollViewCell.cellHeight*3/2;
        if (midY < tableMidY) {//-10 --- 0
            CGFloat gap = tableMinY - minY;
            [cell rotateByYVector:10*gap/(maxY-minY)];
        } else {//0 --- 10
            CGFloat gap = minY - tableMaxY;
            [cell rotateByYVector:10*gap/(maxY-minY)];
        }
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
