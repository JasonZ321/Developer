//
//  Photographer+Create.h
//  Photomania
//
//  Created by Jason Zhou on 13-9-24.
//  Copyright (c) 2013年 Jiasheng Zhou. All rights reserved.
//

#import "Photographer.h"

@interface Photographer (Create)
+ (Photographer *)photographerWithName:(NSString *)name inManagedObejctContext:(NSManagedObjectContext *)context;
@end
