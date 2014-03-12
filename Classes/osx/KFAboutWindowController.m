//
//  KFAboutWindowController.m
//  KFAboutWindowPreview
//
//  Created by rick on 05/03/14.
//  Copyright (c) 2014 KF Interactive. All rights reserved.
//

#import "KFAboutWindowController.h"
#import "NSAttributedString+CocoaPods.h"
#import "KFAutoScrollTextView.h"
#import "KFAboutWindowStyleModel.h"

#import <QuartzCore/QuartzCore.h>


typedef NS_ENUM(NSUInteger, KFAboutDisplayMode)
{
    KFAboutDisplayModeCredits,
    KFAboutDisplayModeAcknowledgements
};


@interface KFAboutWindowController ()

@property (weak) IBOutlet NSView *topContentView;

@property (weak) IBOutlet NSImageView *backgroundImageView;

@property (weak) IBOutlet NSImageView *appIconImageView;

@property (weak) IBOutlet NSTextField *bundleNameLabel;

@property (weak) IBOutlet NSTextField *versionLabel;

@property (weak) IBOutlet NSTextField *humanReadableCopyrightLabel;


@property (unsafe_unretained) IBOutlet KFAutoScrollTextView *scrollTextView;

@property (weak) IBOutlet NSButton *toggleDisplayButton;

@property (weak) IBOutlet NSButton *visitWebsiteButton;


@property (nonatomic, copy) NSAttributedString *attributedString;

@property (nonatomic) KFAboutDisplayMode displayMode;

@property (nonatomic, copy) NSString *toggleButtonText;

@property (nonatomic) NSNumber *disabledOption;

@property (nonatomic) NSNumber *canToggleScroll;

@end



@implementation KFAboutWindowController


+ (NSString *)nibName
{
    return @"KFAboutWindow";
}


- (id)init
{
    self = [super initWithWindowNibName:[[self class] nibName]];
    if (self)
    {
        [self.window setTitle:@""];
        _disabledOption = @NO;
    }
    return self;
}


- (void)windowDidLoad
{
    [super windowDidLoad];
    
    [self.topContentView setWantsLayer:YES];
    self.topContentView.layer.backgroundColor = [[NSColor whiteColor] CGColor];
    
    CALayer *borderLayer = [CALayer layer];
    borderLayer.borderColor = [NSColor disabledControlTextColor].CGColor;
    borderLayer.borderWidth = 1;
    CGRect borderRect = CGRectInset(self.topContentView.layer.bounds, -2, -1);
    borderRect.origin.y += 1;
    borderLayer.frame = borderRect;
    [self.topContentView.layer addSublayer:borderLayer];
    
    NSTextContainer *container = [self.scrollTextView textContainer];
    [container setLineFragmentPadding:0];
    
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    
    self.bundleName = info[@"CFBundleName"];
    self.bundleShortVersion = info[@"CFBundleShortVersionString"];
    self.bundleVersion = info[@"CFBundleVersion"];
    self.humanReadableCopyright = info[@"NSHumanReadableCopyright"];
    
    NSString *creditsPath = [[NSBundle mainBundle] pathForResource:@"Credits" ofType:@"rtf"];
    
    if (creditsPath != nil)
    {
        self.credits = [[NSAttributedString alloc] initWithPath:creditsPath documentAttributes:nil];
    }
   
    NSString *acknowledgementsPath = [[NSBundle mainBundle] pathForResource:@"Acknowledgements" ofType:@"plist"];
    if (acknowledgementsPath != nil)
    {
        self.acknowledgements = [NSAttributedString attributedStringWithCocoaPodsAcknowledgementsAtPath:acknowledgementsPath];
    }
    
    [[self.toggleDisplayButton superview] setNeedsUpdateConstraints:YES];
    
    self.displayMode = KFAboutDisplayModeCredits;
    [self updateModeValues];
}


