//
//  ViewController.m
//  sqlite
//
//  Created by tongle on 16/4/13.
//  Copyright © 2016年 tongle. All rights reserved.
//

#import "ViewController.h"
#import "Sqlite.h"
#import "Student.h"
#import "DatabaseCenter.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    Sqlite * slite = [[Sqlite alloc]init];
//    [slite keepSqlite];
    UIButton * addBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 30, 30)];
    [addBtn setBackgroundColor:[UIColor blueColor]];
    [addBtn addTarget:self action:@selector(addSqlite) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
    UIButton * deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(140, 100, 30, 30)];
    [deleteBtn setBackgroundColor:[UIColor redColor]];
    [deleteBtn addTarget:self action:@selector(deleteSqlite) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteBtn];
    UIButton * insetBtn = [[UIButton alloc]initWithFrame:CGRectMake(180, 100, 30, 30)];
    [insetBtn setBackgroundColor:[UIColor greenColor]];
    [insetBtn addTarget:self action:@selector(insetSqlite) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:insetBtn];
    UIButton * updateBtn = [[UIButton alloc]initWithFrame:CGRectMake(220, 100, 30, 30)];
    [updateBtn setBackgroundColor:[UIColor orangeColor]];
    [updateBtn addTarget:self action:@selector(updateSqlite) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:updateBtn];
}
-(void)addSqlite
{
    
    NSMutableArray * array = [DatabaseCenter getAllStudents];
    for (Student * stu in array) {
        NSLog(@"--%@",stu);
    }
}
-(void)deleteSqlite
{
    [DatabaseCenter deleteStudentWithID:5];
    NSLog(@"---");
}
-(void)insetSqlite
{
    Student * stu = [[Student alloc]init];
    stu.name = @"tongle";
    stu.sex = @"man";
    stu.age = 22;
    BOOL result = [DatabaseCenter insertStudent:stu];
    NSLog(@"----%d",result);
}
-(void)updateSqlite
{
    [DatabaseCenter updateStudentName:@"..." byID:5];
    NSLog(@"-----");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
