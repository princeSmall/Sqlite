//
//  DataBase.m
//  sqlite
//
//  Created by tongle on 16/4/13.
//  Copyright © 2016年 tongle. All rights reserved.
//
#define FILE_NAME   @"DataBase.sqlite"
#import "DataBase.h"
//#import <sqlite3.h>
static sqlite3 *db =nil;

@implementation DataBase
+ (sqlite3 *)openDB
{
    if (!db) {
        //1 获取document文件夹的路径
        //参数1: 文件夹的名字 参数2: 查找域 参数3: 是否使用绝对路径
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        //获取数据库文件的路径
        NSString *dbPath = [docPath stringByAppendingPathComponent:FILE_NAME];
        //iOS 中管理文件的类, 负责复制文件, 删除文件, 移动文件
        NSFileManager *fm = [NSFileManager defaultManager];
        //判断document中是否有sqlite文件
        if (![fm fileExistsAtPath:dbPath]) {
            //获取在*.app中sqlite文件的路径
            NSString *boundlePath = [[NSBundle mainBundle] pathForResource:@"DataBase" ofType:@"sqlite"];
            NSError *error = nil;
            //将*.app中sqlite文件复制一份到dbPath
            BOOL result = [fm copyItemAtPath:boundlePath toPath:dbPath error:&error];
            //若复制文件失败, 打印错误信息
            if (!result) {
                NSLog(@"%@", error);
            }
        }
        //打开数据库 参数1: 文件路径(UTF8String可以将OC的NSString转为C中的char) 参数2: 接受数据库的指针
        sqlite3_open([dbPath UTF8String], &db);
    }
    return db;
}

//关闭数据库
+ (void)closeDB
{
    sqlite3_close(db);
    db = nil;
}
@end
