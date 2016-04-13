//
//  DatabaseCenter.h
//  sqlite
//
//  Created by tongle on 16/4/13.
//  Copyright © 2016年 tongle. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Student;

@interface DatabaseCenter : NSObject
+ (NSMutableArray *)getAllStudents;
+ (Student *)getStudentWithID:(NSInteger)aID;
+ (BOOL)insertStudent:(Student *)aStudent;
+ (BOOL)updateStudentName:(NSString *)aName byID:(NSInteger)aID;
+ (BOOL)deleteStudentWithID:(NSInteger)aID;
@end
