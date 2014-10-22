//
//  KFAboutWindowStyleModel.m
//  KFAboutWindowPreview
//
//  Created by rick on 07/03/14.
//  Copyright (c) 2014 KF Interactive. All rights reserved.
//

#import "KFAboutWindowStyleModel.h"


static NSFont *KFBundleNameLabelDefaultFont;
static NSFont *KFVersionLabelDefaultFont;
static NSFont *KFHumanReadableCopyrightLabelDefaultFont;


@implementation KFAboutWindowStyleModel

+ (void)initialize {
    KFBundleNameLabelDefaultFont = [NSFont boldSystemFontOfSize:22.0];
    KFVersionLabelDefaultFont = [NSFont boldSystemFontOfSize:11.0];
    KFHumanReadableCopyrightLabelDefaultFont = [NSFont systemFontOfSize:11.0];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _bundleNameLabelFont = KFBundleNameLabelDefaultFont;
        _versionLabelFont = KFVersionLabelDefaultFont;
        _humanReadableCopyrightLabelFont = KFHumanReadableCopyrightLabelDefaultFont;
    }
    return self;
}

@end
