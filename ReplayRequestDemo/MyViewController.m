//
//  MyViewController.m
//  ReplayRequestDemo
//
//  Created by Thibaut LE LEVIER on 28/10/2013.
//  Copyright (c) 2013 Thibaut LE LEVIER. All rights reserved.
//

#import "MyViewController.h"
#import "NSURLRequest+replayRequest.h"

@interface MyViewController ()

@property (strong, nonatomic) IBOutlet UITextView *logsTextView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loaderView;

@end

@implementation MyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self makeRequestAction:nil];

}

-(IBAction)makeRequestAction:(id)sender
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://httpbin.org/post"]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[[[NSDate date] description] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [self.loaderView startAnimating];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[[NSOperationQueue alloc] init]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               
                               NSLog(@"request: %@",[request curlRequest]);
                               NSLog(@"response: %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                               
                               dispatch_async(dispatch_get_main_queue(),^{
                                   [self.loaderView stopAnimating];
                                   self.logsTextView.text = [self.logsTextView.text stringByAppendingFormat:@"$ %@\n",[request curlRequest]];
                               });
                               
                           }];
}

@end
