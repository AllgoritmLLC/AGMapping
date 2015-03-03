//
//  AGMyClass.h
//  AGMappingExamples
//
//  Created by user on 02/03/15.
//  Copyright (c) 2015 Allgoritm LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AGMyClass : UINavigationItem

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSNumber *number;
@property (nonatomic, strong) NSString *string;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) AGMyClass *objInner;

@end
