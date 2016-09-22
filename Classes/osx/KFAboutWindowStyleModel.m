//
//  KFAboutWindowStyleModel.m
//  KFAboutWindowPreview
//
//  Created by rick on 07/03/14.
//  Copyright (c) 2014 KF Interactive. All rights reserved.
//

#import "KFAboutWindowStyleModel.h"


@implementation KFAboutWindowStyleModel

+ (KFAboutWindowStyleModel *)defaultStyle {
    KFAboutWindowStyleModel *defaultStyle = [[KFAboutWindowStyleModel alloc] init];

    // content background
    defaultStyle.backgroundColor                  = [NSColor whiteColor];
    defaultStyle.backgroundSeparatorColor         = [NSColor gridColor];
    defaultStyle.backgroundImage                  = nil;

    // text labels
    defaultStyle.bundleNameLabelColor             = [NSColor controlTextColor];
    defaultStyle.versionLabelColor                = [NSColor disabledControlTextColor];
    defaultStyle.humanReadableCopyrightLabelColor = [NSColor disabledControlTextColor];

    // scrolling textView
    defaultStyle.acknowledgementsTextColor        = [NSColor textColor];

    // fonts
    defaultStyle.bundleNameLabelFont              = [NSFont boldSystemFontOfSize:22.0];
    defaultStyle.versionLabelFont                 = [NSFont boldSystemFontOfSize:11.0];
    defaultStyle.humanReadableCopyrightLabelFont  = [NSFont systemFontOfSize:11.0];

    defaultStyle.visitWebsiteButtonColor          = [NSColor blackColor];
    defaultStyle.toggleDisplayButtonColor         = [NSColor blackColor];

    return defaultStyle;
}

@end
