//
//  QYParallaxScrollViewCell.m
//  QYParallaxScrollViewDemo
//
//  Created by Qeye Wang on 22/02/2018.
//  Copyright © 2018 Qeye Wang. All rights reserved.
//

#import "QYParallaxScrollViewCell.h"
#define DEGREE(d)            ((d) * M_PI / 180.0f)

@implementation QYParallaxScrollViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.contentView.layer.allowsEdgeAntialiasing = YES;    //!Important
        self.contentView.layer.masksToBounds = YES;
        self.contentView.layer.cornerRadius = 10.;
        self.contentView.backgroundColor = [UIColor orangeColor];
        self.contentView.transform = CGAffineTransformMakeRotation(M_PI / 2);
        
        [NSLayoutConstraint deactivateConstraints:self.contentView.constraints];
        self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
        QYLayoutDiffAttr(self.contentView, NSLayoutAttributeWidth, self, NSLayoutAttributeHeight, -20);
        QYLayoutDiffAttr(self.contentView, NSLayoutAttributeHeight, self, NSLayoutAttributeWidth, -20);
        QYLayoutCenterX(self.contentView, self, 0);
        QYLayoutCenterY(self.contentView, self, 0);
        
        self.titleLabel = [UILabel new];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:22.];
        self.titleLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.titleLabel];
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        QYLayoutTop(self.titleLabel, self.contentView, 5);
        QYLayoutLeading(self.titleLabel, self.contentView, 5);
        
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

- (void)updateWithOffset:(CGFloat)offset {
    NSLog(@"%@ - %f", self.titleLabel.text, offset);
    
    CATransform3D transform = CATransform3DMakeAffineTransform(CGAffineTransformMakeRotation(M_PI / 2));
    transform.m34 = -1./500;
    self.contentView.layer.transform = CATransform3DRotate(transform, DEGREE(-10), 0, 1, 0);
}
@end
