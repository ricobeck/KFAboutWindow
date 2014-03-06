//
//  NSAttributedString+CocoaPods.m
//  KFAboutWindowPreview
//
//  Created by rick on 06/03/14.
//  Copyright (c) 2014 KF Interactive. All rights reserved.
//

#import "NSAttributedString+CocoaPods.h"

#define ACKNOWLEDGEMENTS_NAME @"Acknowledgements"

@implementation NSAttributedString (CocoaPods)



+ (instancetype)attributedStringWithCocoaPodsAcknowledgementsAtPath:(NSString *)acknowledgementsPath
{
    NSDictionary *bodyTextattributes = @{NSFontAttributeName : [NSFont systemFontOfSize:[NSFont smallSystemFontSize]]};
    NSDictionary *headlineTextAttributes = @{NSFontAttributeName : [NSFont boldSystemFontOfSize:[NSFont smallSystemFontSize]]};
    
    return [self attributedStringWithCocoaPodsAcknowledgementsAtPath:acknowledgementsPath headlineTextAttributes:headlineTextAttributes bodyTextAttributes:bodyTextattributes];
}


+ (instancetype)attributedStringWithCocoaPodsAcknowledgementsAtPath:(NSString *)acknowledgementsPath headlineTextAttributes:(NSDictionary *)headlineTextAttributes bodyTextAttributes:(NSDictionary *)bodyTextAttributes
{
    NSArray *excludedLibraries = @[];
    
    static NSDictionary *acknowledgements = nil;
    if (acknowledgements == nil)
    {
        acknowledgements = [NSDictionary dictionaryWithContentsOfFile:acknowledgementsPath];
    }
    NSArray *preferenceSpecifiers = acknowledgements[@"PreferenceSpecifiers"];
    
    
    NSMutableAttributedString *acknowledgementsString = [[NSMutableAttributedString alloc] initWithString:@"" attributes:bodyTextAttributes];
    [preferenceSpecifiers enumerateObjectsUsingBlock:^(NSDictionary *preferenceItem, NSUInteger idx, BOOL *stop)
     {
         NSString *title = [NSLocalizedStringFromTableInBundle(preferenceItem[@"Title"], ACKNOWLEDGEMENTS_NAME, [NSBundle mainBundle], nil) stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
         
         if (idx == 0)
         {
             title = nil;
         }
         
         if ([excludedLibraries containsObject:title])
         {
             return;
         }
         
         NSString *footerText = [NSLocalizedStringFromTableInBundle(preferenceItem[@"FooterText"], ACKNOWLEDGEMENTS_NAME, [NSBundle mainBundle], nil) stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
         
         if (title && title.length > 0)
         {
             [acknowledgementsString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n", title] attributes:headlineTextAttributes]];
         }
         
         if (footerText && footerText.length > 0)
         {
             [acknowledgementsString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n\n\n", footerText] attributes:bodyTextAttributes]];
         }
         
         if (idx == preferenceSpecifiers.count - 2)
         {
             *stop = YES;
         }
     }];
    
    return [acknowledgementsString copy];
}


@end
