//
//  NSAttributedString+CocoaPods.h
//  KFAboutWindowPreview
//
//  Created by rick on 06/03/14.
//  Copyright (c) 2014 KF Interactive. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#if TARGET_OS_IPHONE
    #define ColorClassName UIColor
    #define FontClassName UIFont
#else
    #define ColorClassName NSColor
    #define FontClassName NSFont
#endif


@interface NSAttributedString (CocoaPods)


+ (instancetype)attributedStringWithCocoaPodsAcknowledgementsAtPath:(NSString *)acknowledgementsPath;

+ (instancetype)attributedStringWithCocoaPodsAcknowledgementsAtPath:(NSString *)acknowledgementsPath foregroundColor:(ColorClassName *)foregroundColor;

+ (instancetype)attributedStringWithCocoaPodsAcknowledgementsAtPath:(NSString *)acknowledgementsPath headlineTextAttributes:(NSDictionary *)headlineTextAttributes bodyTextAttributes:(NSDictionary *)bodyTextAttributes;


@end
