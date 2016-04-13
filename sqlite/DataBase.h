//
//  DataBase.h
//  sqlite
//
//  Created by tongle on 16/4/13.
//  Copyright © 2016年 tongle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface DataBase : NSObject
//{
//    sqlite3*db;
//}
+ (sqlite3 *)openDB;
+(void)closeDB;
@end
