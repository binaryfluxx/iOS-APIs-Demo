//
//  BFXMasterViewController.h
//  PAFinal
//
//  Created by Abhi Nikam on 5/31/14.
//  Copyright (c) 2014 Binaryfluxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BFXDetailViewController;

#import <CoreData/CoreData.h>

@interface BFXMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate,     UISplitViewControllerDelegate>

@property (strong, nonatomic) BFXDetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@end

@protocol splitViewHandler <NSObject>

@property (nonatomic, strong) UIBarButtonItem *splitViewButton;
- (void)setSplitViewButton:(UIBarButtonItem *)splitViewButton forPopoverController:(UIBarButtonItem *)popoverController;

@end
