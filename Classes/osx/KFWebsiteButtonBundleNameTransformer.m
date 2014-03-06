//
//  KFWebsiteButtonBundleNameTransformer.m
//  KFAboutWindowPreview
//
//  Created by rick on 06/03/14.
//  Copyright (c) 2014 KF Interactive. All rights reserved.
//

#import "KFWebsiteButtonBundleNameTransformer.h"

@implementation KFWebsiteButtonBundleNameTransformer


+ (Class)transformedValueClass
{
    return [NSString class];
}


+ (BOOL)allowsReverseTransformation
{
    return NO;
}


- (id)transformedValue:(id)value
{
    NSString *bundleName = value;
    return [NSString stringWithFormat:NSLocalizedString(@"Visit %@'s Website", nil), bundleName];
}

@end
