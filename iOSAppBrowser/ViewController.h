//
//  ViewController.h
//  iOSAppBrowser
//
//  Created by Vetri Selvi Vairamuthu on 8/28/15.
//  Copyright (c) 2015 Vetri Selvi Vairamuthu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

/**
 Replaces the web view with a fresh one, erasing all history. Also updates the URL field and toolbar buttons appropriately.
 */
- (void) _resetWebView;
//- (void) _okayFunction;

@end

