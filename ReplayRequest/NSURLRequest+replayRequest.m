//
//  NSURLRequest+replayRequest.m
//  ReplayRequestDemo
//
//  Created by Thibaut LE LEVIER on 28/10/2013.
//  Copyright (c) 2013 Thibaut LE LEVIER. All rights reserved.
//

#import "NSURLRequest+replayRequest.h"

@implementation NSURLRequest (replayRequest)

-(NSString *)curlRequest
{
    __block NSString *curlString = [NSString stringWithFormat:@"curl -k -X %@ --dump-header -",self.HTTPMethod];
    
    [[self allHTTPHeaderFields] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        curlString = [curlString stringByAppendingFormat:@" -H \"%@: %@\"",key, obj];
    }];
    
    NSString *data = [[NSString alloc] initWithData:self.HTTPBody encoding:NSUTF8StringEncoding];
    
    if (data)
    {
        curlString = [curlString stringByAppendingFormat:@" -d \"%@\"",data];
    }
    
    curlString = [curlString stringByAppendingFormat:@" %@",self.URL.absoluteString];
    
    return curlString;
}

@end
