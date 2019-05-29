//
//  NetworkingTool.m
//  MVVMRACStudy
//
//  Created by apple-new on 2019/5/20.
//  Copyright © 2019 jason. All rights reserved.
//

#import "NetworkingTool.h"
#import <UIKit/UIKit.h>
#import <FMDB.h>

//数据库路径
#define K_DatabaseQueue_Path                [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"FriendDatabase.sqlite"]
//好友表名
#define K_Friend_TableName                  @"t_friend"
//用户表名
#define K_User_TableName                    @"t_user"
@implementation NetworkingTool
static FMDatabaseQueue * _databaseQueue;
+(void)initialize {
    _databaseQueue = [FMDatabaseQueue databaseQueueWithPath:K_DatabaseQueue_Path];
    [_databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        if ([db executeUpdate:[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (identifier integer primary key autoincrement, name text not null unique, password text not null);",K_User_TableName]]) {
             NSLog(@"User表创建成功");
            FMResultSet *set = [db executeQuery:[NSString stringWithFormat:@"SELECT COUNT(*) FROM %@;",K_User_TableName]];
            [set next];
            if ([set intForColumnIndex:0] == 0) {
                NSString *sqlString = [NSString stringWithFormat:@"INSERT INTO %@ (name, password) VALUES (?, ?);",K_User_TableName];
                if (![db executeUpdate:sqlString,@"Jiuchabaikaishui", @"123456"]) {
                    NSLog(@"用户添加失败");
                }
            }
        }
        if ([db executeUpdate:[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (identifier integer primary key autoincrement, uin integer not null unique, name text not null, score integer, img text);",K_Friend_TableName]]) {
             NSLog(@"Friend表创建成功");
            FMResultSet *set = [db executeQuery:[NSString stringWithFormat:@"SELECT COUNT(*) FROM %@;",K_Friend_TableName]];
            if ([set intForColumnIndex:0] == 0) {
                NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"]];
                NSError *error = nil;
                NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
                for (NSDictionary *dic in arr) {
                    NSString *sqlString = [NSString stringWithFormat:@"INSERT INTO %@ (uin, name, score, img) VALUES (?, ?, ?, ?)", K_Friend_TableName];
                    if (![db executeUpdate:sqlString,dic[@"uin"], dic[@"name"], dic[@"score"], dic[@"img"]]) {
                        NSLog(@"好友数据插入失败: %@", dic);
                    }
                }

            }
//            if ([db executeUpdate:[NSString stringWithFormat:@"SELECT COUNT(*) FROM %@;",K_User_TableName]]) {
//
//            }
            
        } else {
            NSLog(@"Friend表创建失败");
        }
    }];
}
+ (void)postWithPath:(NSString *)path parameters:(NSDictionary *)parameters completion:(void (^)(BOOL success, NSString *message, id responseObject)) completion {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:1];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
                if ([path isEqualToString:K_Service_Login]) {
                    FMResultSet *set = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ WHERE name = ?",K_User_TableName],parameters[@"userName"]];
                    if ([set next]) {
                        NSString *name = [set stringForColumn:@"name"];
                        NSString *password = [set stringForColumn:@"password"];
                        if ([parameters[@"userName"] isEqualToString:@"Jiuchabaikaishu"]) {//用账号Jiuchabaikaishu模拟网络请求失败
                            completion(NO, @"请求失败", nil);
                        } else {
                            if ([name isEqualToString:parameters[@"userName"]]) {
                                if ([password isEqualToString:parameters[@"passWord"]]) {
                                    completion(YES, @"请求成功", @{@"userName": parameters[@"userName"], @"passWord": parameters[@"passWord"], @"code": @(0), @"message": @"登录成功"});
                                } else {
                                    completion(YES, @"请求成功", @{@"userName": parameters[@"userName"], @"passWord": parameters[@"passWord"], @"code": @(1), @"message": @"密码错误"});
                                }
                            } else {
                                completion(YES, @"请求成功", @{@"userName": parameters[@"userName"], @"passWord": parameters[@"passWord"], @"code": @(2), @"message": @"账号不存在"});
                            }
                            
                        }
                    } else {
                        completion(NO, @"请求失败", nil);
                    }
                } else if ([path isEqualToString:K_Service_Logout]) {
                    FMResultSet *set = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ WHERE name = ?;", K_User_TableName], parameters[@"userName"]];
                    if ([set next]) {
                        NSString *name = [set stringForColumn:@"name"];
                        NSString *password = [set stringForColumn:@"password"];
                        if ([parameters[@"userName"] isEqualToString:@"Jiuchabaikaishu"]) {//用账号Jiuchabaikaishu模拟网络请求失败
                            completion(NO, @"请求失败", nil);
                        } else {
                            if ([name isEqualToString:parameters[@"userName"]]) {
                                if ([password isEqualToString:parameters[@"passWord"]]) {
                                    completion(YES, @"请求成功", @{@"userName": parameters[@"userName"], @"passWord": parameters[@"passWord"], @"code": @(0), @"message": @"退出成功"});
                                } else {
                                    completion(YES, @"请求成功", @{@"userName": parameters[@"userName"], @"passWord": parameters[@"passWord"], @"code": @(1), @"message": @"密码错误"});
                                }
                            } else {
                                completion(YES, @"请求成功", @{@"userName": parameters[@"userName"], @"passWord": parameters[@"passWord"], @"code": @(2), @"message": @"账号不存在"});
                            }
                        }
                    }
                } else if ([path isEqualToString:K_Service_SearchFriends]){
                    FMResultSet *set = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ LIMIT %zi, %zi;", K_Friend_TableName, [parameters[@"page"] integerValue]*[parameters[@"count"] integerValue], [parameters[@"count"] integerValue]]];
                    NSMutableArray *mArr = [NSMutableArray arrayWithCapacity:1];
                    while ([set next]) {
                        [mArr addObject:@{@"uin": @([set intForColumn:@"uin"]), @"name": [set stringForColumn:@"name"], @"img": [set stringForColumn:@"img"]}];
                    }
                    
                    completion(YES, @"请求成功", mArr);
                } else if ([path isEqualToString:K_Service_PageFriends]){
                    FMResultSet *set = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ WHERE name LIKE ? OR uin LIKE ? LIMIT %zi, %zi;", K_Friend_TableName, [parameters[@"page"] integerValue]*[parameters[@"count"] integerValue], [parameters[@"count"] integerValue]], [NSString stringWithFormat:@"%%%@%%", parameters[@"searchContent"]], [NSString stringWithFormat:@"%%%@%%", parameters[@"searchContent"]]];
                    NSMutableArray *mArr = [NSMutableArray arrayWithCapacity:1];
                    while ([set next]) {
                        [mArr addObject:@{@"uin": @([set intForColumn:@"uin"]), @"name": [set stringForColumn:@"name"], @"img": [set stringForColumn:@"img"]}];
                    }
                    
                    completion(YES, @"请求成功", mArr);
                } else if ([path isEqualToString:K_Service_GetAllFriends]) {
                    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"]];
                    NSError *error = nil;
                    NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
                    if (error) {
                        if (completion) {
                            completion(NO, @"好友获取失败！", nil);
                        }
                    } else {
                        if (completion) {
                            completion(YES, nil, arr);
                        }
                    }
                }
            }];
        });
    });
}

@end
