//
//  BFXDetailViewController.h
//  PAFinal
//
//  Created by Abhi Nikam on 5/31/14.
//  Copyright (c) 2014 Binaryfluxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFXDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
