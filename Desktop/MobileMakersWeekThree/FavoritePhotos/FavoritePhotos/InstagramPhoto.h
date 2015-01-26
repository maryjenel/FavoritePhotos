//
//  InstagramPhoto.h
//  FavoritePhotos
//
//  Created by Mary Jenel Myers on 1/26/15.
//  Copyright (c) 2015 Mary Jenel Myers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InstagramPhoto : NSObject
@property NSString *standardPhotoURL;
@property NSString *filter;
@property BOOL favPhoto;

- (instancetype)initWithStandardImage:(NSDictionary *)images filter:(NSString *)filter;

@end
