//
//  DetailViewController.m
//  
//
//  Created by Eugene Watson on 8/7/14.
//
//

#import "TableViewController.h"
#import "DetailViewController.h"
#import "Book.h"

@interface DetailViewController () <UIAlertViewDelegate>

@property (strong, nonatomic) NSString *bookURL;

@property (strong, nonatomic) UIActivityViewController *activityViewController;

@property (strong, nonatomic) NSString *checkedoutBy;

@property (strong, nonatomic) NSString *alertText;



- (IBAction)checkoutPressed:(id)sender;


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


- (IBAction)checkoutPressed:(id)sender
{

    UIAlertView *alertView = [[UIAlertView alloc]init];
    [alertView setDelegate:self];
    [alertView setTitle:@"Enter Name"];
    [alertView addButtonWithTitle:@"Cancel"];
    [alertView addButtonWithTitle:@"OK"];
    
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView textFieldAtIndex:0].keyboardType = UIKeyboardTypeAlphabet;
    
    [alertView show];

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex==0) {
    
        NSLog(@"pressed cancel");
    
    } else {
        
      UITextField *field = [alertView textFieldAtIndex:0];
        
      self.alertText = field.text;
        
      self.bookURL = self.book.booksURL;
        
      NSString *string = [NSString stringWithFormat:@"http://prolific-interview.herokuapp.com/53e3aac7cc8722000724397e%@", self.bookURL];
        
      NSURL *url = [NSURL URLWithString:string];
        
      NSString *post = [[NSString alloc] initWithFormat:@"lastCheckedOutBy=%@", field.text];
        
      NSLog(@"%@", field.text);
        
      NSLog(@"%@", url);
        
      NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];

      NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]]; //%d
        
      NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
        
      [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
      [request setURL:url];
      [request setHTTPMethod:@"PUT"];
      [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
      [request setHTTPBody:postData];
        
      NSLog(@"request is: %@", [request allHTTPHeaderFields]);
      NSError *error;
      NSURLResponse *response;
      NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
      NSLog(@"urlData is: %@",urlData);
        
      NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
      NSLog(@"%@",data);
    
    }
    
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
