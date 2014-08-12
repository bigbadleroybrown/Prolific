//
//  Book.h
//  codeChallenge
//
//  Created by Eugene Watson on 8/7/14.
//  Copyright (c) 2014 Eugene Watson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *publisher;
@property (strong, nonatomic) NSString *categories;
@property (strong, nonatomic) NSString *booksURL;


-(id)initWithTitle: (NSString *)aTitle
            author: (NSString *)aAuthor
            publisher: (NSString *)aPublisher
            categories: (NSString *)aCategory
               booksURL: (NSString *)aUrl;


-(id)initWithDictionary: (NSDictionary *)dic;


@end
