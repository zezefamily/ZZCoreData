//
//  ZZSQLite.h
//  CoreDataUseDemo
//
//  Created by zezefamily on 15/6/9.
//  Copyright (c) 2015年 zezefamily. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Personal.h"
#import "SaveModel.h"

@interface ZZSQLite : NSObject


/***
 查
    此处查找本地数据库中的所有数据
 @function 查找本地数据库中的所有数据
 @param name        设置要检索类型实体对象
 @param key         指定对结果的排序方式
 @param resultArr   获取数据请求 返回数组
 @param resultError 获取失败错误信息
 
*/
- (void)retrievalDataWithEntityName:(NSString *)name DescriptorForKey:(NSString *)key Result:(void(^)(NSArray *result))resultArr error:(void(^)(NSError *error))resultError;

/*
 按照条件查询
 @param name        设置要检索类型实体对象
 @param predicate   查询条件谓词
 */
- (void)retrievalDataWithEntityName:(NSString *)name predicate:(NSPredicate *)predicate Result:(void (^)(NSArray *))resultArr error:(void (^)(NSError *))resultError;

/***
 
 增
 
 插入一个数据到本地数据库
 @function 插入一个数据到本地数据库
 @param name        对应coreData 创建的Model类名
 @param successStr  插入成功返回字符串
 @param failedErr   插入失败返回错误信息
 
*/

- (Personal *)createDataModelWithDataName:(NSString *)name;
- (void)insertDataSuccess:(void (^)(NSString *str))successStr failed:(void (^)(NSError *error))failedErr;
/*
 @param model       为coreData 创建的数据模型
- (void)insertDataWithName:(NSString *)name Model:(SaveModel *)model success:(void(^)(NSString *str))successStr failed:(void(^)(NSError *error))failedErr;
*/


/***
 
 删
 
 删除本地数据库中的数据
 @function 删除本地数据库中的数据
 @param model        要删除的数据
 @param str          删除成功返回str
 @param failedError  删除失败返回错误信息
 */
- (void)deleteDataWithModel:(Personal *)model Success:(void(^)(NSString *successStr))str failed:(void(^)(NSError *error))failedError;



/***
 
 改
 
 编辑本地数据库中的数据
 @function 编辑本地数据库中的数据
 @param model       编辑好的数据Model
 @param successStr  编辑成功返回
 @param failedErr   编辑失败返回
*/
- (void)editDataWithModel:(Personal *)model Success:(void(^)(NSString *successStr))successStr failed:(void(^)(NSError *error))failedErr;



@end
