//
//  AwesomeFloatingToolbar.h
//  iOSAppBrowser
//
//  Created by Vetri Selvi Vairamuthu on 9/5/15.
//  Copyright (c) 2015 Vetri Selvi Vairamuthu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AwesomeFloatingToolbar;

@protocol AwesomeFloatingToolbarDelegate <NSObject>

@optional
- (void) floatingToolbar:(AwesomeFloatingToolbar *)toolbar didSelectButtonWithTitle:(NSString *)title;

@end



@interface AwesomeFloatingToolbar : UIView

-(instancetype) initWithFourTitles: (NSArray *)titles;
-(void) setEnabled:(BOOL) enabled forButtonWithTitle: (NSString *)title;
@property(nonatomic,strong) id <AwesomeFloatingToolbarDelegate> delegate;

@end
