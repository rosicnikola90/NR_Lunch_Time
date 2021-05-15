//
//  NRRestorantsManager.m
//  NR_Lunch_Time
//
//  Created by MacBook on 5/9/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

#import "NRRestorantsManager.h"


@implementation NRRestorantsManager

//generates Restourant object based of serialized json data
- (NRRestourant *)restourantGeneratorforData:(NSDictionary *)jsonData
{
    NRRestourant *newRestourant = NRRestourant.new;
    newRestourant.backgroundImageWithURL = NRImageOfRestourant.new;
    if ([jsonData objectForKey:@"name"])
    {
        [newRestourant setValue:jsonData[@"name"] forKey:@"name"];
    }
    if ([jsonData objectForKey:@"category"])
    {
        [newRestourant setValue:jsonData[@"category"] forKey:@"category"];
    }
    if ([jsonData objectForKey:@"contact"] && jsonData[@"contact"] != (id)[NSNull null])
    {
        if ([jsonData[@"contact"] objectForKey:@"formattedPhone"])
        {
            [newRestourant setValue:jsonData[@"contact"][@"formattedPhone"] forKey:@"phoneNo"];
        }
        if ([jsonData[@"contact"] objectForKey:@"twitter"])
        {
            [newRestourant setValue:jsonData[@"contact"][@"twitter"] forKey:@"twitter"];
        }
    }
    if ([jsonData objectForKey:@"location"] && jsonData[@"location"] != (id)[NSNull null])
    {
        if ([jsonData[@"location"] objectForKey:@"formattedAddress"])
        {
            [newRestourant setValue:jsonData[@"location"][@"formattedAddress"] forKey:@"address"];
        }
        if ([jsonData[@"location"] objectForKey:@"lat"])
        {
            [newRestourant setValue:jsonData[@"location"][@"lat"] forKey:@"latitude"];
        }
        if ([jsonData[@"location"] objectForKey:@"lng"])
        {
            [newRestourant setValue:jsonData[@"location"][@"lng"] forKey:@"longitude"];
        }
    }
    if ([jsonData objectForKey:@"backgroundImageURL"])
    {
        [newRestourant.backgroundImageWithURL setValue:jsonData[@"backgroundImageURL"] forKey:@"imageURL"];
    }
    return newRestourant;
}

- (void)getImageDataForRestourantURL:(NSString *)urlString atIndex:(NSIndexPath *)indexPath
{
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSURLSession *urlSession = NSURLSession.sharedSession;
    [[urlSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        NSIndexPath *indexP = indexPath;
        if (data != nil)
        {
            if (self.delegate != nil)
            {
                [self.delegate updatedRestourantImage:data atIndexPath:indexP];
            }
        }
    }] resume];
}

- (void)updateRestourantListFromWebWithURL:(NSString *)urlStr
{
    NSMutableArray *restourants = NSMutableArray.new;
    NSURL *url = [[NSURL alloc] initWithString:urlStr];
    NSURLSession *urlSession = NSURLSession.sharedSession;
    [[urlSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        if (error == nil)
        {
            NSError *err;
            NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
            if (err == nil)
            {
                for (id restourant in jsonData[@"restaurants"])
                {
                    NRRestourant *newRestourant = [self restourantGeneratorforData:restourant];
                    [restourants addObject:newRestourant];
                }
                if (self.delegate != nil)
                {
                    [self.delegate reastourantArrayCreated:restourants];
                }
            }
            else
            {
                NSLog(@"error during serialization :%@", err.localizedDescription);
            }
        }
        else
        {
            if (self.delegate != nil) {
                [self.delegate restourantUpdateResultWithError:error];
            }
        }
    }] resume];
}

@end
