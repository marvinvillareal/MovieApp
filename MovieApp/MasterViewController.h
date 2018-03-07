//
//  MasterViewController.h
//  MovieApp
//
//  Created by (Marvin) on 06/03/2018.
//  Copyright © 2018 MovieAppOrg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
#import "MovieTableViewCell.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;


@end

