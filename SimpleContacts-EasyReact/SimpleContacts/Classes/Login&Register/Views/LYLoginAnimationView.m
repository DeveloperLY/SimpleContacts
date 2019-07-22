//   
//	LYLoginAnimationView.m
//  SimpleContacts
//   
//  Created by LiuY on 2019/7/19
//  Copyright © 2019 DeveloperLY. All rights reserved.
//

#import "LYLoginAnimationView.h"

@interface LYLoginAnimationView ()

@property (nonatomic, weak) IBOutlet UIImageView *leftArm;

@property (nonatomic, weak) IBOutlet UIImageView *rightArm;

@property (nonatomic, weak) IBOutlet UIImageView *rightHand;

@property (nonatomic, weak) IBOutlet UIImageView *leftHand;

@property (nonatomic, weak) IBOutlet UIView *loginIconView;


@property (nonatomic, assign) CGFloat offsetRX;

@property (nonatomic, assign) CGFloat offsetRY;

@property (nonatomic, assign) CGFloat offsetLX;

@property (nonatomic, assign) CGFloat offsetLY;

@end

@implementation LYLoginAnimationView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUp];
}

- (void)setUp {
    self.offsetRX = CGRectGetMaxX(self.loginIconView.frame) - self.rightArm.frame.origin.x - self.rightHand.bounds.size.width;
    self.offsetRY = CGRectGetHeight(self.loginIconView.frame) - self.leftArm.frame.origin.y;
    self.offsetLX = -self.leftArm.frame.origin.x;
    self.offsetLY = CGRectGetHeight(self.loginIconView.frame) - self.leftArm.frame.origin.y;
    self.rightArm.transform = CGAffineTransformMakeTranslation(self.offsetRX, self.offsetRY);
    self.leftArm.transform = CGAffineTransformMakeTranslation(self.offsetLX, self.offsetLY);
}

- (void)startAnim:(BOOL)isCoverEye {
    WeakSelf(self);
    if (isCoverEye) {
        [UIView animateWithDuration:.5 animations:^{
            weakself.leftArm.transform = CGAffineTransformIdentity;
            weakself.rightArm.transform = CGAffineTransformIdentity;
            
            CGAffineTransform transfromL = CGAffineTransformMakeTranslation(-weakself.offsetLX, -weakself.offsetLY + 5);
            weakself.leftHand.transform = CGAffineTransformScale(transfromL, 0.01, 0.01);
            
            CGAffineTransform transfromR = CGAffineTransformMakeTranslation(-weakself.offsetRX, -weakself.offsetRY + 5);
            weakself.rightHand.transform = CGAffineTransformScale(transfromR, 0.01, 0.01);
        }];
    } else {
        [UIView animateWithDuration:.5 animations:^{
            weakself.rightArm.transform = CGAffineTransformMakeTranslation(weakself.offsetRX, weakself.offsetRY);
            weakself.leftArm.transform = CGAffineTransformMakeTranslation(weakself.offsetLX, weakself.offsetLY);
            
            CGAffineTransform transfromL = CGAffineTransformIdentity;
            weakself.leftHand.transform = CGAffineTransformScale(transfromL, 1, 1);
            
            CGAffineTransform transfromR = CGAffineTransformIdentity;
            weakself.rightHand.transform = CGAffineTransformScale(transfromR, 1, 1);
        }];
    }
}

@end
