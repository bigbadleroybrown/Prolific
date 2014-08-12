//
//  AddBookViewController.m
//  codeChallenge
//
//  Created by Eugene Watson on 8/11/14.
//  Copyright (c) 2014 Eugene Watson. All rights reserved.
//

#import "AddBookViewController.h"
#import <TSMessages/TSMessage.h>
#import "TableViewController.h"

@interface AddBookViewController () <UITextFieldDelegate, UIAlertViewDelegate>

@property (retain, nonatomic) NSMutableData *receivedData;

@property (weak, nonatomic) IBOutlet UITextField *BookTitleInput;

@property (weak, nonatomic) IBOutlet UITextField *AuthorInput;

@property (weak, nonatomic) IBOutlet UITextField *PublisherInput;

@property (weak, nonatomic) IBOutlet UITextField *CategoriesInput;

@property (weak, nonatomic) IBOutlet UIButton *submitButton;


- (IBAction)SubmitPressed:(id)sender;
- (IBAction)doneTapped:(id)sender;


@end

@implementation AddBookViewController

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
    
    self.title =@"Add Book";
    self.BookTitleInput.delegate = self;
    self.AuthorInput.delegate = self;
    self.PublisherInput.delegate = self;
    self.CategoriesInput.delegate = self;
    
    [TSMessage setDefaultViewController:self];

    [self.navigationController.navigationBar setTranslucent:YES];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTapped:)];
    
    self.navigationItem.rightBarButtonItem = doneButton;
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}


- (IBAction)SubmitPressed:(id)sender {
    
    if ([self.BookTitleInput.text length] >0 && [self.AuthorInput.text length] >0 && [self.PublisherInput.text length]>0 && [self.CategoriesInput.text length] > 0) {
        
        NSURL *url = [NSURL URLWithString:@"http://prolific-interview.herokuapp.com/53e3aac7cc8722000724397e/books/"];
        
        NSString *post = [[NSString alloc] initWithFormat:@"author=%@&title=%@&categories=%@&publisher=%@", self.AuthorInput.text, self.BookTitleInput.text, self.CategoriesInput.text, self.PublisherInput.text];
        
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]]; //%d
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
        
        [request setURL:url];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setHTTPBody:postData];
        
        NSLog(@"request is: %@", [request allHTTPHeaderFields]);
        NSError *error;
        NSURLResponse *response;
        NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        NSLog(@"urlData is: %@",urlData);
        
        NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
        NSLog(@"%@",data);
        
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        TableViewController *homeVC = [storyBoard instantiateViewControllerWithIdentifier:@"home"];
        [self.navigationController pushViewController:homeVC animated:YES];
    
    } else {
        
        [TSMessage showNotificationWithTitle:NSLocalizedString(@"Missing Fields", nil)
                                    subtitle:NSLocalizedString(@"Please fill out all the fields and try again.", nil)
                                        type:TSMessageNotificationTypeError];
    }

}

- (IBAction)doneTapped:(id)sender
{
    
    if (([self.BookTitleInput.text length] >1 || [self.AuthorInput.text length] >1 || [self.PublisherInput.text length]>1 || [self.CategoriesInput.text length] >1)) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unsaved Changes"
                                                        message:@"Confirm leaving with unsaved changes"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"OK", nil];
        [alert show];
    
    } else {
        
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        TableViewController *homeVC = [storyBoard instantiateViewControllerWithIdentifier:@"home"];
        [self.navigationController pushViewController:homeVC animated:YES];

    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        NSLog(@"pressed Cancel");
    }
    
    else {
        
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        TableViewController *homeVC = [storyBoard instantiateViewControllerWithIdentifier:@"home"];

        [self.navigationController pushViewController:homeVC animated:YES];
    }
}


@end
