//
//  MOvie.m
//  MovieApp
//
//  Created by (Marvin) on 07/03/2018.
//  Copyright © 2018 MovieAppOrg. All rights reserved.
//

#import "Movie.h"


@implementation Movie


- (id)initWithMovieDictionary:(id)movie  {
    self = [super init];
    if (self)
    {
        self.title = movie[@"title"];
        self.year = [movie[@"year"] intValue];
        self.rating = [movie[@"rating"] floatValue];
        self.overview = movie[@"overview"];
        self.backdropURLString = [NSString stringWithFormat:@"https://aacayaco.github.io/movielist/images/%@-backdrop.jpg",movie[@"slug"]];
        self.coverURLString = [NSString stringWithFormat:@"https://aacayaco.github.io/movielist/images/%@-cover.jpg",movie[@"slug"]];
    }
    return self;
}

@end
