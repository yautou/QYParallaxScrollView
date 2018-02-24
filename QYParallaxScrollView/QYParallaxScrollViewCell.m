//
//  QYParallaxScrollViewCell.m
//  QYParallaxScrollViewDemo
//
//  Created by Qeye Wang on 22/02/2018.
//  Copyright © 2018 Qeye Wang. All rights reserved.
//

#import "QYParallaxScrollViewCell.h"

@interface QYParallaxScrollViewCell ()
@end

@implementation QYParallaxScrollViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentView.layer.masksToBounds = YES;
        self.contentView.layer.cornerRadius = 10.;
        self.contentView.layer.allowsEdgeAntialiasing = YES;    //!Important
        
        self.backgroundImageView = [UIImageView new];
        self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.backgroundImageView];
        self.backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
        QYLayoutCenter(self.backgroundImageView, self.contentView);
        QYLayoutWidth(self.backgroundImageView, self.contentView, 40);
        QYLayoutHeight(self.backgroundImageView, self.contentView, 40);
        
        self.titleLabel = [UILabel new];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:22.];
        self.titleLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.titleLabel];
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        QYLayoutTop(self.titleLabel, self.contentView, 5);
        QYLayoutLeading(self.titleLabel, self.contentView, 10);
        
        self.descLabel = [UILabel new];
        self.descLabel.font = [UIFont systemFontOfSize:14.];
        self.descLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.descLabel];
        self.descLabel.translatesAutoresizingMaskIntoConstraints = NO;
        QYLayoutBottom(self.descLabel, self.contentView, -5);
        QYLayoutCenterX(self.descLabel, self.contentView, 0);
    }
    return self;
}

- (void)rotateByYVector:(CGFloat)angle {
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1./500;
    self.contentView.layer.transform = CATransform3DRotate(transform, QYDegree(angle), 0, 1, 0);
}

- (void)moveByXVector:(CGFloat)offset {
    for (NSLayoutConstraint *constraint in self.contentView.constraints) {
        if (constraint.firstItem == self.backgroundImageView && constraint.firstAttribute == NSLayoutAttributeCenterX) {
            constraint.constant = offset;
        }
    }
}
@end
