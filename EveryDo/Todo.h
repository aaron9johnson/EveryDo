//
//  Todo.h
//  EveryDo
//
//  Created by Aaron Johnson on 2017-10-17.
//  Copyright © 2017 Aaron Johnson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Todo : NSObject
@property NSString *title;
@property NSString *todoDescription;
@property int todoPriority;
@property bool completed;
@end
