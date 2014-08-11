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

+(void)deleteBooks

{


    
}



@end
