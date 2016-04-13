//
//  Student.h
//  sqlite
//
//  Created by tongle on 16/4/13.
//  Copyright © 2016年 tongle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Student : NSObject
@property (nonatomic,assign)NSInteger ID;
@property (nonatomic,retain)NSString *name;
@property (nonatomic,retain)NSString *sex;
@property (nonatomic,assign)NSInteger age;
@property (nonatomic,retain)UIImage * photo;


@end
