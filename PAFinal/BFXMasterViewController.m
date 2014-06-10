//
//  BFXMasterViewController.m
//  PAFinal
//
//  Created by Abhi Nikam on 5/31/14.
//  Copyright (c) 2014 Binaryfluxx. All rights reserved.
//

#import "BFXMasterViewController.h"

#import "BFXDetailViewController.h"
#import "BFXAboutViewController.h"
#import "BFXConcurrencyViewController.h"
#import "BFXSandboxViewController.h"
#import "BFXNotificationsViewController.h"
#import "BFXSocialViewController.h"
#import "BFXMapViewController.h"
#import "BFXCoreAnimationViewController.h"
#import "BFXContactsViewController.h"
#import "BFXSQLiteViewController.h"
#import "BFXCoreDataViewController.h"
#import "BFXAppDelegate.h"

@interface BFXMasterViewController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end


@implementation BFXMasterViewController
{
    BFXAboutViewController *aboutVC;
    BFXConcurrencyViewController *concurVC;
    BFXSandboxViewController *sandboxVC;
    BFXNotificationsViewController *notificationsVC;
    BFXSocialViewController *socialVC;
    BFXMapViewController *mapVC;
    BFXCoreAnimationViewController *coreAnimationVC;
    BFXContactsViewController *contactsVC;
    BFXSQLiteViewController *sqliteVC;
    BFXCoreDataViewController *coredataVC;
    
}

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
    self.splitViewController.delegate = self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"PAFinal";
    
    //access to navigation controller
    UINavigationController *nc = self.splitViewController.viewControllers[1];
    aboutVC = nc.viewControllers[0];
    //self.masterPopoverController = self.splitViewController.viewControllers[0];
    
	// Do any additional setup after loading the view, typically from a nib.
//    self.navigationItem.leftBarButtonItem = self.editButtonItem;
//
//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
//    self.navigationItem.rightBarButtonItem = addButton;
//    self.detailViewController = (BFXAboutViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    
    // If appropriate, configure the new managed object.
    // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
    [newManagedObject setValue:[NSDate date] forKey:@"timeStamp"];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
         // Replace this implementation with code to handle the error appropriately.
         // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


#pragma mark - Split view
- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    //    if ([self interfaceOrientation] == UIInterfaceOrientationIsPortrait([UIDevice currentDevice].orientation)) {
    
    barButtonItem.title = @"Demos";
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
    //    }
}


- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}


#pragma mark - Table View

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return [[self.fetchedResultsController sections] count];
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
//    return [sectionInfo numberOfObjects];
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//    [self configureCell:cell atIndexPath:indexPath];
//    return cell;
//}
//
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        NSError *error = nil;
        if (![context save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }   
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
//        NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
//        self.detailViewController.detailItem = object;
        UINavigationController *nc = self.splitViewController.viewControllers[1];
        NSMutableArray *vcArray = [NSMutableArray arrayWithArray:nc.viewControllers];
        UIViewController *vc = [vcArray lastObject];
        UIBarButtonItem *button = [[vc navigationItem] leftBarButtonItem];
        
        [vcArray removeLastObject];
        switch (indexPath.row) {
            case 0:
                [vcArray addObject:aboutVC];
                [[aboutVC navigationItem] setLeftBarButtonItem:button];
                self.splitViewController.delegate = aboutVC;
                break;
            case 1:
                if (concurVC == nil) {
                    concurVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Concurrency"];
                }
                [vcArray addObject:concurVC];
                [[concurVC navigationItem] setLeftBarButtonItem:button];
                self.splitViewController.delegate = concurVC;
                break;
            case 2:
                if (sandboxVC == nil) {
                    sandboxVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Sandbox"];
                }
                [vcArray addObject:sandboxVC];
                [[sandboxVC navigationItem] setLeftBarButtonItem:button];
                self.splitViewController.delegate = sandboxVC;
                break;
            case 3:
                if (notificationsVC == nil) {
                    notificationsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Notifications"];
                }
                [vcArray addObject:notificationsVC];
                [[notificationsVC navigationItem] setLeftBarButtonItem:button];
                self.splitViewController.delegate = notificationsVC;
                break;
            case 4:
                if (socialVC == nil) {
                    socialVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Social"];
                }
                [vcArray addObject:socialVC];
                [[socialVC navigationItem] setLeftBarButtonItem:button];
                self.splitViewController.delegate = socialVC;
                break;
            case 5:
                if (mapVC == nil) {
                    mapVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Mapkit"];
                }
                [vcArray addObject:mapVC];
                [[mapVC navigationItem] setLeftBarButtonItem:button];
                self.splitViewController.delegate = mapVC;
                break;
            case 6:
                if (coreAnimationVC == nil) {
                    coreAnimationVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CoreAnimation"];
                }
                [vcArray addObject:coreAnimationVC];
                [[coreAnimationVC navigationItem] setLeftBarButtonItem:button];
                self.splitViewController.delegate = coreAnimationVC;
                break;
            case 7:
                if (contactsVC == nil) {
                    contactsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Contacts"];
                }
                [vcArray addObject:contactsVC];
                [[contactsVC navigationItem] setLeftBarButtonItem:button];
                self.splitViewController.delegate = contactsVC;
                break;
            case 8:
                if (sqliteVC == nil) {
                    sqliteVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SQLite"];
                }
                [vcArray addObject:sqliteVC];
                [[sqliteVC navigationItem] setLeftBarButtonItem:button];
                self.splitViewController.delegate = sqliteVC;
                break;
            case 9:
                if (coredataVC == nil) {
                    coredataVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CoreData"];
                }
                [vcArray addObject:coredataVC];
                [[coredataVC navigationItem] setLeftBarButtonItem:button];
                self.splitViewController.delegate = coredataVC;
                break;
            default:
                break;
        }
        
        nc.viewControllers = vcArray;
        
//        self.masterPopoverController = nc.viewControllers[0];
        
        
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        [[segue destinationViewController] setDetailItem:object];
//        self.masterPopoverController = [(UIStoryboardPopoverSegue *)segue popoverController];
//        self.masterPopoverController.delegate = (id <UIPopoverControllerDelegate>)self;
    }
    
    
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timeStamp" ascending:NO];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
	     // Replace this implementation with code to handle the error appropriately.
	     // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return _fetchedResultsController;
}    

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

/*
// Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed. 
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    // In the simplest, most efficient, case, reload the table view.
    [self.tableView reloadData];
}
 */

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [[object valueForKey:@"timeStamp"] description];
}

@end
