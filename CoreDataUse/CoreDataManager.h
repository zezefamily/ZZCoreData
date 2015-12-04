//
//  CoreDataManager.h
//  CoreDataUseDemo
//
//  Created by zezefamily on 15/6/6.
//  Copyright (c) 2015年 zezefamily. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


#warning
#pragma mark - 定义文件路径名称
/*
 fileName 根据不同需求自定义（创建的DataModel名）
 */
#define ManagerObjectModelFileName @"TestModel"


//该文件夹下无需修改任何地方

@interface CoreDataManager : NSObject

@property (readonly,strong,nonatomic) NSManagedObjectContext *managerObjectContext;
@property (readonly,strong,nonatomic) NSManagedObjectModel *managerObjModel;
@property (readonly,strong,nonatomic) NSPersistentStoreCoordinator *perStroeCoordinator;

+ (instancetype)sharedCoreDataManager;
- (void)saveContext;

@end
