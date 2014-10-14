//
//  NSURLRequest+replayRequest.m
//  ReplayRequestDemo
//
//  Created by Thibaut LE LEVIER on 28/10/2013.
//  Copyright (c) 2013 Thibaut LE LEVIER. All rights reserved.
//

#import "NSURLRequest+replayRequest.h"

@implementation NSURLRequest (replayRequest)

- (NSString *)escapeQuotesInString:(NSString *)string {
    NSParameterAssert(string);
    
    return [string stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
}

- (NSString *)curlRequest {
    
    NSMutableString *curlString = [NSMutableString stringWithFormat:@"curl -k -X %@ --dump-header -", self.HTTPMethod];
    
    for (NSString *key in self.allHTTPHeaderFields.allKeys) {
        
        NSString *headerKey = [self escapeQuotesInString: key];
        NSString *headerValue = [self escapeQuotesInString: self.allHTTPHeaderFields[key] ];

        [curlString appendFormat:@" -H \"%@: %@\"", headerKey, headerValue];
    }
    
    NSString *bodyDataString = [[NSString alloc] initWithData:self.HTTPBody encoding:NSUTF8StringEncoding];
    if (bodyDataString.length) {
        
        bodyDataString = [self escapeQuotesInString: bodyDataString ];
        [curlString appendFormat:@" -d \"%@\"", bodyDataString];
    }
    
    [curlString appendFormat:@" \"%@\"", self.URL.absoluteString];
    
    return curlString;
}

@end
