//
//  NSAttributedString+CocoaPods.h
//  KFAboutWindowPreview
//
//  Created by rick on 06/03/14.
//  Copyright (c) 2014 KF Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (CocoaPods)


+ (instancetype)attributedStringWithCocoaPodsAcknowledgementsAtPath:(NSString *)acknowledgementsPath;

+ (instancetype)attributedStringWithCocoaPodsAcknowledgementsAtPath:(NSString *)acknowledgementsPath foregroundColor:(NSColor *)foregroundColor;

+ (instancetype)attributedStringWithCocoaPodsAcknowledgementsAtPath:(NSString *)acknowledgementsPath headlineTextAttributes:(NSDictionary *)headlineTextAttributes bodyTextAttributes:(NSDictionary *)bodyTextAttributes;


@end
