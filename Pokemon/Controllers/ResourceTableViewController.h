//
//  ResourceTableViewController.h
//  iPokeMon
//
//  Created by Kjuly on 1/25/13.
//  Copyright (c) 2013 Kjuly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResourceTableViewController : UITableViewController

@property (retain, nonatomic) NSManagedObjectContext * managedObjectContext;

@end