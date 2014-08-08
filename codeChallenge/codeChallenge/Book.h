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


-(id)initWithTitle: (NSString *)aTitle
            author: (NSString *)aAuthor;

-(id)initWithDictionary: (NSDictionary *)dic;


@end
