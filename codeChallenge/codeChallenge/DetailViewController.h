//
//  DetailViewController.h
//  
//
//  Created by Eugene Watson on 8/7/14.
//
//

#import <UIKit/UIKit.h>
#import "Book.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Book *book;

- (void)loadFromBook:(Book *)book;

@end
