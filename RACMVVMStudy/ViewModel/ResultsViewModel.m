//
//  ResultsViewModel.m
//  MVVMRACStudy
//
//  Created by apple-new on 2019/5/20.
//  Copyright © 2019 jason. All rights reserved.
//


#import "ResultsViewModel.h"
#import "LinqToObjectiveC.h"
#import "ResultModel.h"

@implementation ResultsViewModel

+ (instancetype)resultsViewModelWithResults:(Results *)results {
    return [[self alloc] initWithResults:results];
}
- (instancetype)initWithResults:(Results *)results {
    if (self = [super init]) {
        _page = 0;
        _pageCount = 20;
        _results = results;
    }
    
    return self;
}
- (RACSignal *)searchSignal:(BOOL)isFirst {
    return [[[[self.results searchSignalWithContent:self.searchContent page:isFirst ? 0 : self.page andCount:self.pageCount] filter:^BOOL(id  _Nullable value) {
        return self.searchContent.length > 0;
    }] map:^id _Nullable(ResultModel *model) {
        return [ResultModel resultWithSuccess:model.success message:model.message dataModel:[model.dataModel linq_select:^id(id item) {
            //转换为viewModel数据
            return [FriendCellViewModel friendCellViewModel:item];
        }]];
    }] doNext:^(ResultModel *model) {
        if (isFirst) {
            self.dataArr = model.dataModel;
            _page = 1;
        } else {
            NSMutableArray *mArr = [NSMutableArray arrayWithArray:self.dataArr];
            [mArr addObjectsFromArray:model.dataModel];
            self.dataArr = [NSArray arrayWithArray:mArr];
            _page++;
        }
    }];
}

- (RACSignal *)searchSignalWithContent:(NSString *)contentString {
    return [[[self.results searchSignalWithContent:contentString page:0 andCount:20] filter:^BOOL(id  _Nullable value) {
        return contentString.length > 0;
    }] map:^id _Nullable(ResultModel *model) {
        return [ResultModel resultWithSuccess:model.success message:model.message dataModel:model.dataModel];
    }] ;
}

- (RACSignal *)didSelectedSignalWithIndex:(NSInteger )index {
    FriendCellViewModel *selectedModel = self.dataArr[index];
    return [selectedModel selectedSignal];
}

@end
