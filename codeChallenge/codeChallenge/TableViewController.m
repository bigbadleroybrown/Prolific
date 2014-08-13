//
//  TableViewController.m
//  codeChallenge
//
//  Created by Eugene Watson on 8/7/14.
//  Copyright (c) 2014 Eugene Watson. All rights reserved.
//

#import "TableViewController.h"
#import "AFJSONRequestOperation.h"
#import "DetailViewController.h"
#import "APICLient.h"
#import "Book.h"
#import <MBProgressHUD.h>
#import "UITableViewCell+FlatUI.h"
#import "UIColor+FlatUI.h"

@interface TableViewController () <UIAlertViewDelegate>

@property (strong, nonatomic) NSString *bookURL;
@property (strong, nonatomic) Book *book;

@end

@implementation TableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title =@"Books";
    self.books = [[NSMutableArray alloc] init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editTapped:)];
    
    self.navigationItem.rightBarButtonItem = editButton;
    
    self.tableView.separatorColor = [UIColor  cloudsColor];
    
    self.tableView.backgroundColor = [UIColor cloudsColor];
    
    self.tableView.backgroundView = nil;
    
    [self loadBooks];
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)loadBooks
{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    
    [APICLient loadBooksWithCompletion:^(NSArray *books) {  //always name the block
        
        self.books = books;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            
        });
    }];
    
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    });
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView

{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    // Return the number of rows in the section.
    return self.books.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    DetailViewController *detailVC =  [mainSB instantiateViewControllerWithIdentifier:@"DetailViewController"];
    
    detailVC.book = self.books[indexPath.row];
    
    [self.navigationController pushViewController:detailVC animated:YES];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIRectCorner corners = 1;
    if (tableView.style == UITableViewStyleGrouped) {
        if ([tableView numberOfRowsInSection:indexPath.section] == 1) {
            corners = UIRectCornerAllCorners;
        } else if (indexPath.row == 0) {
            corners = UIRectCornerTopLeft | UIRectCornerTopRight;
        } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1) {
            corners = UIRectCornerBottomLeft | UIRectCornerBottomRight;
        }
    }
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:@"cell"];
    }
    
    [cell configureFlatCellWithColor:[UIColor greenSeaColor] selectedColor:[UIColor cloudsColor] roundingCorners:corners];

    cell.textLabel.text = [self.books[indexPath.row] title];
    cell.detailTextLabel.text = [self.books[indexPath.row] author];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// Override to support editing the table view.
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        
//        
//        
//        // Delete the row from the data source
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }   
//}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        //add code here to do what you want when you hit delete
        
        self.bookURL = [self.books[indexPath.row] booksURL];
    
        NSString *string = [NSString stringWithFormat:@"http://prolific-interview.herokuapp.com/53e3aac7cc8722000724397e%@", self.bookURL];
        
        NSURL *url = [NSURL URLWithString:string];
        
        NSLog(@"%@", url);
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
        
        [request setURL:url];
        [request setHTTPMethod:@"DELETE"];
        
        NSLog(@"request is: %@", [request allHTTPHeaderFields]);
        NSError *error;
        NSURLResponse *response;
        NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        NSLog(@"urlData is: %@",urlData);
        
        NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
        NSLog(@"%@",data);
        
        [self.books removeObjectAtIndex:[indexPath row]];
        
        [tableView reloadData];
    }
}

- (IBAction)editTapped:(id)sender
{
    [self.tableView setEditing:YES animated:YES];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Delete All Books"
                                                    message:@"Confirm delete all books"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"OK", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        [self.tableView setEditing:NO animated:YES];
        
        NSLog(@"pressed Cancel");
    }
    
    else {
        
        NSString *string = [NSString stringWithFormat:@"http://prolific-interview.herokuapp.com/53e3aac7cc8722000724397e/clean"];
        
        NSURL *url = [NSURL URLWithString:string];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
        
        [request setURL:url];
        [request setHTTPMethod:@"DELETE"];
        
        NSLog(@"request is: %@", [request allHTTPHeaderFields]);
        NSError *error;
        NSURLResponse *response;
        NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        NSLog(@"urlData is: %@",urlData);
        
        NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
        NSLog(@"%@",data);
        
        //[self.books removeObjectAtIndex:[indexPath row]];
        
        NSLog(@"You Cant read no mo");

        [self.tableView reloadData];
    }
}



/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
