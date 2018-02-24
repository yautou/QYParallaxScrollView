//
//  QYParallaxScrollViewDefines.h
//  QYParallaxScrollViewDemo
//
//  Created by Qeye Wang on 24/02/2018.
//  Copyright © 2018 Qeye Wang. All rights reserved.
//

#ifndef QYParallaxScrollViewDefines_h
#define QYParallaxScrollViewDefines_h

/*        AutoLayout        */
#define QYLayoutDeactivate(item)     [NSLayoutConstraint deactivateConstraints:item.constraints];

#define QYLayout(item1, attr1, relation, item2, attr2, m, c)  \
        [NSLayoutConstraint constraintWithItem:item1 \
                                     attribute:attr1 \
                                     relatedBy:relation \
                                        toItem:item2 \
                                     attribute:item2 ? attr2 : NSLayoutAttributeNotAnAttribute \
                                    multiplier:m \
                                      constant:c].active = YES;

#define QYLayoutSameAttr(item1, item2, attr, c)                QYLayout(item1, attr, NSLayoutRelationEqual, item2, attr, 1, c)
#define QYLayoutDiffAttr(item1, attr1, item2, attr2, c)        QYLayout(item1, attr1, NSLayoutRelationEqual, item2, attr2, 1, c)

#define QYLayoutTop(item1, item2, c)           QYLayoutSameAttr(item1, item2, NSLayoutAttributeTop, c)
#define QYLayoutBottom(item1, item2, c)        QYLayoutSameAttr(item1, item2, NSLayoutAttributeBottom, c)
#define QYLayoutLeading(item1, item2, c)       QYLayoutSameAttr(item1, item2, NSLayoutAttributeLeading, c)
#define QYLayoutTrailing(item1, item2, c)      QYLayoutSameAttr(item1, item2, NSLayoutAttributeTrailing, c)
#define QYLayoutCenterX(item1, item2, c)       QYLayoutSameAttr(item1, item2, NSLayoutAttributeCenterX, c)
#define QYLayoutCenterY(item1, item2, c)       QYLayoutSameAttr(item1, item2, NSLayoutAttributeCenterY, c)
#define QYLayoutWidth(item1, item2, c)         QYLayoutSameAttr(item1, item2, NSLayoutAttributeWidth, c)
#define QYLayoutHeight(item1, item2, c)        QYLayoutSameAttr(item1, item2, NSLayoutAttributeHeight, c)

#define QYLayoutCenter(item1, item2)           QYLayoutCenterX(item1, item2, 0)  \
                                               QYLayoutCenterY(item1, item2, 0)

#define QYLayoutSize(item1, item2)             QYLayoutWidth(item1, item2, 0) \
                                               QYLayoutHeight(item1, item2, 0)

/*        Others        */
#define QYDegree(d)         ((d) * M_PI / 180.0f)
static CGFloat QYParallaxCellWidth = 150;
static NSString * QYParallaxCellIdentifier = @"QYParallaxCell";

#endif /* QYParallaxScrollViewDefines_h */
