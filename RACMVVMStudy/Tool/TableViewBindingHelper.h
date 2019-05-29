//
//  TableViewBindingHelper.h
//  MVVMRACStudy
//
//  Created by apple-new on 2019/5/20.
//  Copyright © 2019 jason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>
@interface TableViewBindingHelper : NSObject
+ (instancetype) bindingHelperForTableView:(UITableView *)tableView
                              sourceSignal:(RACSignal *)source
                          selectionCommand:(RACCommand *)selection;

- (instancetype)initWithTableView:(UITableView *)tableView
                     sourceSignal:(RACSignal *)source
                 selectionCommand:(RACCommand *)selection;
@end
