//
//  CCCapturingButton.m
//  CCBeautifulCamera
//
//  Created by CC老师 on 2019/6/24.
//  Copyright © 2019年 CC老师. All rights reserved.
//

#import "CCCapturingButton.h"

@interface CCCapturingButton ()

@property (nonatomic, strong) UIView *recordStopView;  // 录制视频暂停控件

@end

@implementation CCCapturingButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

#pragma mark - Public

#pragma mark - Private

- (void)commonInit {
    self.capturingState = CCCapturingButtonStateNormal;
    [self setupUI];
    [self addActions];
}

- (void)setupUI {
    [self setImage:[UIImage imageNamed:@"btn_capture"]
          forState:UIControlStateNormal];
    [self setupRecordStopView];
}

- (void)setupRecordStopView {
    self.recordStopView = [[UIView alloc] init];
    self.recordStopView.userInteractionEnabled = NO;
    self.recordStopView.alpha = 0;
    self.recordStopView.layer.cornerRadius = 5;
    self.recordStopView.backgroundColor = ThemeColor;
    [self addSubview:self.recordStopView];
    [self.recordStopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
}

- (void)addActions {
    [self addTarget:self action:@selector(touchUpInsideAction:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Custom Accessor

- (void)setCapturingState:(CCCapturingButtonState)capturingState {
    _capturingState = capturingState;
    
    [self.recordStopView setHidden:capturingState == CCCapturingButtonStateNormal
                          animated:YES
                        completion:NULL];
}

#pragma mark - Actions

- (void)touchUpInsideAction:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(capturingButtonDidClicked:)]) {
        [self.delegate capturingButtonDidClicked:self];
    }
}

@end
