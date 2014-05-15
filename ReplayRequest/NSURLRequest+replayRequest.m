//
//  NSURLRequest+replayRequest.m
//  ReplayRequestDemo
//
//  Created by Thibaut LE LEVIER on 28/10/2013.
//  Copyright (c) 2013 Thibaut LE LEVIER. All rights reserved.
//

#import "NSURLRequest+replayRequest.h"

@implementation NSURLRequest (replayRequest)

- (NSString *)curlRequest {
    
    NSMutableString *curlString = [NSMutableString stringWithFormat:@"curl -k -X %@ --dump-header -",self.HTTPMethod];
    
    for (NSString *key in self.allHTTPHeaderFields.allKeys) {
        
        [curlString appendFormat:@" -H \"%@: %@\"",key, self.allHTTPHeaderFields[key]];
    }
    
    NSString *data = [[NSString alloc] initWithData:self.HTTPBody encoding:NSUTF8StringEncoding];
    if (data.length) {
        
        data = [data stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
        
        [curlString appendFormat:@" -d \"%@\"",data];
    }
    
    [curlString appendFormat:@" %@",self.URL.absoluteString];
    
    return curlString;
}

@end
