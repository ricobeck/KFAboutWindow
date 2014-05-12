//
//  KFAboutViewController.h
//  AboutScreenDemo
//
//  Created by Gunnar Herzog on 21/03/14.
//  Copyright (c) 2014 KF Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KFAboutViewController : UIViewController

@property (nonatomic, copy) NSURL *websiteURL;


@property (nonatomic, copy) NSString *bundleName;

@property (nonatomic, copy) NSString *humanReadableCopyright;

@property (nonatomic, copy) NSString *bundleShortVersion;

@property (nonatomic, copy) NSString *bundleVersion;

@property (nonatomic, copy) NSAttributedString *credits;

@property (nonatomic, copy) NSAttributedString *acknowledgements;


@end
