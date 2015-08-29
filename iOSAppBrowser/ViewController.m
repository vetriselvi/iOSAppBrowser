//
//  ViewController.m
//  iOSAppBrowser
//
//  Created by Vetri Selvi Vairamuthu on 8/28/15.
//  Copyright (c) 2015 Vetri Selvi Vairamuthu. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController () <WKNavigationDelegate, UITextFieldDelegate>
@property (strong,nonatomic) WKWebView *webView;
@property (strong,nonatomic) UITextField *textField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // Do any additional setup after loading the view, typically from a nib.
}

-(void) loadView{
    UIView *mainView = [UIView new];
    self.webView = [WKWebView new];
    self.webView.navigationDelegate = self;
    
    //WebView subview
    
    NSString *urlString = @"http://wikipedia.org";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];
    
    //TextField subview
    
    self.textField = [UITextField new];
    self.textField.keyboardType= UIKeyboardTypeURL;
    self.textField.returnKeyType = UIReturnKeyDone;
    self.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.textField.placeholder = NSLocalizedString(@"Website URL", "Placeholder for website URL");
    self.textField.backgroundColor = [UIColor colorWithWhite:220/224.0f alpha:1];
    self.textField.delegate = self;
    
    
    [mainView addSubview:self.webView];
    [mainView addSubview:self.textField];
    self.view = mainView;
    
}
-(void) viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
   // self.webView.frame = self.view.frame; // ? - why view and not mainView?
    
    CGFloat static const textFieldHeight = 50;
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat webViewHeight = CGRectGetHeight(self.view.bounds) - textFieldHeight;
    
    self.textField.frame = CGRectMake(0, 0, width, textFieldHeight);
    self.webView.frame = CGRectMake(0, CGRectGetMaxY(self.textField.frame), width, webViewHeight);
    
    
    
}

@end
