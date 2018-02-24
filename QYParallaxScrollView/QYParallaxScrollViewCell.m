//
//  QYParallaxScrollViewCell.m
//  QYParallaxScrollViewDemo
//
//  Created by Qeye Wang on 22/02/2018.
//  Copyright © 2018 Qeye Wang. All rights reserved.
//

#import "QYParallaxScrollViewCell.h"
#define DEGREE(d)            ((d) * M_PI / 180.0f)

@interface QYParallaxScrollViewCell ()
@property(nonatomic, strong) UIView *viewContainer;
@end

@implementation QYParallaxScrollViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.viewContainer = [UIView new];
        self.viewContainer.layer.masksToBounds = YES;
        self.viewContainer.layer.cornerRadius = 10.;
        self.viewContainer.layer.allowsEdgeAntialiasing = YES;    //!Important
        self.viewContainer.transform = CGAffineTransformMakeRotation(M_PI / 2);
        [self.contentView addSubview:self.viewContainer];
        self.viewContainer.translatesAutoresizingMaskIntoConstraints = NO;
        QYLayoutDiffAttr(self.viewContainer, NSLayoutAttributeWidth, self.contentView, NSLayoutAttributeHeight, -20);
        QYLayoutDiffAttr(self.viewContainer, NSLayoutAttributeHeight, self.contentView, NSLayoutAttributeWidth, -20);
        QYLayoutCenter(self.viewContainer, self.contentView);
        
        self.backgroundImageView = [UIImageView new];
        self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.viewContainer addSubview:self.backgroundImageView];
        self.backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
        QYLayoutCenter(self.backgroundImageView, self.viewContainer);
        QYLayoutWidth(self.backgroundImageView, self.viewContainer, 40);
        QYLayoutHeight(self.backgroundImageView, self.viewContainer, 40);
        
        self.titleLabel = [UILabel new];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:22.];
        self.titleLabel.textColor = [UIColor whiteColor];
        [self.viewContainer addSubview:self.titleLabel];
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        QYLayoutTop(self.titleLabel, self.viewContainer, 5);
        QYLayoutLeading(self.titleLabel, self.viewContainer, 5);
        
        self.descLabel = [UILabel new];
        self.descLabel.font = [UIFont systemFontOfSize:14.];
        self.descLabel.textColor = [UIColor whiteColor];
        [self.viewContainer addSubview:self.descLabel];
        self.descLabel.translatesAutoresizingMaskIntoConstraints = NO;
        QYLayoutBottom(self.descLabel, self.viewContainer, -5);
        QYLayoutCenterX(self.descLabel, self.viewContainer, 0);
    }
    return self;
}

+ (CGFloat)cellHeight {
    return CGRectGetWidth(UIApplication.sharedApplication.keyWindow.bounds) - 40;
}

- (void)rotateByYVector:(CGFloat)angle {
    CATransform3D transform = CATransform3DMakeAffineTransform(CGAffineTransformMakeRotation(M_PI / 2));
    transform.m34 = -1./500;
    self.viewContainer.layer.transform = CATransform3DRotate(transform, DEGREE(angle), 0, 1, 0);
}

- (void)adjustBackgroundImageByXVector:(CGFloat)offset {
    for (NSLayoutConstraint *constraint in self.viewContainer.constraints) {
        if (constraint.firstItem == self.backgroundImageView && constraint.firstAttribute == NSLayoutAttributeCenterX) {
            constraint.constant = offset;
        }
    }
}
@end
