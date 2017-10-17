//
//  CustomTableViewCell.h
//  EveryDo
//
//  Created by Aaron Johnson on 2017-10-17.
//  Copyright © 2017 Aaron Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MasterViewController.h"

@interface CustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *todoDescription;
@property (weak, nonatomic) IBOutlet UILabel *priority;


@end
