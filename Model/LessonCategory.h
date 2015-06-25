//
//  LessonCategory.h
//  KZW_iPhoneNew
//
//  Created by Dayon on 15/5/20.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LessonCategory : NSObject
@property (nonatomic, assign) NSInteger cateId;
@property (nonatomic, copy) NSString *title;


- (id)initWithParameters:(NSInteger)lID andTitle:(NSString *)lTitle;
@end
