//
//  ZZSQLite.m
//  CoreDataUseDemo
//
//  Created by zezefamily on 15/6/9.
//  Copyright (c) 2015年 zezefamily. All rights reserved.
//

#import "ZZSQLite.h"
#import <CoreData/CoreData.h>
#import "CoreDataManager.h"
@interface ZZSQLite ()
{
    
}
@property (nonatomic,strong) CoreDataManager *manager;
@end
@implementation ZZSQLite

- (id)init
{
    self = [super init];
    if (self) {
        
        _manager = [CoreDataManager sharedCoreDataManager];
        
    }
    return self;
}

- (void)retrievalDataWithEntityName:(NSString *)name predicate:(NSPredicate *)predicate Result:(void (^)(NSArray *))resultArr error:(void (^)(NSError *))resultError
{
    //    数据库  查
    //    创建取回数据请求
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    //    设置要检索类型实体对象
    NSEntityDescription *entity = [NSEntityDescription entityForName:name inManagedObjectContext:_manager.managerObjectContext];
    //    设置请求实体
    [request setEntity:entity];
    //    谓词按条件查
    [request setPredicate:predicate];
    
    NSError *error = nil;
    //    获取数据请求 返回数组
    NSArray *fetchResult = [_manager.managerObjectContext executeFetchRequest:request error:&error];
    resultArr(fetchResult);
    
    if(!fetchResult){
        //NSLog(@"error == %@ , %@",error,[error userInfo]);
        resultError(error);
    }
}

- (void)retrievalDataWithEntityName:(NSString *)name DescriptorForKey:(NSString *)key Result:(void(^)(NSArray *result))resultArr error:(void(^)(NSError *error))resultError
{
    //    数据库  查
    //    创建取回数据请求
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    //    设置要检索类型实体对象
    NSEntityDescription *entity = [NSEntityDescription entityForName:name inManagedObjectContext:_manager.managerObjectContext];
    //    设置请求实体
    [request setEntity:entity];
    
    //    指定对结果的排序方式
//    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:key ascending:NO];
//    NSArray *sortDescriptions = [[NSArray alloc]initWithObjects:sortDescriptor, nil];
//    [request setSortDescriptors:sortDescriptions];
    
    
    NSError *error = nil;
    //    获取数据请求 返回数组
    NSArray *fetchResult = [_manager.managerObjectContext executeFetchRequest:request error:&error];
    resultArr(fetchResult);
    
    if(!fetchResult){
        //NSLog(@"error == %@ , %@",error,[error userInfo]);
        resultError(error);
    }
}


- (Personal *)createDataModelWithDataName:(NSString *)name
{
    Personal * saveModel = [NSEntityDescription insertNewObjectForEntityForName:name inManagedObjectContext:[CoreDataManager sharedCoreDataManager].managerObjectContext];
    return saveModel;
}

- (void)insertDataSuccess:(void (^)(NSString *str))successStr failed:(void (^)(NSError *error))failedErr
{
    NSError *error = nil;
    BOOL isSaveSuccess = [[CoreDataManager sharedCoreDataManager].managerObjectContext save:&error];
    if(!isSaveSuccess){
        NSLog(@"Error:%@,%@",error,[error userInfo]);
        failedErr(error);
    }else {
        //NSLog(@"save successful");
        successStr(@"save successful");
    }
}


- (void)deleteDataWithModel:(Personal *)model Success:(void(^)(NSString *successStr))str failed:(void(^)(NSError *error))failedError
{
    [[CoreDataManager sharedCoreDataManager].managerObjectContext deleteObject:model];
    NSError *error = nil;
    BOOL isSaveSuccess = [[CoreDataManager sharedCoreDataManager].managerObjectContext save:&error];
    if(!isSaveSuccess){
        NSLog(@"error : %@ , %@",error,[error userInfo]);
        failedError(error);
    }else {
        //NSLog();
        str(@"delete successful");
    }
}

- (void)editDataWithModel:(Personal *)model Success:(void(^)(NSString *successStr))successStr failed:(void(^)(NSError *error))failedErr
{
    NSError *error = nil;
    //    托管对象准备好后，调用托管对象上下文的save方法将数据写入数据库
    BOOL isSaveSuccess = [[CoreDataManager sharedCoreDataManager].managerObjectContext save:&error];
    if(!isSaveSuccess){
        NSLog(@"Error : %@,%@",error,[error userInfo]);
        failedErr(error);
    }else {
        successStr(@"Change successful");
    }
}



/*
 
 //    谓词按条件查
 // NSPredicate *cate = [NSPredicate predicateWithFormat:@"name=%@",@"zeze"];
 
 按照条件查询
 
 Format：
 
 (1)比较运算符>,<,==,>=,<=,!=
 可用于数值及字符串
 例：@"number > 100"
 
 
 (2)范围运算符：IN、BETWEEN
 例：@"number BETWEEN {1,5}"
 @"address IN {'shanghai','beijing'}"
 
 
 (3)字符串本身:SELF
 例：@“SELF == ‘APPLE’"
 
 
 (4)字符串相关：BEGINSWITH、ENDSWITH、CONTAINS
 例：@"name CONTAIN[cd] 'ang'" //包含某个字符串
 @"name BEGINSWITH[c] 'sh'" //以某个字符串开头
 @"name ENDSWITH[d] 'ang'" //以某个字符串结束
 注:  [c]不区分大小写；
     [d]不区分发音符号即没有重音符号；
     [cd]既不区分大小写，也不区分发音符号。
 
 
 (5)通配符：LIKE
 例：@"name LIKE[cd] '*er*'" //*代表通配符,Like也接受[cd].
 @"name LIKE[cd] '???er*'"
 
 
 (6)正则表达式：MATCHES
 例：NSString *regex = @"^A.+e$"; //以A开头，e结尾
 @"name MATCHES %@",regex
 */


@end
