//
//  CNShadowScrollView.m
//  PodLive
//
//  Created by Frank Gregor on 11.02.13.
//  Copyright (c) 2013 cocoa:naut. All rights reserved.
//

#import "CCNShadowScrollView.h"


@interface CCNShadowScrollView () {}
@property (nonatomic, retain) CNShadowView *topShadowView;
@property (nonatomic, retain) CNShadowView *bottomShadowView;
@end

@implementation CCNShadowScrollView

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        _hasTopShadow = YES;
        _hasBottomShadow = YES;
    }
    return self;
}

- (void)tile {
    [super tile];

    NSRect bounds = [self bounds];
    if (!self.topShadowView && self.hasTopShadow) {
        self.topShadowView = [[CNShadowView alloc] init];
        [self addSubview:self.topShadowView positioned:NSWindowAbove relativeTo:[self contentView]];
    }
    if (!self.bottomShadowView && self.hasBottomShadow) {
        self.bottomShadowView = [[CNShadowView alloc] init];
        self.bottomShadowView.edge = CNShadowViewEdgeBottom;
        self.bottomShadowView.gradientColor = [NSColor colorWithCalibratedWhite:0.976 alpha:1.000];
        [self addSubview:self.bottomShadowView positioned:NSWindowAbove relativeTo:[self contentView]];
    }
    self.topShadowView.frame = NSMakeRect(0, 0, NSWidth(bounds), 21);
    self.bottomShadowView.frame = NSMakeRect(0, NSMaxY(bounds) - 21, NSWidth(bounds), 21);

    [self.topShadowView setNeedsDisplay:YES];
    [self.bottomShadowView setNeedsDisplay:YES];
}

@end



@interface CNShadowView () {
    NSArray *_gradientColors;
    NSGradient *_gradient;
}
@property (nonatomic, readonly, retain) NSArray *gradientColors;
@property (nonatomic, readonly, retain) NSGradient *gradient;
@end
@implementation CNShadowView

- (id)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _edge = CNShadowViewEdgeTop;
    _gradientColor = [NSColor colorWithCalibratedWhite:0.976 alpha:1.000];
    _hasTopShadow = YES;
    _hasBottomShadow = YES;
}

- (NSArray *)gradientColors {
    _gradientColors = @[
        [[self gradientColor] colorWithAlphaComponent:1.0],
        [[self gradientColor] colorWithAlphaComponent:0.55],
        [[self gradientColor] colorWithAlphaComponent:0.0]
    ];
    return _gradientColors;
}

- (NSGradient *)gradient {
    _gradient = [[NSGradient alloc] initWithColors:[self gradientColors]];
    return _gradient;
}

- (void)drawRect:(NSRect)rect {
    switch (self.edge) {
        case CNShadowViewEdgeTop: if (self.hasTopShadow) [[self gradient] drawInRect:rect angle:-90]; break;
        case CNShadowViewEdgeBottom: if (self.hasBottomShadow) [[self gradient] drawInRect:rect angle:90]; break;
    }
}

@end
