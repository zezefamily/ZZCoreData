//
//  Personal+CoreDataProperties.h
//  CoreDataUse
//
//  Created by zezefamily on 15/12/3.
//  Copyright © 2015年 zezefamily. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Personal.h"

NS_ASSUME_NONNULL_BEGIN

@interface Personal (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;

@end

NS_ASSUME_NONNULL_END
