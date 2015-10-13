//
//  KFAppDelegate.m
//  KFAboutWindowPreview
//
//  Created by rick on 05/03/14.
//  Copyright (c) 2014 KF Interactive. All rights reserved.
//

#import "KFAppDelegate.h"
#import <KFAboutWindow/KFAboutWindow.h>

#define kShowCustomization NO


@interface KFAppDelegate ()
@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, strong) KFAboutWindowController *aboutWindowController;
@end

@implementation KFAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
}

- (IBAction)showAboutWindow:(id)sender {
    if (self.aboutWindowController == nil) {
        self.aboutWindowController = [[KFAboutWindowController alloc] init];
        self.aboutWindowController.websiteURL = [NSURL URLWithString:@"http://provisionbox.com"];
        
        if (kShowCustomization) {
            KFAboutWindowStyleModel *styleModel = [KFAboutWindowStyleModel new];
            styleModel.backgroundColor                  = [NSColor grayColor];
            styleModel.acknowledgementsTextColor        = [NSColor cyanColor];
            styleModel.bundleNameLabelColor             = [NSColor greenColor];
            styleModel.versionLabelColor                = [NSColor blueColor];
            styleModel.humanReadableCopyrightLabelColor = [NSColor yellowColor];
            styleModel.bundleNameLabelFont              = [NSFont fontWithName:@"HelveticaNeue-Light" size:23];
            
            [self.aboutWindowController applyStyle:styleModel];
        }
    }
    [self.aboutWindowController showWindow:self];
}

@end
