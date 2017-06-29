//
//  CustomView.h
//  Reactive Demo
//
//  Created by liushaohua on 2016/10/20.
//  Copyright © 2016年 liushaohua. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CustomViewDelagate <NSObject>

- (void)CustomViewTapClick;

@end

@interface CustomView : UIView

@property (nonatomic,weak) id<CustomViewDelagate> delegate;

@end
