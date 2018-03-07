//
//  MOvie.h
//  MovieApp
//
//  Created by (Marvin) on 07/03/2018.
//  Copyright © 2018 MovieAppOrg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Movie : NSObject

@property(strong, nonatomic) NSString *title;
@property(nonatomic) int year;
@property(nonatomic) float rating;
@property(strong, nonatomic) NSString *overview;
@property(strong, nonatomic) NSString *backdropURLString;
@property(strong, nonatomic) NSString *coverURLString;
@property(strong, nonatomic) UIImage *backdropImage;

- (id)initWithMovieDictionary:(id)movie;

@end
