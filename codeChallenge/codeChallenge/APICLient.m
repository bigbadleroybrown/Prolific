//
//  APICLient.m
//  codeChallenge
//
//  Created by Eugene Watson on 8/8/14.
//  Copyright (c) 2014 Eugene Watson. All rights reserved.
//

#import "APICLient.h"
#import "Book.h"
#import "AFJSONRequestOperation.h"


@interface APICLient ()


@end

@implementation APICLient




+(void)loadBooksWithCompletion: (void(^)(NSArray*))completion

{
    
    NSURL *json = [[NSURL alloc] initWithString:@"http://prolific-interview.herokuapp.com/53e3aac7cc8722000724397e/books/"];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:json];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        NSMutableArray *tempBooks = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dic in JSON) {
            Book *book = [[Book alloc] initWithDictionary:dic];
            [tempBooks addObject:book];
            
            NSLog(@"%@", JSON);
        }
    
        completion(tempBooks);
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"NSError: %@", error.localizedDescription);
        
        completion(@[error]);
    }];
    
    [operation start];
    
}


+(void)addBooksWithCompletion: (void(^)(NSArray *))completion
{
 
    NSString *post = [NSString stringWithFormat:@"example=test&p=1&test=yourPostMessage&this=isNotReal"];
    
    NSData *data = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [data length]];
    
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:@"http://prolific-interview.herokuapp.com/53e3aac7cc8722000724397e/books/"]];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPBody:data];
    
    

    
    
    
    
    
    
}


@end
