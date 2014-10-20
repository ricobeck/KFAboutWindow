//
//  Created by Frank Gregor on 20/10/14.
//  Copyright (c) 2014 cocoa:naut. All rights reserved.
//

#import "KFGradientScrollView.h"

static const CGFloat kKFShadowHeightDefaultValue = 23.0;

@interface KFGradientScrollView () {}
@property (strong, nonatomic) KFGradientView *topShadowView;
@property (strong, nonatomic) KFGradientView *bottomShadowView;
@end

@implementation KFGradientScrollView

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.hasTopGradient    = YES;
        self.hasBottomGradient = YES;
        self.gradientHeight    = kKFShadowHeightDefaultValue;
    }
    return self;
}

- (void)tile {
    [super tile];

    NSRect bounds = self.bounds;
    self.topShadowView.frame    = NSMakeRect(0, 0, NSWidth(bounds), self.gradientHeight);
    self.bottomShadowView.frame = NSMakeRect(0, NSMaxY(bounds) - self.gradientHeight, NSWidth(bounds), self.gradientHeight);

    [self.topShadowView setNeedsDisplay:YES];
    [self.bottomShadowView setNeedsDisplay:YES];
}

#pragma mark - Custom Accessors

- (void)setHasTopGradient:(BOOL)hasTopShadow {
    _hasTopGradient = hasTopShadow;
    if (_hasTopGradient) {
        if (!self.bottomShadowView) {
            self.topShadowView = [[KFGradientView alloc] init];
            [self addSubview:self.topShadowView positioned:NSWindowAbove relativeTo:self.contentView];
        }
        self.topShadowView.alphaValue = 0.0;
        self.topShadowView.hidden = YES;
    }
    else {

    }
}

- (void)setHasBottomGradient:(BOOL)hasBottomShadow {
    _hasBottomGradient = hasBottomShadow;
    if (_hasTopGradient) {
        if (!self.bottomShadowView) {
            self.bottomShadowView = [[KFGradientView alloc] init];
            self.bottomShadowView.edge = KFGradientViewEdgeBottom;
            [self addSubview:self.bottomShadowView positioned:NSWindowAbove relativeTo:self.contentView];
        }
        self.bottomShadowView.alphaValue = 0.0;
        self.bottomShadowView.hidden = YES;
    }
    else {

    }
}

- (void)showGradients {
    self.topShadowView.hidden = NO;
    self.bottomShadowView.hidden = NO;

    __weak typeof(self) wSelf = self;
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        [context setDuration:0.25];
        [[wSelf.topShadowView animator] setAlphaValue:1.0];
        [[wSelf.bottomShadowView animator] setAlphaValue:1.0];

    } completionHandler:nil];
}

- (void)dismissGradients {
    __weak typeof(self) wSelf = self;
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        [context setDuration:0.25];
        [[wSelf.topShadowView animator] setAlphaValue:0.0];
        [[wSelf.bottomShadowView animator] setAlphaValue:0.0];

    } completionHandler:^{
        wSelf.topShadowView.hidden = YES;
        wSelf.bottomShadowView.hidden = YES;
    }];
}

@end



@interface KFGradientView ()
@property (strong, nonatomic) NSArray *gradientColors;
@property (strong, nonatomic) NSGradient *gradient;
@end

@implementation KFGradientView

- (id)init {
    self = [super init];
    if (self) {
        [self setupDefaults];
    }
    return self;
}

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDefaults];
    }
    return self;
}

- (void)setupDefaults {
    self.edge            = KFGradientViewEdgeTop;
    self.gradientColor   = [NSColor whiteColor];
    self.hasTopGradient    = YES;
    self.hasBottomGradient = YES;
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
        case KFGradientViewEdgeTop: if (self.hasTopGradient) [[self gradient] drawInRect:rect angle:-90]; break;
        case KFGradientViewEdgeBottom: if (self.hasBottomGradient) [[self gradient] drawInRect:rect angle:90]; break;
    }
}

@end
