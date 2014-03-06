//
//  KFAutoScrollTextView.h
//  KFAboutWindowPreview
//
//  Created by rick on 06/03/14.
//  Copyright (c) 2014 KF Interactive. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface KFAutoScrollTextView : NSTextView

@property (nonatomic, getter = isAutoScrolling) BOOL autoScrolling;


- (void)startScrolling;

- (void)stopScrolling;


@end
