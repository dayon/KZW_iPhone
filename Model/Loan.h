//
//  Loan.h
//  KZW_iPhoneNew
//
//  Created by Dayon on 15/6/9.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Loan : NSObject
@property (nonatomic, copy) NSString *lessonName;
@property (nonatomic, copy) NSString *loanStatus;
@property (nonatomic, copy) NSString *loanAmount;
@property (nonatomic, copy) NSString *repaymentDate;
@property (nonatomic, copy) NSString *repaymentAmount;
@property (nonatomic, copy) NSString *principal;
@property (nonatomic, copy) NSString *interest;

- (id)initWithParameters:(NSString *)lName andStatus:(NSString *)lStatus andAmount:(NSString *)lAmount andDate:(NSString *)lDate andReAmount:(NSString *)lReAmount andPrincipal:(NSString *)lPrincipal andInterest:(NSString *)lInterest;
@end
