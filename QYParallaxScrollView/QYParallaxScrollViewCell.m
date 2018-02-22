//
//  QYParallaxScrollViewCell.m
//  QYParallaxScrollViewDemo
//
//  Created by Qeye Wang on 22/02/2018.
//  Copyright © 2018 Qeye Wang. All rights reserved.
//

#import "QYParallaxScrollViewCell.h"

@implementation QYParallaxScrollViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor orangeColor];
        self.contentView.transform = CGAffineTransformMakeRotation(M_PI / 2);
    }
    return self;
}

@end
