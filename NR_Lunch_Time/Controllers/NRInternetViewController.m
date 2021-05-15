//
//  ViewController.m
//  NR_Lunch_Time
//
//  Created by MacBook on 5/8/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

#import "NRInternetViewController.h"

@interface NRInternetViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic) NSURLRequest *urlRequest;
@property (nonatomic) UIBarButtonItem *backBarButton;
@property (nonatomic) UIBarButtonItem *forwardBarButton;
@property (nonatomic) UIBarButtonItem *refreshBarButton;

@end

@implementation NRInternetViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.webView.delegate = self;
    if (self.urlRequest == nil)
    {
        self.urlRequest = [[NSURLRequest alloc]initWithURL:[[NSURL alloc]initWithString:urlToWebPage]];
    }
    [self.webView loadRequest:self.urlRequest];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self addButtonsOnNavigationBar];
    [self checkStateOfButtons];
}

- (void)addButtonsOnNavigationBar
{
    self.backBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_webBack"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed)];
    self.forwardBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_webForward"] style:UIBarButtonItemStylePlain target:self action:@selector(forwardButtonPressed)];
    self.refreshBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_webRefresh"] style:UIBarButtonItemStylePlain target:self action:@selector(refreshStopButtonPressed)];
    self.navigationItem.leftBarButtonItems = @[self.backBarButton, self.refreshBarButton, self.forwardBarButton];
    for (UIBarButtonItem *button  in self.navigationItem.leftBarButtonItems) {
        [button setTintColor:UIColor.whiteColor];
    }
}

- (void)backButtonPressed
{
    [self.webView goBack];
    [self checkStateOfButtons];
}

- (void)forwardButtonPressed
{
    [self.webView goForward];
    [self checkStateOfButtons];
}

- (void)refreshStopButtonPressed
{
    if (self.webView.loading)
    {
        [self.webView stopLoading];
        [self.refreshBarButton setImage:[UIImage imageNamed:@"ic_webRefresh"]];
    }
    else
    {
    [self.webView reload];
    }
}

- (void)checkStateOfButtons
{
    self.webView.canGoBack ? [self.backBarButton setEnabled:true] : [self.backBarButton setEnabled:false];
    self.webView.canGoForward ? [self.forwardBarButton setEnabled:true] : [self.forwardBarButton setEnabled:false];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.refreshBarButton setImage:[UIImage imageNamed:@"ic_close"]];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self checkStateOfButtons];
    [self.refreshBarButton setImage:[UIImage imageNamed:@"ic_webRefresh"]];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    // uraditi nesto
}

@end
