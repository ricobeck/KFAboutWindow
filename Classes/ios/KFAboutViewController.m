//
//  KFAboutViewController.m
//  AboutScreenDemo
//
//  Created by Gunnar Herzog on 21/03/14.
//  Copyright (c) 2014 KF Interactive. All rights reserved.
//

#import "KFAboutViewController.h"
#import "NSAttributedString+CocoaPods.h"

@interface KFAboutViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) UIImageView *titleImageView;

@property (strong, nonatomic) UIView *titleView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewWidthConstraint;

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end


@implementation KFAboutViewController




- (void)viewDidLoad
{
    [super viewDidLoad];

    self.imageView.image = [UIImage imageNamed: [[[[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIcons"] objectForKey:@"CFBundlePrimaryIcon"] objectForKey:@"CFBundleIconFiles"] firstObject]];
    self.titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.imageViewWidthConstraint.constant, self.imageViewWidthConstraint.constant)];
    self.titleImageView.image = self.imageView.image;

    self.titleView = [UIView new];
    self.titleView.layer.masksToBounds = YES;
    [self.titleView addSubview:self.titleImageView];

    self.navigationItem.titleView = self.titleView;
    
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    
    self.bundleName = info[@"CFBundleName"];
    self.bundleShortVersion = info[@"CFBundleShortVersionString"];
    self.bundleVersion = info[@"CFBundleVersion"];
    self.humanReadableCopyright = info[@"NSHumanReadableCopyright"];
    
    NSURL *creditsURL = [[NSBundle mainBundle] URLForResource:@"Credits" withExtension:@"rtf"];
    self.credits = [[NSAttributedString alloc] initWithFileURL:creditsURL options:nil documentAttributes:nil error:nil];
    
    NSString *acknowledgementsPath = [[NSBundle mainBundle] pathForResource:@"Acknowledgements" ofType:@"plist"];
    self.acknowledgements = [NSAttributedString attributedStringWithCocoaPodsAcknowledgementsAtPath:acknowledgementsPath];
    self.textView.attributedText = self.acknowledgements;
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.titleView.frame = CGRectMake(0, 0, 320, 44);

    self.titleImageView.frame = CGRectMake(110, 64, self.imageViewWidthConstraint.constant, self.imageViewWidthConstraint.constant);
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat a = scrollView.contentOffset.y;
    CGFloat a0 = -64;
    CGFloat a1 = 5;
    CGFloat b0 = 100;
    CGFloat b1 = 34;

    CGFloat b = ((a - a0) * (b1 - b0)) / (a1 - a0) + b0;
    b = MAX(MIN(b, b0), b1);
    self.imageViewWidthConstraint.constant = b;

    CGFloat x = (CGRectGetWidth([UIScreen mainScreen].applicationFrame) - b) / 2.0;
    x = floor([self.titleView convertPoint:CGPointMake(x, 0) fromView:nil].x) - .5;
    self.titleImageView.frame = CGRectMake(x, MAX(a1, -a), b, b);
}


@end
