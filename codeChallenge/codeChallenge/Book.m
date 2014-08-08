//
//  Book.m
//  codeChallenge
//
//  Created by Eugene Watson on 8/7/14.
//  Copyright (c) 2014 Eugene Watson. All rights reserved.
//

#import "Book.h"

@implementation Book

-(id)initWithTitle:(NSString *)aTitle author:(NSString *)aAuthor {
    self = [super init];
    
    if (self) {
        self.title = aTitle;
        self.author = aAuthor;
    }
    
    return self;
}

-(id)initWithDictionary:(NSDictionary *)dic {
    self = [self initWithTitle:dic[@"title"] author:dic[@"author"]];
    return self;
}

@end
