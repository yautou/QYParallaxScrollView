//
//  ViewController.m
//  QYParallaxScrollViewDemo
//
//  Created by Qeye Wang on 22/02/2018.
//  Copyright © 2018 Qeye Wang. All rights reserved.
//

#import "ViewController.h"
#import "QYParallaxScrollView.h"

@interface ViewController () <QYParallaxScrollViewDelegate, QYParallaxScrollViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    QYParallaxScrollView *scrollView = [QYParallaxScrollView new];
    scrollView.cellsGap = 10.;
    scrollView.movementOffset = 20.;
    scrollView.rotationAngle = 10.;
    scrollView.delegate = self;
    scrollView.dataSource = self;
    [self.view addSubview:scrollView];
    QYLayoutLeading(scrollView, self.view, 0);
    QYLayoutTrailing(scrollView, self.view, 0);
    QYLayoutCenterY(scrollView, self.view, 0);
    QYLayoutHeight(scrollView, nil, 200);
}

#pragma mark QYParallaxScrollViewDataSource
- (NSInteger)numberOfItemsInQYPScrollView:(QYParallaxScrollView *)scrollView {
    return 5;
}

- (QYParallaxScrollViewCell *)QYPScrollView:(QYParallaxScrollView *)scrollView cellForItemAtIndex:(NSInteger)index {
    QYParallaxScrollViewCell *cell = [scrollView dequeueCellWithReuseIdentifier:QYParallaxCellIdentifier forIndex:index];
    cell.titleLabel.text = [NSString stringWithFormat:@"This is title %ld", (long)index];
    cell.descLabel.text = [NSString stringWithFormat:@"This is description %ld", (long)index];
    cell.backgroundImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld", index+1]];
    return cell;
}

#pragma mark QYParallaxScrollViewDelegate
- (CGSize)QYPScrollView:(QYParallaxScrollView *)scrollView sizeForItemAtIndex:(NSInteger)index {
    return CGSizeMake(CGRectGetWidth(UIApplication.sharedApplication.keyWindow.bounds)-40, 180);
}

- (void)QYPScrollView:(QYParallaxScrollView *)scrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"%s --- %ld", __FUNCTION__, (long)index);
    [scrollView scrollToIndex:index];
}

@end
