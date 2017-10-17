//
//  DetailViewController.m
//  EveryDo
//
//  Created by Aaron Johnson on 2017-10-17.
//  Copyright © 2017 Aaron Johnson. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}


- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        NSString *completed = @"False";
        if(self.detailItem.completed){
            completed = @"True";
        }
        self.detailDescriptionLabel.text = [NSString stringWithFormat:@"Title: %@\nDescription: %@\nPriority: %d\nCompleted: %@", self.detailItem.title, self.detailItem.todoDescription, self.detailItem.todoPriority, completed];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
