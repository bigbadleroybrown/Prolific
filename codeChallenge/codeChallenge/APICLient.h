//
//  APICLient.h
//  codeChallenge
//
//  Created by Eugene Watson on 8/8/14.
//  Copyright (c) 2014 Eugene Watson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Book.h"

@interface APICLient : NSObject


+(void)loadBooksWithCompletion: (void(^)(NSArray*))completion;
+(void)deleteBooks;



@end
