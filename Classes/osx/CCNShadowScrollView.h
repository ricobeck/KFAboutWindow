//
//  Created by Frank Gregor on 11.02.13.
//  Copyright (c) 2013 cocoa:naut. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface CCNShadowScrollView : NSScrollView
@property (assign) BOOL hasTopShadow;
@property (assign) BOOL hasBottomShadow;
@end

typedef NS_ENUM(NSUInteger, CNShadowViewEdge) {
    CNShadowViewEdgeTop = 0,
    CNShadowViewEdgeBottom
};

@interface CNShadowView : NSView
@property (assign, nonatomic) CNShadowViewEdge edge;
@property (retain, nonatomic) NSColor *gradientColor;
@property (assign) BOOL hasTopShadow;
@property (assign) BOOL hasBottomShadow;
@end
