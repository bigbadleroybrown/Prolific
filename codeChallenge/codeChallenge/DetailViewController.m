//
//  DetailViewController.m
//  
//
//  Created by Eugene Watson on 8/7/14.
//
//

#import "DetailViewController.h"
#import "Book.h"

@interface DetailViewController ()

@property (strong, nonatomic) UIActivityViewController *activityViewController;

@end


@implementation DetailViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.TitleLabel.text = self.book.title;
    self.AuthorLabel.text = self.book.author;
    self.PublisherLabel.text = self.book.publisher;
    self.CategoriesLabel.text = self.book.categories;
    self.title = @"Detail";
    

    self.navigationController.toolbarHidden = NO;
    
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareAction:)];
    
    self.navigationItem.rightBarButtonItem = shareButton;
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)shareAction:(id)sender
{

    self.activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[self.book.title, self.book.author, self.book.publisher, self.book.categories] applicationActivities:nil];
    
    [self presentViewController:self.activityViewController animated:YES completion:nil];
    
}






/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
