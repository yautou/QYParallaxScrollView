//
//  QYParallaxScrollView.h
//  QYParallaxScrollViewDemo
//
//  Created by Qeye Wang on 22/02/2018.
//  Copyright © 2018 Qeye Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QYParallaxScrollViewCell.h"

@class QYParallaxScrollView;
@protocol QYParallaxScrollViewDataSource <NSObject>
- (NSInteger)numberOfItemsInQYPScrollView:(QYParallaxScrollView *)scrollView;
- (QYParallaxScrollViewCell *)QYPScrollView:(QYParallaxScrollView *)scrollView cellForItemAtIndex:(NSInteger)index;
@end

@protocol QYParallaxScrollViewDelegate <NSObject>
- (void)QYPScrollView:(QYParallaxScrollView *)scrollView didSelectItemAtIndex:(NSInteger)index;
@end

@interface QYParallaxScrollView : UIView

@property (nonatomic, weak) id <QYParallaxScrollViewDelegate> delegate;
@property (nonatomic, weak) id <QYParallaxScrollViewDataSource> dataSource;

@end
