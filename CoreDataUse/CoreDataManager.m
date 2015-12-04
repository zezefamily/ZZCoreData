//
//  CoreDataManager.m
//  CoreDataUseDemo
//
//  Created by zezefamily on 15/6/6.
//  Copyright (c) 2015年 zezefamily. All rights reserved.
//

#import "CoreDataManager.h"

@implementation CoreDataManager

@synthesize managerObjectContext =_managerObjectContext;
@synthesize managerObjModel = _managerObjModel;
@synthesize perStroeCoordinator = _perStroeCoordinator;

static CoreDataManager *coredataManager;

+ (instancetype)sharedCoreDataManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        coredataManager = [[self alloc]init];
    });
    return coredataManager;
}

//getter方法
-(NSManagedObjectModel *)managerObjModel
{
    if(_managerObjModel != nil){
        return _managerObjModel;
    }
    NSURL *modelUrl = [[NSBundle mainBundle]URLForResource:ManagerObjectModelFileName withExtension:@"momd"];
    _managerObjModel = [[NSManagedObjectModel alloc]initWithContentsOfURL:modelUrl];
    NSLog(@"model == %@",modelUrl);
    NSLog(@"Model== %@",_managerObjModel);
    return _managerObjModel;
}

//被管理的上下文：操作实际内容
- (NSManagedObjectContext *)managerObjectContext
{
    if(_managerObjectContext != nil){
        return _managerObjectContext;
    }
//    数据库连接器
    NSPersistentStoreCoordinator *coordinator = [self perStroeCoordinator];
    if(coordinator != nil){
        _managerObjectContext = [[NSManagedObjectContext alloc]init];
        [_managerObjectContext setPersistentStoreCoordinator:coordinator];
    }
    
    return _managerObjectContext;
}

-(NSPersistentStoreCoordinator *)perStroeCoordinator
{
    if(_perStroeCoordinator != nil){
        return _perStroeCoordinator;
    }
//    在目录下拿到 数据库文件
    NSURL *storeURL = [[self applicationDocumentsDirectory]URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite",ManagerObjectModelFileName]];
    NSLog(@"path == %@",storeURL.path);
    NSError *error = nil;
    _perStroeCoordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:[self managerObjModel]];
    
    if(![_perStroeCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]){
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"无法初始化应用程序保存数据";
        dict[NSLocalizedFailureReasonErrorKey] = @"有一个错误，创建或加载应用程序保存数据";
        dict[NSUnderlyingErrorKey] = error;
        
        error = [NSError errorWithDomain:@"发生错误" code:9999 userInfo:dict];
        
        NSLog(@"error == %@,%@",error,[error userInfo]);
        
//        异常终止一个进程
        abort();
        
    }
    
    return _perStroeCoordinator;
}


// 打开应用程序的文件目录
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager]URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask]lastObject];
}

//保存数据
- (void)saveContext
{
    NSManagedObjectContext *managedObjectContext = self.managerObjectContext;
    if(managedObjectContext != nil){
        NSError *error = nil;
        if([managedObjectContext hasChanges]&& ![managedObjectContext save:&error]){
            //        替换此实现的代码处理错误。
            //        abort()导致应用产生崩溃日志和终止。你不应该在航运中的应用使用该功能，尽管它在开发过程中可能是有用的。
            
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }

        
    }
    
}


@end
