//
//  ViewController.m
//  iOSAppBrowser
//
//  Created by Vetri Selvi Vairamuthu on 8/28/15.
//  Copyright (c) 2015 Vetri Selvi Vairamuthu. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import "AwesomeFloatingToolbar.h"

@interface ViewController () <WKNavigationDelegate, UITextFieldDelegate, AwesomeFloatingToolbarDelegate>

@property (strong,nonatomic) WKWebView *webView;
@property (strong,nonatomic) UITextField *textField;
//@property (strong,nonatomic) UIButton *backButton;
//@property (strong,nonatomic) UIButton *forwardButton;
//@property (strong,nonatomic) UIButton *stopButton;
//@property (strong,nonatomic) UIButton *reloadButton;
@property (nonatomic, strong) AwesomeFloatingToolbar *awesomeToolbar;
@property (strong,nonatomic) UIActivityIndicatorView *activity;
@property (nonatomic,strong)UIAlertAction *okAction;

@end


#define kWebBrowserBackString NSLocalizedString(@"Back", @"Back command")
#define kWebBrowserForwardString NSLocalizedString(@"Forward", @"Forward command")
#define kWebBrowserStopString NSLocalizedString(@"Stop", @"Stop command")
#define kWebBrowserRefreshString NSLocalizedString(@"Refresh", @"Reload command")

@implementation ViewController

- (void)viewDidLoad { //mostly use viewDidLoad
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // Do any additional setup after loading the view, typically from a nib.
    self.activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.activity];
    //[self.activity startAnimating];
    
    
    self.okAction = [UIAlertAction actionWithTitle:@"Proceed!"
                                             style:UIAlertActionStyleDefault
                                           handler:nil];
    self.okAction.enabled = NO;
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil
                                                                        message:@"Enter passcode"
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    
    [controller addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        
        textField.delegate = self;
    }];
    
    [controller addAction:self.okAction];
    [self presentViewController:controller animated:YES completion:nil];
    
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSString *finalString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
//    if(textField.text)
//    {
//        textField.text = @"remix";
//    }
    [self.okAction setEnabled:([finalString isEqualToString: @"0112358"])];
    return YES;
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];


//METHOD TO ACCESS textfield of UIAlertController
    
//    NSString *username = [(UITextField *)[alert.textFields firstObject] text];
//    NSString *password = [(UITextField *)[alert.textFields objectAtIndex:1] text];
//    
//    
//
//    if([username isEqualToString:@"amlu"] && [password isEqualToString:@"amlu"]){
//        //self.ok.enabled = YES;
//        check.enabled = YES;
//      //  [self viewDidLoad];
//        
//        
//        
//        
//    }
//    else {
//        check.enabled = NO;
//        
//    }
   
    
    
    
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
//    self.textField.keyboardType= UIKeyboardTypeURL;
    self.textField.returnKeyType = UIReturnKeyDone;
    self.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.textField.placeholder = NSLocalizedString(@"Google search or look-up the URL of a Website", "Placeholder for web search");
    self.textField.backgroundColor = [UIColor colorWithWhite:220/224.0f alpha:1];
    self.textField.delegate = self;
    
    
    self.awesomeToolbar = [[AwesomeFloatingToolbar alloc] initWithFourTitles:@[kWebBrowserBackString, kWebBrowserForwardString, kWebBrowserStopString, kWebBrowserRefreshString]];
    self.awesomeToolbar.delegate = self;
//
//    self.backButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    [self.backButton setEnabled:NO];
//    [self.backButton setTitle:NSLocalizedString(@"Back", @"back command") forState:UIControlStateNormal];

    //example for selector method for UIButton
//    UIButton *sampleButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [sampleButton setTitle:@"SampleTitle" forState:UIControlStateNormal];
//    [sampleButton addTarget:self action:@selector(_doSomething:) forControlEvents:UIControlEventTouchUpInside];
    
//    //[self _doSomething:sampleButton]; Action
//    
//    self.forwardButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    [self.forwardButton setEnabled:NO];
//    [self.forwardButton setTitle:NSLocalizedString(@"Forward", @"Forward command") forState:UIControlStateNormal];
//
//
//    self.stopButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    [self.stopButton setEnabled:NO];
//    [self.stopButton setTitle:NSLocalizedString(@"Stop", @"Stop command") forState:UIControlStateNormal];
//
//    self.reloadButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    [self.reloadButton setEnabled:NO];
//    [self.reloadButton setTitle:NSLocalizedString(@"Refresh", @"Reload command") forState:UIControlStateNormal];
//
   // [self _addButtonsTarget];
    
//    [mainView addSubview:self.webView];
//    [mainView addSubview:self.textField];
    
    //for loop to add all subviews
    for (UIView *viewToAdd in @[self.webView, self.textField, self.awesomeToolbar]) {
        [mainView addSubview:viewToAdd];
    }
    self.view = mainView;
    
    
}


-(void) viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
   // self.webView.frame = self.view.frame; // ? - why view and not mainView?
    
    CGFloat static const itemHeight = 50; //best to use CGRectGetHeight‚
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat webViewHeight = CGRectGetHeight(self.view.bounds) - itemHeight ;
   // CGFloat browserHeight = CGRectGetHeight(self.view.bounds) - itemHeight;

   // CGFloat buttonWidth = CGRectGetWidth(self.view.bounds)/4;
    
    self.textField.frame = CGRectMake(0, 0, width, itemHeight);
    self.webView.frame = CGRectMake(0, CGRectGetMaxY(self.textField.frame), width, webViewHeight);
    

    
    
