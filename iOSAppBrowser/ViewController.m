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
@property (strong,nonatomic) UIButton *backButton;
@property (strong,nonatomic) UIButton *forwardButton;
@property (strong,nonatomic) UIButton *stopButton;
@property (strong,nonatomic) UIButton *reloadButton;
@property (strong,nonatomic) UIActivityIndicatorView *activity;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // Do any additional setup after loading the view, typically from a nib.
    self.activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.activity];
    //[self.activity startAnimating];
}

#pragma mark - UIViewController
-(void) loadView{
    UIView *mainView = [UIView new];
    self.webView = [WKWebView new];
    self.webView.navigationDelegate = self;
    
    //WebView subview
    
//    NSString *urlString = @"http://wikipedia.org";
//    NSURL *url = [NSURL URLWithString:urlString];
//    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
//    [self.webView loadRequest:urlRequest];
//    
    //TextField subview
    
    self.textField = [UITextField new];
    self.textField.keyboardType= UIKeyboardTypeURL;
    self.textField.returnKeyType = UIReturnKeyDone;
    self.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.textField.placeholder = NSLocalizedString(@"Website URL", "Placeholder for website URL");
    self.textField.backgroundColor = [UIColor colorWithWhite:220/224.0f alpha:1];
    self.textField.delegate = self;
    
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.backButton setEnabled:NO];
    [self.backButton setTitle:NSLocalizedString(@"Back", @"back command") forState:UIControlStateNormal];
    [self.backButton addTarget:self.webView action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    
    self.forwardButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.forwardButton setEnabled:NO];
    [self.forwardButton setTitle:NSLocalizedString(@"Forward", @"Forward command") forState:UIControlStateNormal];
    [self.forwardButton addTarget:self.webView action:@selector(goForward) forControlEvents:UIControlEventTouchUpInside];


    self.stopButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.stopButton setEnabled:NO];
    [self.stopButton setTitle:NSLocalizedString(@"Stop", @"Stop command") forState:UIControlStateNormal];
    [self.stopButton addTarget:self.webView action:@selector(stopLoading) forControlEvents:UIControlEventTouchUpInside];

    self.reloadButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.reloadButton setEnabled:NO];
    [self.reloadButton setTitle:NSLocalizedString(@"Refresh", @"Reload command") forState:UIControlStateNormal];
    [self.reloadButton addTarget:self.webView action:@selector(reload) forControlEvents:UIControlEventTouchUpInside];

    
    
//    [mainView addSubview:self.webView];
//    [mainView addSubview:self.textField];
    //for loop to add all subviews
    for( UIView *subviewToAdd in @[self.webView, self.textField,self.backButton,self.forwardButton,self.stopButton,self.reloadButton]){
        [mainView addSubview:subviewToAdd];
    }
    self.view = mainView;
    
}
-(void) viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
   // self.webView.frame = self.view.frame; // ? - why view and not mainView?
    
    CGFloat static const itemHeight = 50;
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat webViewHeight = CGRectGetHeight(self.view.bounds) - itemHeight - itemHeight;
    CGFloat buttonWidth = CGRectGetWidth(self.view.bounds)/4;
    
    self.textField.frame = CGRectMake(0, 0, width, itemHeight);
    self.webView.frame = CGRectMake(0, CGRectGetMaxY(self.textField.frame), width, webViewHeight);
    
    CGFloat currentButtonX = 0;
    
    for (UIButton *thisButton in @[self.backButton, self.forwardButton, self.stopButton, self.reloadButton]) {
        thisButton.frame = CGRectMake(currentButtonX, CGRectGetMaxY(self.webView.frame), buttonWidth, itemHeight);
        currentButtonX += buttonWidth;
    }
    
//    CGFloat currentButtonX = 0;
//    
//    for (UIButton *thisButton in @[self.backButton, self.forwardButton, self.stopButton, self.reloadButton]) {
//        thisButton.frame = CGRectMake(currentButtonX, CGRectGetMaxY(self.webView.frame), buttonWidth, itemHeight);
//        currentButtonX += buttonWidth;
//    }
    
}

#pragma mark - UITextFieldDelegate

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    NSString *URLString = textField.text;
    NSURL *URL = [NSURL URLWithString:URLString];
    
    if(!URL.scheme){
        URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@",URLString]];
    }
    if (URL) {
        NSURLRequest *URLRequest = [NSURLRequest requestWithURL:URL];
        [self.webView loadRequest:URLRequest];
    }
    return NO;
}

#pragma mark - WKWebView

-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [self updateButtonsAndTitle];
}

-(void) webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [self updateButtonsAndTitle];
}


- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *) navigation withError:(NSError *)error {
    [self webView:webView didFailNavigation:navigation withError:error];
}

//-(void) webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
//    
//    [self webView:webView didFailProvisionalNavigation:navigation withError:error];
//}

-(void) webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    
    if (error.code!=NSURLErrorCancelled) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Error!", @"Error") message:[error localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        
        [alert addAction:OKAction];
        
        [self presentViewController:alert animated: YES completion:nil];
        
        
    }
    [self updateButtonsAndTitle];
    
}




#pragma mark - Miscellaneous

-(void) updateButtonsAndTitle{
    
    NSString *webViewTitle = [self.webView.title copy];
    
    if ([webViewTitle length]) {
        self.title = webViewTitle;
    }
    else{
        self.title = self.webView.URL.absoluteString;
    }
    if (self.webView.isLoading) {
        [self.activity startAnimating];
    }
    else{
        [self.activity stopAnimating];
    }
    
    self.backButton.enabled = [self.webView canGoBack];
    self.forwardButton.enabled = [self.webView canGoForward];
    self.stopButton.enabled = self.webView.isLoading;
    self.reloadButton.enabled = !self.webView.isLoading;
    
}


@end
