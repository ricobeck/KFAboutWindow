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
#import "KFGradientScrollView.h"

#import <QuartzCore/QuartzCore.h>


typedef NS_ENUM(NSUInteger, KFAboutDisplayMode) {
    KFAboutDisplayModeCredits,
    KFAboutDisplayModeAcknowledgements
};

static const unsigned short KFEscapeKeyCode = 53;


@interface KFAboutWindowController ()
@property (weak, nonatomic) IBOutlet NSView *backgroundView;
@property (strong) CALayer *backgroundViewSeparator;
@property (weak, nonatomic) IBOutlet NSImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet NSImageView *appIconImageView;
@property (weak, nonatomic) IBOutlet NSTextField *bundleNameLabel;
@property (weak, nonatomic) IBOutlet NSTextField *versionLabel;
@property (weak, nonatomic) IBOutlet NSTextField *humanReadableCopyrightLabel;

@property (weak) IBOutlet KFGradientScrollView *scrollView;
@property (unsafe_unretained) IBOutlet KFAutoScrollTextView *scrollTextView;

@property (weak) IBOutlet NSButton *toggleDisplayButton;
@property (weak) IBOutlet NSButton *visitWebsiteButton;

@property (nonatomic, copy) NSAttributedString *attributedString;
@property (nonatomic) KFAboutDisplayMode displayMode;
@property (nonatomic, copy) NSString *toggleButtonText;
@property (nonatomic) NSNumber *disabledOption;
@property (nonatomic) NSNumber *canToggleScroll;

@property (strong) id eventMonitor;

@end



@implementation KFAboutWindowController


+ (NSString *)nibName { return @"KFAboutWindow"; }

- (id)init {
    self = [super initWithWindowNibName:[[self class] nibName]];
    if (self) {
        [self.window setTitle:@""];
        _disabledOption = @NO;

        [self setupEventMonitor];
    }
    return self;
}


- (void)windowDidLoad
{
    [super windowDidLoad];

    [self.backgroundView setWantsLayer:YES];

    self.backgroundViewSeparator = [CALayer layer];
    self.backgroundViewSeparator.borderWidth = 1;
    CGRect borderRect = CGRectInset(self.backgroundView.layer.bounds, -2, -1);
    borderRect.origin.y += 1;
    self.backgroundViewSeparator.frame = borderRect;
    [self.backgroundView.layer addSublayer:self.backgroundViewSeparator];

    NSTextContainer *container = [self.scrollTextView textContainer];
    [container setLineFragmentPadding:0];
    
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    
    self.bundleName             = info[@"CFBundleName"];
    self.bundleShortVersion     = info[@"CFBundleShortVersionString"];
    self.bundleVersion          = info[@"CFBundleVersion"];
    self.humanReadableCopyright = info[@"NSHumanReadableCopyright"];
    
    NSURL *creditsURL = [[NSBundle mainBundle] URLForResource:@"Credits" withExtension:@"rtf"];
    
    if (creditsURL != nil)
    {
        self.credits = [[NSAttributedString alloc] initWithURL:creditsURL options:[NSDictionary new] documentAttributes:nil error:nil];
    }
   
    NSString *acknowledgementsPath = [[NSBundle mainBundle] pathForResource:@"Acknowledgements" ofType:@"plist"];
    if (acknowledgementsPath != nil)
    {
        self.acknowledgements = [NSAttributedString attributedStringWithCocoaPodsAcknowledgementsAtPath:acknowledgementsPath];
    }
    
    [[self.toggleDisplayButton superview] setNeedsUpdateConstraints:YES];
    
    self.displayMode = KFAboutDisplayModeCredits;
    [self updateModeValues];

    KFAboutWindowStyleModel *defaultStyle = [KFAboutWindowStyleModel defaultStyle];
    [self applyStyle:defaultStyle];
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
    self.backgroundView.layer.backgroundColor = [backgroundColor CGColor];
    self.scrollTextView.backgroundColor = backgroundColor;
    self.scrollView.gradientColor = backgroundColor;
}

- (void)setBackgroundSeparatorColor:(NSColor *)separatorColor {
    self.backgroundViewSeparator.borderColor = separatorColor.CGColor;
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
    if (styleModel.backgroundSeparatorColor)
    {
        [self setBackgroundSeparatorColor:styleModel.backgroundSeparatorColor];
    }
    if (styleModel.bundleNameLabelColor != nil)
    {
        [self.bundleNameLabel setTextColor:styleModel.bundleNameLabelColor];
    }
    if (styleModel.versionLabelColor != nil)
    {
        [self.versionLabel setTextColor:styleModel.versionLabelColor];
    }
    if (styleModel.acknowledgementsTextColor != nil)
    {
        NSMutableAttributedString *styledAcknowledgements = [self.acknowledgements mutableCopy];
        [styledAcknowledgements setAttributes:@{NSForegroundColorAttributeName:styleModel.acknowledgementsTextColor} range:NSMakeRange(0, [self.acknowledgements length])];
        self.acknowledgements = [styledAcknowledgements copy];
    }
    if (styleModel.humanReadableCopyrightLabelColor != nil)
    {
        [self.humanReadableCopyrightLabel setTextColor:styleModel.humanReadableCopyrightLabelColor];
    }
    if (styleModel.bundleNameLabelFont) {
        self.bundleNameLabel.font = styleModel.bundleNameLabelFont;
    }
    if (styleModel.versionLabelFont) {
        self.versionLabel.font = styleModel.versionLabelFont;
    }
    if (styleModel.humanReadableCopyrightLabelFont) {
        self.humanReadableCopyrightLabel.font = styleModel.humanReadableCopyrightLabelFont;
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

#pragma mark - Keystroke Handling

- (void)setupEventMonitor {
    __weak typeof(self) wSelf = self;
    self.eventMonitor = [NSEvent addLocalMonitorForEventsMatchingMask:NSKeyDownMask handler:^NSEvent *(NSEvent *event) {
        if (event.keyCode == KFEscapeKeyCode) {
            [wSelf.window performClose:wSelf];
            return nil;
        }
        return event;
    }];
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
