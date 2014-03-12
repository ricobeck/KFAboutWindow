//
//  KFAboutWindowController.h
//  KFAboutWindowPreview
//
//  Created by rick on 05/03/14.
//  Copyright (c) 2014 KF Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>


@class KFAboutWindowStyleModel;


@interface KFAboutWindowController : NSWindowController


@property (nonatomic, copy) NSURL *websiteURL;


@property (nonatomic, copy) NSString *bundleName;

@property (nonatomic, copy) NSString *humanReadableCopyright;

@property (nonatomic, copy) NSString *bundleShortVersion;

@property (nonatomic, copy) NSString *bundleVersion;

@property (nonatomic, copy) NSAttributedString *credits;

@property (nonatomic, copy) NSAttributedString *acknowledgements;


- (void)setBackgroundImage:(NSImage *)backgroundImage;

- (void)setBackgroundColor:(NSColor *)backgroundColor;

- (void)applyStyle:(KFAboutWindowStyleModel *)styleModel;


@end
 