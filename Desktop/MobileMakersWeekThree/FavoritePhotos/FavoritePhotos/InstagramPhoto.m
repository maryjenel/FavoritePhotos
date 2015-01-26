//
//  InstagramPhoto.m
//  FavoritePhotos
//
//  Created by Mary Jenel Myers on 1/26/15.
//  Copyright (c) 2015 Mary Jenel Myers. All rights reserved.
//

#import "InstagramPhoto.h"

@implementation InstagramPhoto
- (instancetype)initWithStandardImage:(NSDictionary *)images filter:(NSString *)filter
{
    self = [super init]; //initializes self.. self is the instagramPhoto Class
    if (self)
    {

        NSDictionary *standardPhotoInfo = [images objectForKey:@"standard_resolution"]; // filtering down
        NSString *standardPhotoURL = [standardPhotoInfo objectForKey:@"url"];
        self.standardPhotoURL = standardPhotoURL;


        self.filter = filter;
    }
    return self;
}
@end
