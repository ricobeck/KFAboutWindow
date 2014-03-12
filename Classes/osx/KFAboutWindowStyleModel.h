//
//  KFAboutWindowStyleModel.h
//  KFAboutWindowPreview
//
//  Created by rick on 07/03/14.
//  Copyright (c) 2014 KF Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KFAboutWindowStyleModel : NSObject


@property (nonatomic, strong) NSColor *backgroundColor;

@property (nonatomic, strong) NSImage *backgroundImage;

@property (nonatomic, strong) NSColor *bundleNameColor;

@property (nonatomic, strong) NSColor *versionColor;

@property (nonatomic, strong) NSColor *acknowlegdementsTextColor;

@property (nonatomic, strong) NSColor *humanReadableCopyrightsColor;


@end
