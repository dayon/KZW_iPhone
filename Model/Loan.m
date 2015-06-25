//
//  Loan.m
//  KZW_iPhoneNew
//
//  Created by Dayon on 15/6/9.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import "Loan.h"

@implementation Loan
-(id)initWithParameters:(NSString *)lName andStatus:(NSString *)lStatus andAmount:(NSString *)lAmount andDate:(NSString *)lDate andReAmount:(NSString *)lReAmount andPrincipal:(NSString *)lPrincipal andInterest:(NSString *)lInterest{
    
    Loan *loan = [[Loan alloc] init];
    loan.lessonName = lName;
    loan.loanStatus = lStatus;
    loan.loanAmount = lAmount;
    loan.repaymentDate = lDate;
    loan.repaymentAmount = lReAmount;
    loan.principal = lPrincipal;
    loan.interest = lInterest;
    
    return loan;
    
}
@end

