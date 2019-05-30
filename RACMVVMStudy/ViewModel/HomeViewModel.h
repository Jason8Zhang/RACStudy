//
//  HomeViewModel.h
//  MVVMRACStudy
//
//  Created by apple-new on 2019/5/20.
//  Copyright © 2019 jason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Home.h"
#import "FriendCellViewModel.h"
#import "ResultsViewModel.h"
@interface HomeViewModel : NSObject

/**
 控制器标题
 */
@property (copy, nonatomic) NSString *title;
@property (assign, nonatomic, readonly) NSInteger page;
@property (assign, nonatomic, readonly) NSInteger pageCount;
@property (strong, nonatomic, readonly) Home *home;
@property (strong, nonatomic, readonly) RACCommand *logoutCommand;
@property (copy, nonatomic) NSArray<FriendCellViewModel *> *dataArr;
@property (copy, nonatomic) NSArray<FriendCellViewModel *> *searchDataArr;
@property (strong, nonatomic, readonly) ResultsViewModel *resultsViewModel;
@property (strong,nonatomic,readonly) RACCommand *selectedCommand;

- (instancetype)initWithHome:(Home *)home;
- (RACSignal *)pageSignal:(BOOL)isFirst;
- (RACSignal *)didSelectedAtIndex:(NSInteger)index;
@end
