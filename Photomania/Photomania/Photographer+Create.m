//
//  Photographer+Create.m
//  Photomania
//
//  Created by Jason Zhou on 13-9-24.
//  Copyright (c) 2013年 Jiasheng Zhou. All rights reserved.
//

#import "Photographer+Create.h"

@implementation Photographer (Create)
+ (Photographer *)photographerWithName:(NSString *)name inManagedObejctContext:(NSManagedObjectContext *)context
{
   
    Photographer *photographer = nil;
    if(name.length){
        NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"Photographer"];
        request.predicate = [NSPredicate predicateWithFormat:@"name = %@",name];
        
        NSError *error ;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        if(!matches || ([matches count] > 1)){
            
        }else if(![matches count]){
            photographer = [NSEntityDescription insertNewObjectForEntityForName:@"Photographer" inManagedObjectContext:context];
            photographer.name = name;
            
        }else{
            photographer = [matches lastObject];
        }

    }
       return photographer;
    
}
@end
