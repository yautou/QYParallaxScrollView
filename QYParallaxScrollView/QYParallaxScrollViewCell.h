//
//  QYParallaxScrollViewCell.h
//  QYParallaxScrollViewDemo
//
//  Created by Qeye Wang on 22/02/2018.
//  Copyright © 2018 Qeye Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QYParallaxScrollViewCell : UITableViewCell

@property(class) CGFloat cellHeight;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIImageView *backgroundImageView;
@property(nonatomic, strong) UILabel *descLabel;

/**
 10 --- 0 --- -10
 */
- (void)rotateByYVector:(CGFloat)angle;

@end
