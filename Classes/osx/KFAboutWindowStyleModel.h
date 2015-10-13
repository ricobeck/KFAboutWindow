//
//  KFAboutWindowStyleModel.h
//  KFAboutWindowPreview
//
//  Created by rick on 07/03/14.
//  Copyright (c) 2014 KF Interactive. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface KFAboutWindowStyleModel : NSObject

@property (nonatomic, strong) NSColor *backgroundColor;
@property (nonatomic, strong) NSColor *backgroundSeparatorColor;
@property (nonatomic, strong) NSImage *backgroundImage;
@property (nonatomic, strong) NSColor *bundleNameLabelColor;
@property (nonatomic, strong) NSColor *versionLabelColor;
@property (nonatomic, strong) NSColor *humanReadableCopyrightLabelColor;
@property (nonatomic, strong) NSColor *acknowledgementsTextColor;

@property (nonatomic, strong) NSFont *bundleNameLabelFont;
@property (nonatomic, strong) NSFont *versionLabelFont;
@property (nonatomic, strong) NSFont *humanReadableCopyrightLabelFont;

+ (KFAboutWindowStyleModel *)defaultStyle;

@end
