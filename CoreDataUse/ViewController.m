//
//  ViewController.m
//  CoreDataUse
//
//  Created by zezefamily on 15/12/3.
//  Copyright © 2015年 zezefamily. All rights reserved.
//



/*
 
 使用说明注意
 
 1.Classes文件夹中，lib文件必须添加，CoreDataFile文件夹中是Coredata文件(Command+N创建,自定义),需要注意的是Coredata文件名要与CoreDataManager.h中宏定义的文件明一致，CoreData，这样Coredata环境搭建完成；
 
 2.Model文件夹为需要增,删,改,查的数据模型,需要在Coredata文件中配置生成(Add Entity ->给新建的Entity 添加字段 -> 选中新建的Entity,点击Editor->Create NSManagedObject SubClass创建生成 xxx,xxx+CoreDataProperties.x),且要同ZZSQLite中的model保持一致；
 
 3.具体的增删改查操作在ViewController.m 中 ，请参考；
 
 
 */
#define CoreDataModelName @"Personal"

#import "ViewController.h"
#import "ZZSQLite.h"
#import "Personal+CoreDataProperties.h"
#import "Personal.h"

#import "SaveModel.h"

@interface ViewController ()
{
    ZZSQLite *zzSql;
}
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    zzSql = [[ZZSQLite alloc]init];
    
    self.dataArr = [NSMutableArray array];
    
    [self getDataList];
}

- (IBAction)btnClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 100:
        {
            //            增
            [self addData];
            
            [self getDataList];
            
        }
            break;
        case 101:
        {
            if(self.dataArr.count == 0){
                
                return;
            }
            //        删
            [self deleteData];
            
            [self getDataList];
        }
            break;
        case 102:
        {
            if(self.dataArr.count == 0){
                
                return;
            }
            //        改
            [self editData];
            [self getDataList];
            
        }
            break;
        default:
        {
            //    查
            [self getDataList];
        }
            break;
    }
    
    
}



/*
 改
 */
- (void)editData
{
//    默认修改第一个
    Personal *preson = self.dataArr[0];
    preson.name = @"修改为屁屁";
    [zzSql editDataWithModel:preson Success:^(NSString *successStr) {
        
        NSLog(@"successStr== %@",successStr);
        
    } failed:^(NSError *error) {
        
    }];
    
}

/*
 删
 */
- (void)deleteData
{
    
//    我删除了第一个
    Personal *person = self.dataArr[0];
    [zzSql deleteDataWithModel:person Success:^(NSString *successStr) {
        
        NSLog(@"success");
        
    } failed:^(NSError *error) {
        
    }];
}

/*
 增
 */
- (void)addData
{
    
//    SaveModel *stu1 = [[SaveModel alloc]init];
//    stu1.name = [NSString stringWithFormat:@"泽泽%d",arc4random()];
    
    Personal *personal = [zzSql createDataModelWithDataName:CoreDataModelName];
    personal.name = [NSString stringWithFormat:@"泽泽%d",arc4random()];
    
    [zzSql insertDataSuccess:^(NSString *str) {
       
        NSLog(@"str == %@",str);
        
    } failed:^(NSError *error) {
        
    }];
    
//    [zzSql insertDataWithName:CoreDataModelName Model:stu1 success:^(NSString *str) {
//        NSLog(@"str == %@",str);
//    } failed:^(NSError *error) {
//        NSLog(@"failure");
//    }];
    
}

/*
 查
 */
- (void)getDataList
{
    [zzSql retrievalDataWithEntityName:CoreDataModelName DescriptorForKey:@"name" Result:^(NSArray *result) {
        
        [self.dataArr removeAllObjects];
        NSLog(@"result == %@",result);
        
        [self.dataArr addObjectsFromArray:result];
        if(self.dataArr.count == 0){
            
            self.titlelabel.text = [NSString stringWithFormat:@"没有数据"];
            
            return;
        }
        
        Personal *model = self.dataArr[0];
        self.titlelabel.text = [NSString stringWithFormat:@"共找到%ld个数据,第一个name=%@",self.dataArr.count,model.name];
        
        
    } error:^(NSError *error) {
        NSLog(@"failure");
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
