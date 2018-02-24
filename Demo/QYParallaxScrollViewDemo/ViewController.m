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
@property (weak, nonatomic) IBOutlet QYParallaxScrollView *parallaxScrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _parallaxScrollView.delegate = self;
    _parallaxScrollView.dataSource = self;
    [_parallaxScrollView reloadData];
}

- (IBAction)sliderValueChanged:(UISlider *)slider {
    switch (slider.tag) {
        case 1:_parallaxScrollView.cellsGap = slider.value;         break;
        case 2:_parallaxScrollView.movementOffset = slider.value;   break;
        case 3:_parallaxScrollView.rotationAngle = slider.value;    break;
        default:break;
    }
    [_parallaxScrollView reloadData];
}

#pragma mark QYParallaxScrollViewDataSource
- (NSInteger)numberOfItemsInQYPScrollView:(QYParallaxScrollView *)scrollView {
    return 5;
}

- (QYParallaxScrollViewCell *)QYPScrollView:(QYParallaxScrollView *)scrollView cellForItemAtIndex:(NSInteger)index {
    QYParallaxScrollViewCell *cell = [scrollView dequeueCellWithReuseIdentifier:QYParallaxCellIdentifier forIndex:index];
    cell.titleLabel.text = [NSString stringWithFormat:@"This is title %ld", (long)index];
    cell.descLabel.text = [NSString stringWithFormat:@"This is description %ld", (long)index];
    cell.backgroundImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld", index+1]];
    return cell;
}

#pragma mark QYParallaxScrollViewDelegate
- (CGSize)QYPScrollView:(QYParallaxScrollView *)scrollView sizeForItemAtIndex:(NSInteger)index {
    return CGSizeMake(CGRectGetWidth(UIApplication.sharedApplication.keyWindow.bounds)-40, 180);
}

- (void)QYPScrollView:(QYParallaxScrollView *)scrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"%s --- %ld", __FUNCTION__, (long)index);
    [scrollView scrollToIndex:index];
}

@end
