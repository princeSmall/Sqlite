//
//  Sqlite.m
//  sqlite
//
//  Created by tongle on 16/4/13.
//  Copyright © 2016年 tongle. All rights reserved.
//

#import "Sqlite.h"
#define DENAME    @"personinfo.sqlite"
#define NAME      @"name"
#define AGE       @"age"
#define ADDRESS   @"address"
#define TABLENAME @"PERSONINFO"


@implementation Sqlite
-(void)keepSqlite{
NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
NSString * documents = [paths objectAtIndex:0];
NSString * database_path = [documents stringByAppendingPathComponent:DENAME];
if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK) {
    sqlite3_close(db);
    NSLog(@"数据库打开失败");
}
NSString *sqlCreateTable = @"CREATE TABLE IF NOT EXISTS PERSONINFO (ID INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER, address TEXT)";
[self excelSql:sqlCreateTable];
NSString *sql1 = [NSString stringWithFormat:
                  @"INSERT INTO '%@' ('%@', '%@', '%@') VALUES ('%@', '%@', '%@')",
                  TABLENAME, NAME, AGE, ADDRESS, @"张三", @"23", @"西城区"];

NSString *sql2 = [NSString stringWithFormat:
                  @"INSERT INTO '%@' ('%@', '%@', '%@') VALUES ('%@', '%@', '%@')",
                  TABLENAME, NAME, AGE, ADDRESS, @"老六", @"20", @"东城区"];
[self excelSql:sql1];
[self excelSql:sql2];
[self lookSql];
}
-(void)excelSql:(NSString*)sql
{
    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库操作数据失败!");
    }
}
-(void)lookSql
{
    NSString *sqlQuery = @"SELECT * FROM PERSONINFO";
    sqlite3_stmt * statement;
    
    if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *name = (char*)sqlite3_column_text(statement, 1);
            NSString *nsNameStr = [[NSString alloc]initWithUTF8String:name];
            
            int age = sqlite3_column_int(statement, 2);
            
            char *address = (char*)sqlite3_column_text(statement, 3);
            NSString *nsAddressStr = [[NSString alloc]initWithUTF8String:address];
            
            NSLog(@"name:%@  age:%d  address:%@",nsNameStr,age, nsAddressStr);
        }
    }
    sqlite3_close(db);
}


@end
