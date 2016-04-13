//
//  DatabaseCenter.m
//  sqlite
//
//  Created by tongle on 16/4/13.
//  Copyright © 2016年 tongle. All rights reserved.
//

#import "DatabaseCenter.h"
#import "sqlite3.h"
#import "Student.h"
#import "DataBase.h"
#import "Sqlite.h"

@implementation DatabaseCenter
//查询所有学生
+ (NSMutableArray *)getAllStudents
{
    //打开数据库
    sqlite3 *db = [DataBase openDB];
    //数据库操作指针 stmt:statement
    sqlite3_stmt *stmt = nil;
    //验证SQL的正确性 参数1: 数据库指针, 参数2: SQL语句, 参数3: SQL语句的长度 -1代表无限长(会自动匹配长度), 参数4: 返回数据库操作指针, 参数5: 为未来做准备的, 预留参数, 一般写成NULL
    int result = sqlite3_prepare_v2(db, "select * from Student", -1, &stmt, NULL);
    NSMutableArray *studentArr = [NSMutableArray array];
    //判断SQL执行的结果
    if (result == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {//存在一行数据
            //列数从0开始
            int ID = sqlite3_column_int(stmt, 0);
            const unsigned char *name = sqlite3_column_text(stmt, 1);
            const unsigned char *sex = sqlite3_column_text(stmt, 2);
            int age = sqlite3_column_int(stmt, 3);
            //blob类型的获取
            //1 获取长度
            int length = sqlite3_column_bytes(stmt, 4);
            //2 获取数据
            const void *photo = sqlite3_column_blob(stmt, 4);
            //3 转成NSData
            NSData *photoData = [NSData dataWithBytes:photo length:length];
            //4 转成UIImage
            UIImage *image = [UIImage imageWithData:photoData];
            //封装Student模型
            Student *student = [[Student alloc] init];
            student.ID = ID;
            student.name = [NSString stringWithUTF8String:(const char *)name];
            student.sex = [NSString stringWithUTF8String:(const char *)sex];
            student.age = age;
            student.photo = image;
            //添加到数组
            [studentArr addObject:student];
        }
    }
    //释放stmt指针
    sqlite3_finalize(stmt);
    //关闭数据库
    [DataBase closeDB];
    return studentArr;
}
//查询单个学生
+ (Student *)getStudentWithID:(NSInteger)aID
{
    sqlite3 *db = [DataBase openDB];
    sqlite3_stmt *stmt = nil;
    NSString *sqlStr = [NSString stringWithFormat:@"select * from Student where id = %ld", (long)aID];
    int result = sqlite3_prepare_v2(db, [sqlStr UTF8String], -1, &stmt, NULL);
    Student *student = nil;
    if (result == SQLITE_OK) {
        if (sqlite3_step(stmt) == SQLITE_ROW) {
            int ID = sqlite3_column_int(stmt, 0);
            const unsigned char *name = sqlite3_column_text(stmt, 1);
            const unsigned char *sex = sqlite3_column_text(stmt, 2);
            int age = sqlite3_column_int(stmt, 3);
            int length = sqlite3_column_bytes(stmt, 4);
            const unsigned char *photo = sqlite3_column_blob(stmt, 4);
            NSData *photoData = [NSData dataWithBytes:photo length:length];
            UIImage *image = [UIImage imageWithData:photoData];
            student = [[Student alloc] init];
            student.ID = ID;
            student.name = [NSString stringWithUTF8String:(const char *)name];
            student.sex = [NSString stringWithUTF8String:(const char *)sex];
            student.age = age;
            student.photo = image;
        }
    }
    sqlite3_finalize(stmt);
    [DataBase closeDB];
    return student;
}
//添加一个新学生
+ (BOOL)insertStudent:(Student *)aStudent
{
    sqlite3 *db = [DataBase openDB];
    sqlite3_stmt *stmt = nil;
    NSString *sqlStr = [NSString stringWithFormat:@"insert into Student (name, sex, age) values ('%@', '%@', '%ld')", aStudent.name, aStudent.sex, (long)aStudent.age];
    int result = sqlite3_prepare_v2(db, [sqlStr UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        //判断语句执行完成没有
        if (sqlite3_step(stmt) == SQLITE_DONE) {
            sqlite3_finalize(stmt);
            [DataBase closeDB];
            return YES;
        }
    }
    sqlite3_finalize(stmt);
    [DataBase closeDB];
    return NO;
}
//修改学生的姓名
+ (BOOL)updateStudentName:(NSString *)aName byID:(NSInteger)aID
{
    sqlite3 *db = [DataBase openDB];
    sqlite3_stmt *stmt = nil;
    NSString *sqlStr = [NSString stringWithFormat:@"update Student set name = '%@' where id = %ld", aName, (long)aID];
    int result = sqlite3_prepare_v2(db, [sqlStr UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        if (sqlite3_step(stmt) == SQLITE_ROW) {//觉的应加一个判断, 若有这一行则修改
            if (sqlite3_step(stmt) == SQLITE_DONE) {
                sqlite3_finalize(stmt);
                [DataBase closeDB];
                return YES;
            }
        }
    }
    sqlite3_finalize(stmt);
    [DataBase closeDB];
    return NO;
}
//删除一个学生
+ (BOOL)deleteStudentWithID:(NSInteger)aID
{
    sqlite3 *db = [DataBase openDB];
    sqlite3_stmt *stmt = nil;
    NSString *sqlStr = [NSString stringWithFormat:@"delete from Student where id = %ld", (long)aID];
    int result = sqlite3_prepare_v2(db, [sqlStr UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        if (sqlite3_step(stmt) == SQLITE_ROW) {//觉的应加一个判断, 若有这一行则删除
            if (sqlite3_step(stmt) == SQLITE_DONE) {
                sqlite3_finalize(stmt);
                [DataBase closeDB];
                return YES;
            }
        }
    }
    sqlite3_finalize(stmt);
    [DataBase closeDB];
    return NO;
}
@end
