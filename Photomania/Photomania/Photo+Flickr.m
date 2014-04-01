//
//  Photo+Flickr.m
//  Photomania
//
//  Created by Jason Zhou on 13-9-24.
//  Copyright (c) 2013年 Jiasheng Zhou. All rights reserved.
//

#import "Photo+Flickr.h"
#import "FlickrFetcher.h"
#import "Photographer+Create.h"
@implementation Photo (Flickr)
+ (Photo *)photoWithFlickrInfo:(NSDictionary *)photoDictionary inManagedObejctContext:(NSManagedObjectContext *)context
{
    Photo *photo = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]];
    request.predicate = [NSPredicate predicateWithFormat:@"unique = %@", [photoDictionary[FLICKR_PHOTO_ID] description]];
    
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if(!matches || ([matches count] > 1)){
        
    }else if(![matches count]){
        photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:context];
        photo.unique = [photoDictionary[FLICKR_PHOTO_ID] description];
        photo.imageURL = [[FlickrFetcher urlForPhoto:photoDictionary format:FlickrPhotoFormatLarge]absoluteString];
        photo.title = [photoDictionary[FLICKR_PHOTO_TITLE] description];
        photo.subtitle = [[photoDictionary valueForKey:FLICKR_PHOTO_DESCRIPTION]description];
        
        NSString *photograpername = [photoDictionary[FLICKR_PHOTO_OWNER] description];
        Photographer *photographer = [Photographer photographerWithName:photograpername inManagedObejctContext:context];
        photo.whoTook = photographer;

    }else{
        photo = [matches lastObject];
    }
    return photo;
    
   }
@end
