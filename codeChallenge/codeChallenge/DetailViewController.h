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

@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *AuthorLabel;
@property (weak, nonatomic) IBOutlet UILabel *PublisherLabel;
@property (weak, nonatomic) IBOutlet UILabel *CategoriesLabel;

@property (weak, nonatomic) IBOutlet UILabel *NameDateLabel;

@property (strong, nonatomic) Book *book;

- (void)loadFromBook:(Book *)book;

@end
