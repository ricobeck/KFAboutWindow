//
//  KFAutoScrollTextView.m
//  KFAboutWindowPreview
//
//  Created by rick on 06/03/14.
//  Copyright (c) 2014 KF Interactive. All rights reserved.
//

#import "KFAutoScrollTextView.h"

@interface KFAutoScrollTextView ()

@property (nonatomic, strong) NSTimer *scrollTimer;

@property (nonatomic) CGFloat lineScroll;

@property (nonatomic) CGFloat pageScroll;

@property (nonatomic) BOOL hadVerticalScroller;

@property (nonatomic) CGFloat currentScrollPosition;

@property (nonatomic) CGFloat maxScrollPosition;

@end


@implementation KFAutoScrollTextView


- (void)scrollWheel:(NSEvent *)theEvent
{
    if ([self isScrolling])
    {
        [self stopScrolling];
    }
    [super scrollWheel:theEvent];
}


- (void)mouseEntered:(NSEvent *)theEvent
{
    if ([self isScrolling])
    {
        [self stopScrolling];
    }
    [super mouseEntered:theEvent];
}


- (void)mouseExited:(NSEvent *)theEvent
{
    if (![self isScrolling] && self.isAutoScrolling)
    {
        [self performSelector:@selector(startScrolling) withObject:nil afterDelay:2.0];
    }
    [super mouseExited:theEvent];
}


- (void)startScrolling
{
    if (![self isScrolling])
    {
        NSScrollView *scrollView = [self enclosingScrollView];
        self.lineScroll = [scrollView lineScroll];
        self.pageScroll = [scrollView pageScroll];
        self.hadVerticalScroller = [scrollView hasVerticalScroller];
        
        [scrollView setHasVerticalScroller:NO];
        [scrollView setLineScroll:0.0f];
        [scrollView setPageScroll:0.0f];
        
        self.currentScrollPosition = [[scrollView contentView] bounds].origin.y;
        self.maxScrollPosition = [[self textStorage] size].height;
        self.scrollTimer = [NSTimer scheduledTimerWithTimeInterval:(1.0f / 30) target:self selector:@selector(updateScrollPosition:) userInfo:nil repeats:YES];
    }
}


- (void)stopScrolling
{
    if ([self isScrolling])
    {
        [self.scrollTimer invalidate];
        self.scrollTimer = nil;
        
        NSScrollView *scrollView = [self enclosingScrollView];
        [scrollView setHasVerticalScroller:self.hadVerticalScroller];
        [scrollView setLineScroll:self.lineScroll];
        [scrollView setPageScroll:self.pageScroll];
    }
}


- (void)updateScrollPosition:(NSTimer *)timer
{
    self.currentScrollPosition++;
    if (self.currentScrollPosition > self.maxScrollPosition || self.currentScrollPosition < 0)
    {
		self.currentScrollPosition = 0;
    }
    
    [self scrollPoint:NSMakePoint(0, self.currentScrollPosition)];
}


- (BOOL)isScrolling
{
    return self.scrollTimer != nil && [self.scrollTimer isValid];
}


- (void)setAutoScrolling:(BOOL)autoScrolling
{
    _autoScrolling = autoScrolling;
    if (!_autoScrolling)
    {
        [self stopScrolling];
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startScrolling) object:nil];
    }
}


@end
