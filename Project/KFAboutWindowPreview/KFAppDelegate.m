//
//  KFAppDelegate.m
//  KFAboutWindowPreview
//
//  Created by rick on 05/03/14.
//  Copyright (c) 2014 KF Interactive. All rights reserved.
//

#import "KFAppDelegate.h"

#import "KFAboutWindowController.h"
#import "KFAboutWindowStyleModel.h"

#define kShowCustomization NO

@interface KFAppDelegate ()


@property (nonatomic, strong) KFAboutWindowController *aboutWindowController;


@end


@implementation KFAppDelegate


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    
}


- (IBAction)showAboutWindow:(id)sender
{
    if (self.aboutWindowController == nil)
    {
        self.aboutWindowController = [[KFAboutWindowController alloc] init];
        self.aboutWindowController.websiteURL = [NSURL URLWithString:@"http://provisionbox.com"];
        
        if (kShowCustomization)
        {
            KFAboutWindowStyleModel *styleModel = [KFAboutWindowStyleModel new];
            styleModel.backgroundColor = [NSColor grayColor];
            styleModel.acknowlegdementsTextColor = [NSColor cyanColor];
            styleModel.bundleNameColor = [NSColor greenColor];
            styleModel.versionColor = [NSColor blueColor];
            styleModel.humanReadableCopyrightsColor = [NSColor yellowColor];
            
            [self.aboutWindowController applyStyle:styleModel];
        }
    }
    [self.aboutWindowController showWindow:self];
}


@end