- (void)updateModeValues
{
    if (self.displayMode == KFAboutDisplayModeCredits)
    {
        self.attributedString = self.credits;
        self.toggleButtonText = NSLocalizedString(@"Acknowledgements", nil);
        self.scrollTextView.autoScrolling = NO;
    }
    else
    {
        self.scrollTextView.autoScrolling = YES;
        [NSObject cancelPreviousPerformRequestsWithTarget:self.scrollTextView selector:@selector(startScrolling) object:nil];
        [self.scrollTextView performSelector:@selector(startScrolling) withObject:nil afterDelay:5.0];
        
        self.attributedString = self.acknowledgements;
        self.toggleButtonText = NSLocalizedString(@"Credits", nil);
    }
}


#pragma mark - Customizing


- (void)setBackgroundImage:(NSImage *)backgroundImage
{
    self.backgroundImageView.image = backgroundImage;
}


- (void)setBackgroundColor:(NSColor *)backgroundColor
{
    self.topContentView.layer.backgroundColor = [backgroundColor CGColor];
    self.scrollTextView.backgroundColor = backgroundColor;
}


- (void)applyStyle:(KFAboutWindowStyleModel *)styleModel
{
    if (styleModel.backgroundImage != nil)
    {
        [self setBackgroundImage:styleModel.backgroundImage];
    }
    if (styleModel.backgroundColor != nil)
    {
        [self setBackgroundColor:styleModel.backgroundColor];
    }
    if (styleModel.bundleNameColor != nil)
    {
        [self.bundleNameLabel setTextColor:styleModel.bundleNameColor];
    }
    if (styleModel.versionColor != nil)
    {
        [self.versionLabel setTextColor:styleModel.versionColor];
    }
    if (styleModel.acknowlegdementsTextColor != nil)
    {
        NSMutableAttributedString *styledAcknowledgements = [self.acknowledgements mutableCopy];
        [styledAcknowledgements setAttributes:@{NSForegroundColorAttributeName:styleModel.acknowlegdementsTextColor} range:NSMakeRange(0, [self.acknowledgements length])];
        self.acknowledgements = [styledAcknowledgements copy];
    }
    if (styleModel.humanReadableCopyrightsColor != nil)
    {
        [self.humanReadableCopyrightLabel setTextColor:styleModel.humanReadableCopyrightsColor];
    }
    
}

#pragma mark - Window show/hide


- (void)showWindow:(id)sender
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self.scrollTextView selector:@selector(startScrolling) object:nil];
    NSImage *appIconImage = [NSApp applicationIconImage];
    [appIconImage setSize:NSMakeSize(128.0, 128.0)];
    [self.appIconImageView setImage:appIconImage];
    
    [self updateModeValues];
    
    [self addObservers];
    [super showWindow:sender];
    
}


- (void)addObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowDidResignKeyOrMainNotification:) name:NSWindowDidResignKeyNotification object:self.window];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowDidResignKeyOrMainNotification:) name:NSWindowDidResignMainNotification object:self.window];
}


- (void)windowDidResignKeyOrMainNotification:(NSNotification *)notification
{
    [self removeObservers];
    [self.window setIsVisible:NO];
    [self.scrollTextView stopScrolling];
    
    self.displayMode = KFAboutDisplayModeCredits;
    [self updateModeValues];
}


- (void)removeObservers
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSWindowDidResignKeyNotification object:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSWindowDidResignMainNotification object:self];
}


#pragma mark - Actions


- (IBAction)visitWebsiteAction:(id)sender
{
    if (self.websiteURL != nil)
    {
        [[NSWorkspace sharedWorkspace] openURL:self.websiteURL];
    }
}


- (IBAction)toggleScrollTextContent:(id)sender
{
    [self.scrollTextView stopScrolling];
    [self.scrollTextView scrollPoint:NSMakePoint(0.0, 0.0)];
    
    self.displayMode = self.displayMode == KFAboutDisplayModeCredits ? KFAboutDisplayModeAcknowledgements : KFAboutDisplayModeCredits;
    [self updateModeValues];
}


@end
