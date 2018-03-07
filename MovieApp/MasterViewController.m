//
//  MasterViewController.m
//  MovieApp
//
//  Created by (Marvin) on 06/03/2018.
//  Copyright © 2018 MovieAppOrg. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

@interface MasterViewController ()

@property NSArray *objects;
@end


static NSString *CellIdentifier = @"Cell";
static NSString *PlaceholderIdentifier = @"PlaceholderIdentifier";

@implementation MasterViewController


#pragma mark - Private Methods

- (void)alertWithTitle:(NSString*)alertTitle andMessage:(NSString*)alertMessage {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:alertTitle message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
}


- (void)fetchMovies {
    NSURL *URL = [NSURL URLWithString:@"https://aacayaco.github.io/movielist/list_movies_page1.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      
                                      if (!error) {
                                          NSError *err = nil;
                                          NSDictionary* json = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &err];
                                          
                                          NSArray *movies = json[@"data"][@"movies"];
                                          NSMutableArray *myMov = [[NSMutableArray alloc] initWithCapacity:movies.count];
                                          for (id movie in movies) {
                                              Movie *myMovie = [[Movie alloc] initWithMovieDictionary:movie];
                                              [myMov addObject:myMovie];
                                          }
                                          self.objects = myMov;
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              [self.tableView reloadData];
                                          });

                                          
                                      } else {
                                          [self alertWithTitle:@"Connection Error" andMessage:@"Server Failed. Try again later."];
                                      }
                                      


                                  }];
    
    [task resume];
}

- (void)startDownloadBackdrop:(Movie *)movieItem forIndexPath:(NSIndexPath *)indexPath {
    
    NSURL *url = [NSURL URLWithString:movieItem.backdropURLString];
    
    
    NSURLSessionDataTask *downloadTask =
    [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
      
      movieItem.backdropImage = [UIImage imageWithData:data];
      
      dispatch_async(dispatch_get_main_queue(), ^{
          MovieTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
          cell.movieImageView.image = movieItem.backdropImage;
          [cell.activityIndicator stopAnimating];
      });
    }];
    [downloadTask resume];
    
}

- (void)getImageForVisibleRows {
    if (self.objects.count > 0) {
        NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in visiblePaths)
        {
            Movie *movieItem = (self.objects)[indexPath.row];
            
            if (!movieItem.backdropImage) {
                [self startDownloadBackdrop:movieItem forIndexPath:indexPath];
            }
        }
    }
}


#pragma mark - UIViewController Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
}



- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
    [self fetchMovies];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Movie *movie = self.objects[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:movie];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}


#pragma mark - Table View Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MovieTableViewCell *cell = nil;
    
    if (self.objects.count == 0 && indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:PlaceholderIdentifier forIndexPath:indexPath];
    } else {
    
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

        Movie *movie = self.objects[indexPath.row];
        cell.title.text = movie.title;
        cell.year.text = [NSString stringWithFormat: @"%d", movie.year];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        
        if (!movie.backdropImage) {
            [cell.activityIndicator startAnimating];
            if (self.tableView.dragging == NO && self.tableView.decelerating == NO)
            {
                [self startDownloadBackdrop:movie forIndexPath:indexPath];
            }
            cell.movieImageView.image = nil;
        } else {
            cell.movieImageView.image = movie.backdropImage;
        }
    }
    return cell;
}


#pragma mark - UIScrollViewDelegate:TableView

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self getImageForVisibleRows];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self getImageForVisibleRows];
}




@end
