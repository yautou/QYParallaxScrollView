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
@required
- (NSInteger)numberOfItemsInQYPScrollView:(QYParallaxScrollView *)scrollView;
- (QYParallaxScrollViewCell *)QYPScrollView:(QYParallaxScrollView *)scrollView cellForItemAtIndex:(NSInteger)index;
@end

@protocol QYParallaxScrollViewDelegate <NSObject>
- (CGSize)QYPScrollView:(QYParallaxScrollView *)scrollView sizeForItemAtIndex:(NSInteger)index;
- (void)QYPScrollView:(QYParallaxScrollView *)scrollView didSelectItemAtIndex:(NSInteger)index;
@end

@interface QYParallaxScrollView : UIView

@property (nonatomic, assign) CGFloat cellsGap;
@property (nonatomic, assign) CGFloat movementOffset;//0 = disable movement; suggest 20
@property (nonatomic, assign) CGFloat rotationAngle;//0 = disable rotation; suggest 10

@property (nonatomic, weak) id <QYParallaxScrollViewDelegate> delegate;
@property (nonatomic, weak) id <QYParallaxScrollViewDataSource> dataSource;

- (QYParallaxScrollViewCell *)dequeueCellWithReuseIdentifier:(NSString *)identifier forIndex:(NSInteger)index;
- (void)scrollToIndex:(NSInteger)index;

@end
