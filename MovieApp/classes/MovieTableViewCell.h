//
//  MovieTableViewCell.h
//  MovieApp
//
//  Created by (Marvin) on 07/03/2018.
//  Copyright © 2018 MovieAppOrg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *year;
@property (weak, nonatomic) IBOutlet UIImageView *movieImageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@end
