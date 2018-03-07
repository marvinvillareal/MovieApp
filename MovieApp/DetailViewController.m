//
//  DetailViewController.m
//  MovieApp
//
//  Created by (Marvin) on 06/03/2018.
//  Copyright © 2018 MovieAppOrg. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backdropImageView;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblYear;
@property (weak, nonatomic) IBOutlet UILabel *lblRating;
@property (weak, nonatomic) IBOutlet UITextView *txtViewOverview;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *coverActivityIndicator;

@end

@implementation DetailViewController

- (void)configureView {
    
    if (self.detailItem) {

        self.lblTitle.text = self.detailItem.title;
        self.lblYear.text = [NSString stringWithFormat:@"%d",self.detailItem.year];
        self.lblRating.text = [NSString stringWithFormat:@"%.1f",self.detailItem.rating];
        self.txtViewOverview.text = self.detailItem.overview;
        self.backdropImageView.image = self.detailItem.backdropImage;
        NSURL *url = [NSURL URLWithString:self.detailItem.coverURLString];

        [self.coverActivityIndicator startAnimating];
        
        NSURLSessionDataTask *downloadTask =
        [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

          dispatch_async(dispatch_get_main_queue(), ^{
              self.coverImageView.image = [UIImage imageWithData:data];
              [self.coverActivityIndicator stopAnimating];
          });

        }];
        [downloadTask resume];

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


#pragma mark - Managing the detail item

- (void)setDetailItem:(Movie *)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}


@end
