//
//  MasterViewController.m
//  EveryDo
//
//  Created by Aaron Johnson on 2017-10-17.
//  Copyright © 2017 Aaron Johnson. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Todo.h"
#import "CustomTableViewCell.h"

@interface MasterViewController ()

@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property NSMutableArray *objects;
@property UISwipeGestureRecognizer *recognizer;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    Todo *one = [Todo new];
    one.title = @"Garbage";
    one.todoDescription = @"Take out garbage";
    one.todoPriority = 10;
    one.completed = false;
    Todo *two = [Todo new];
    two.title = @"Recycling";
    two.todoDescription = @"Take out recycling";
    two.todoPriority = 9;
    two.completed = true;
    Todo *three = [Todo new];
    three.title = @"Dance";
    three.todoDescription = @"Do a crazy dance";
    three.todoPriority = 13;
    three.completed = false;
    Todo *four = [Todo new];
    four.title = @"Exist";
    four.todoDescription = @"What is?";
    four.todoPriority = 1;
    four.completed = true;
    self.objects = [[NSMutableArray alloc] initWithObjects:one,two,three,four, nil];
    self.recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    self.recognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:self.recognizer];
    
}
-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)gesture{
    CGPoint location = [gesture locationInView:self.myTableView];
    NSIndexPath *swipedIndexPath = [self.myTableView indexPathForRowAtPoint:location];
    CustomTableViewCell *swipedCell  = [self.myTableView cellForRowAtIndexPath:swipedIndexPath];
    Todo *swiped = [self.objects objectAtIndex:[self.myTableView indexPathForCell:swipedCell].row];
    if(swiped.completed){
        swiped.completed = false;
    } else {
        swiped.completed = true;
    }
    [self.myTableView reloadData];
}

- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    
    UIAlertController* alert;
    alert= [UIAlertController alertControllerWithTitle:@"Add Todo"
                                               message:@"What Todo would you like to add?"
                                        preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Title";
        textField.font = [UIFont systemFontOfSize:22];
        textField.textAlignment = NSTextAlignmentCenter;
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Description";
        textField.font = [UIFont systemFontOfSize:22];
        textField.textAlignment = NSTextAlignmentCenter;
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Priority";
        textField.font = [UIFont systemFontOfSize:22];
        textField.textAlignment = NSTextAlignmentCenter;
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Add"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * _Nonnull action)
                      {
                          Todo *new = [Todo new];
                          new.title = alert.textFields[0].text;
                          new.todoDescription = alert.textFields[1].text;
                          new.todoPriority = (int)[alert.textFields[2].text integerValue];
                          new.completed = false;
                          
                          [self.objects addObject:new];
                          
                          [self.myTableView reloadData];
                      }]];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:nil];
    [alert addAction: cancel];
    [self presentViewController:alert animated:true completion:nil];
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Todo *object = self.objects[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[segue destinationViewController];
        [controller setDetailItem:object];
    }
}


#pragma mark - Table View
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"showDetail" sender:[self.objects objectAtIndex:indexPath.row]];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:[self.objects[indexPath.row] title]];
    NSMutableAttributedString *todoDescriptionString = [[NSMutableAttributedString alloc] initWithString:[self.objects[indexPath.row] todoDescription]];
    NSMutableAttributedString *priorityString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d", [self.objects[indexPath.row] todoPriority]]];
    if([self.objects[indexPath.row] completed]){
        [titleString addAttribute:NSStrikethroughStyleAttributeName
                            value:@2
                            range:NSMakeRange(0, [titleString length])];
        [todoDescriptionString addAttribute:NSStrikethroughStyleAttributeName
                            value:@2
                            range:NSMakeRange(0, [todoDescriptionString length])];
        [priorityString addAttribute:NSStrikethroughStyleAttributeName
                            value:@2
                            range:NSMakeRange(0, [priorityString length])];
    }
    
    cell.title.attributedText = titleString;
    cell.todoDescription.attributedText = todoDescriptionString;
    cell.priority.attributedText = priorityString;
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}


@end
