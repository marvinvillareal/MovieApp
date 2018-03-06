//
//  DetailViewController.h
//  MovieApp
//
//  Created by PHDELHA2(Marvin) on 06/03/2018.
//  Copyright © 2018 MovieAppOrg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) NSDate *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