//    CGFloat currentButtonX = 0;
//    
//    for (UIButton *thisButton in @[self.backButton, self.forwardButton, self.stopButton, self.reloadButton]) {
//        thisButton.frame = CGRectMake(currentButtonX, CGRectGetMaxY(self.webView.frame), buttonWidth, itemHeight);
//        currentButtonX += buttonWidth;
//    }
    
    self.awesomeToolbar.frame = CGRectMake(20, 100, 280, 60);
    
}
#pragma mark - AwesomeFloatingToolbarDelegate

- (void) floatingToolbar:(AwesomeFloatingToolbar *)toolbar didSelectButtonWithTitle:(NSString *)title {
    if ([title isEqual:kWebBrowserBackString]) {
        [self.webView goBack];
    } else if ([title isEqual:kWebBrowserForwardString]) {
        [self.webView goForward];
    } else if ([title isEqual:kWebBrowserStopString]) {
        [self.webView stopLoading];
    } else if ([title isEqual:kWebBrowserRefreshString]) {
        [self.webView reload];
    }
    
}
#pragma mark - UITextFieldDelegate

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    NSString *URLString = textField.text;
    NSURL *URL = [NSURL URLWithString:URLString];
    
    NSRange whiteSpaceRange = [URLString rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]];

    if(whiteSpaceRange.location == NSNotFound){ //do URL look-up

    if(!URL.scheme){
        URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@",URLString]];
    }
    if (URL) {
        NSURLRequest *URLRequest = [NSURLRequest requestWithURL:URL];
        [self.webView loadRequest:URLRequest];
    }
    
    }
    
    else{ // do google search instead
        NSString* URLString3 =
        [URLString stringByAddingPercentEscapesUsingEncoding: NSASCIIStringEncoding];
//        [URLString stringByReplacingOccurrencesOfString:@" " withString:@"+"];

        NSString *URLString2 = [NSString stringWithFormat:@"http://www.google.com/search?q=%@",URLString3];
        NSURL *URL2 = [NSURL URLWithString:URLString2];
        NSURLRequest *URLRequest2 = [NSURLRequest requestWithURL:URL2];
        [self.webView loadRequest:URLRequest2];

    }
    
    return NO;
}

#pragma mark - WKWebView

-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [self _updateButtonsAndTitle];
}

-(void) webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [self _updateButtonsAndTitle];
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
    [self _updateButtonsAndTitle];
    
}

//- (void)_doSomething:(UIButton *)sender
//{
//    NSLog(@"%@", sender.titleLabel.text); 
//}




#pragma mark - Miscellaneous

-(void) _updateButtonsAndTitle{ //_updateButtonsAndTitle for private methods
    
    NSString *webViewTitle = [self.webView.title copy]; //?
    
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
    
//    self.backButton.enabled = [self.webView canGoBack];
//    self.forwardButton.enabled = [self.webView canGoForward];
//    self.stopButton.enabled = self.webView.isLoading;
//    self.reloadButton.enabled = !self.webView.isLoading && self.webView.URL; //This change ensures that the web view has an NSURLRequest with accompanying NSURL. Otherwise, there'd be nothing to reload.
    
    
    [self.awesomeToolbar setEnabled:[self.webView canGoBack] forButtonWithTitle:kWebBrowserBackString];
    [self.awesomeToolbar setEnabled:[self.webView canGoForward] forButtonWithTitle:kWebBrowserForwardString];
    [self.awesomeToolbar setEnabled:[self.webView isLoading] forButtonWithTitle:kWebBrowserStopString];
    [self.awesomeToolbar setEnabled:![self.webView isLoading] && self.webView.URL forButtonWithTitle:kWebBrowserRefreshString];
    
}

#pragma mark - remove button targets for old web view and add targets for new webview

//-(void) _addButtonsTarget{
//    
//    //remove target of buttons for old webView
//    for (UIButton *button in @[self.backButton,self.forwardButton,self.stopButton,self.reloadButton]) {
//        [button removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
//    }
//    
//    // add target of buttons for new webView
//    [self.backButton addTarget:self.webView action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
//    [self.forwardButton addTarget:self.webView action:@selector(goForward) forControlEvents:UIControlEventTouchUpInside];
//    [self.stopButton addTarget:self.webView action:@selector(stopLoading) forControlEvents:UIControlEventTouchUpInside];
//    [self.reloadButton addTarget:self.webView action:@selector(reload) forControlEvents:UIControlEventTouchUpInside];
//
//
//}

#pragma mark - reset Browser when the app goes to the background

-(void) _resetWebView{
    
    //1.remove existing webView
    [self.webView removeFromSuperview];
    //2.Make a new fresh webView
    WKWebView *newWebView = [[WKWebView alloc]init];
    newWebView.navigationDelegate = self;
    self.webView = newWebView;
    
    //3.add buttons to the new webview
   // [self _addButtonsTarget];
    
    //4.reset URL text field
    self.textField.text = nil;
    //5. update buttons and titles
    [self _updateButtonsAndTitle];
}

@end
