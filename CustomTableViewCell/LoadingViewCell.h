//
//  LoadingViewCell.h
//  KZW_iPhoneNew
//
//  Created by Dayon on 15/5/28.
//  Copyright (c) 2015年 张宁浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loading;
@end
