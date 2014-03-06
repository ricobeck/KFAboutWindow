//
//  KFAppDelegate.m
//  KFAboutWindowPreview
//
//  Created by rick on 05/03/14.
//  Copyright (c) 2014 KF Interactive. All rights reserved.
//

#import "KFAppDelegate.h"

#import "KFAboutWindowController.h"

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
    }
    [self.aboutWindowController showWindow:self];
}


@end
