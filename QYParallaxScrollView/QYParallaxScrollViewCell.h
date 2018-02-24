//
//  QYParallaxScrollViewCell.h
//  QYParallaxScrollViewDemo
//
//  Created by Qeye Wang on 22/02/2018.
//  Copyright © 2018 Qeye Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QYParallaxScrollViewDefines.h"

@interface QYParallaxScrollViewCell : UITableViewCell

@property(readonly, class) CGFloat cellHeight;

@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIImageView *backgroundImageView;
@property(nonatomic, strong) UILabel *descLabel;

- (void)rotateByYVector:(CGFloat)angle;

- (void)adjustBackgroundImageByXVector:(CGFloat)offset;

@end
