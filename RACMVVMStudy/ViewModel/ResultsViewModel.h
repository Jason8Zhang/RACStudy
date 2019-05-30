//
//  ResultsViewModel.h
//  MVVMRACStudy
//
//  Created by apple-new on 2019/5/20.
//  Copyright © 2019 jason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Results.h"
#import "FriendCellViewModel.h"

@interface ResultsViewModel : NSObject

@property (strong, nonatomic, readonly) Results *results;
@property (assign, nonatomic, readonly) NSInteger page;
@property (assign, nonatomic, readonly) NSInteger pageCount;
@property (copy, nonatomic) NSString *searchContent;
@property (copy, nonatomic) NSArray<FriendCellViewModel *> *dataArr;

+ (instancetype)resultsViewModelWithResults:(Results *)results;
- (instancetype)initWithResults:(Results *)results;
- (RACSignal *)searchSignal:(BOOL)isFirst;
- (RACSignal *)searchSignalWithContent:(NSString *)contentString;
- (RACSignal *)didSelectedSignalWithIndex:(NSInteger )index;
@end

