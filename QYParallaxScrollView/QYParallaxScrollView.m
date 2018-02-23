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
    [self.tableView.visibleCells enumerateObjectsUsingBlock:^(__kindof QYParallaxScrollViewCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        [cell updateWithOffset:scrollView.contentOffset.y];
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
    return CGRectGetWidth(self.bounds) - 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate QYPScrollView:self didSelectItemAtIndex:indexPath.row];
}
@end
