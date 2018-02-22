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
    
    [NSLayoutConstraint constraintWithItem:scrollView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:scrollView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:scrollView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:scrollView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:200].active = YES;
}

#pragma mark QYParallaxScrollViewDataSource
- (NSInteger)numberOfItemsInQYPScrollView:(QYParallaxScrollView *)scrollView {
    return 17;
}

- (QYParallaxScrollViewCell *)QYPScrollView:(QYParallaxScrollView *)scrollView cellForItemAtIndex:(NSInteger)index {
    QYParallaxScrollViewCell *cell = [QYParallaxScrollViewCell new];
    cell.textLabel.text = [NSString stringWithFormat:@"%d", index];
    return cell;
}

#pragma mark QYParallaxScrollViewDelegate
- (void)QYPScrollView:(QYParallaxScrollView *)scrollView didSelectItemAtIndex:(NSInteger)index {
    
}
@end
