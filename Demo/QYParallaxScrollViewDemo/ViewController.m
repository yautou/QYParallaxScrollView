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
    scrollView.delegate = self;
    scrollView.dataSource = self;
//    scrollView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:scrollView];
    
    QYLayoutLeading(scrollView, self.view, 0);
    QYLayoutTrailing(scrollView, self.view, 0);
    QYLayoutCenterY(scrollView, self.view, 0);
    QYLayoutHeight(scrollView, nil, 200);
}

#pragma mark QYParallaxScrollViewDataSource
- (NSInteger)numberOfItemsInQYPScrollView:(QYParallaxScrollView *)scrollView {
    return 17;
}

- (QYParallaxScrollViewCell *)QYPScrollView:(QYParallaxScrollView *)scrollView cellForItemAtIndex:(NSInteger)index {
    QYParallaxScrollViewCell *cell = [QYParallaxScrollViewCell new];
    cell.titleLabel.text = [NSString stringWithFormat:@"This is title %ld", (long)index];
    cell.descLabel.text = [NSString stringWithFormat:@"This is description %ld", (long)index];
    return cell;
}

#pragma mark QYParallaxScrollViewDelegate
- (void)QYPScrollView:(QYParallaxScrollView *)scrollView didSelectItemAtIndex:(NSInteger)index {
    
}
@end
