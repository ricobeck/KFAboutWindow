//
//  Created by Frank Gregor on 20/10/14.
//  Copyright (c) 2014 cocoa:naut. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface KFGradientScrollView : NSScrollView
@property (assign, nonatomic) BOOL hasTopGradient;
@property (assign, nonatomic) BOOL hasBottomGradient;
@property (assign) CGFloat gradientHeight;

- (void)showGradients;
- (void)dismissGradients;

@end

typedef NS_ENUM(NSUInteger, KFGradientViewEdge) {
    KFGradientViewEdgeTop = 0,
    KFGradientViewEdgeBottom
};

@interface KFGradientView : NSView
@property (assign, nonatomic) KFGradientViewEdge edge;
@property (retain, nonatomic) NSColor *gradientColor;
@property (assign) BOOL hasTopGradient;
@property (assign) BOOL hasBottomGradient;
@end
