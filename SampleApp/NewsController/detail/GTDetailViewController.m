//
//  GTDetailViewController.m
//  SampleApp
//
//  Created by 程广 on 2020/5/23.
//  Copyright © 2020 chengguang. All rights reserved.
//

#import "GTDetailViewController.h"
#import <WebKit/WebKit.h>
#import "GTScreen.h"

@interface GTDetailViewController()<WKNavigationDelegate>
@property(nonatomic,strong,readwrite) WKWebView *webView;
@property(nonatomic,strong,readwrite) UIProgressView *progressView;
@property(nonatomic,strong,readwrite) NSString *articleUrl;
@end


@implementation GTDetailViewController

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (instancetype)initWithUrlString:(NSString *)urlString {
    self = [super init];
    if(self) {
        self.articleUrl = urlString;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:({
        self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0,STATUS_BAR_HEIGHT+44, self.view.frame.size.width, self.view.frame.size.height - STATUS_BAR_HEIGHT - 44)];
        self.webView.navigationDelegate = self;
        self.webView;
    })];
    
    
    [self.view addSubview: ({
        self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT+44, self.view.frame.size.width, 20)];
        self.progressView;
        
    })];
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.webView loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString: self.articleUrl]]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animati   on.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"webview load success");
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    self.progressView.progress = self.webView.estimatedProgress;
}


@end
