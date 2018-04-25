//
//  CBIPostCell.m
//  CBInstagram
//
//  Created by Mohamad Farhand on 3/6/16.
//  Copyright © 2016 ideveloper. All rights reserved.
//

#import "CBIPostCell.h"

@implementation CBIPostCell

- (void)awakeFromNib {
    // Initialization code
    
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    UITapGestureRecognizer * doubleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTapGesture.numberOfTapsRequired = 2;
    self.postImage.userInteractionEnabled = YES;
    [self.postImage addGestureRecognizer:doubleTapGesture];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.contentView layoutIfNeeded];
//    self.caption.preferredMaxLayoutWidth = self.caption.bounds.size.width;
}



-(void)setupCell
{
    
    if (!self.postImage.image) {
        self.progressView.hidden = NO;
        
        [[CBIDownloadeQueueHandler sharedInstance]requestToDownloadWithToken:self.postEntity.standard_resolution_url];
        [[CBIDownloadeQueueHandler sharedInstance]addDelegate:self delegateQueue:dispatch_get_main_queue()];
        
    }
    else
    {
        self.progressView.hidden = YES;
    }

}

-(void)configureCell
{
    
    
    float w = self.postEntity.width.floatValue;
    float h = self.postEntity.height.floatValue;
    float WD = [UIScreen mainScreen].bounds.size.width;
    float scaleFactor = WD / w;
    float newHeight = h * scaleFactor;
    float newWidth = w * scaleFactor;
    self.widthConstraint.constant = newWidth;
    self.heightConstraint.constant = newHeight;
    [self updateConstraints];
    
    self.caption.text = self.postEntity.text;
    self.postImage.image = [[CBIImageCache sharedInstance] getImageByToken:self.postEntity.standard_resolution_url];
    
//    self.topCaptionConstraint.constant = 420;

    
    }


-(void)downloadContintueWithProgress:(NSProgress *)progress forToken:(NSString *)token
{
    if ([self.postEntity.standard_resolution_url isEqualToString:token]) {
        
        NSLog(@"%f",progress.fractionCompleted);
        self.progressView.progress = progress.fractionCompleted;
    }
}

-(void)downloadDidFinishedWithToken:(NSString *)token withFileName:(NSString *)filename
{
    
    if ([self.postEntity.standard_resolution_url isEqualToString:token]) {
        
        self.postImage.image = [[CBIImageCache sharedInstance]getImageByToken:token];
    }
}

-(void)handleDoubleTap:(UIGestureRecognizer*)gest
{
    NSLog(@"\nLike");
    UIImageView * heartPopup = [[UIImageView alloc]initWithFrame:CGRectMake((self.postImage.frame.size.width/2)-32, (self.postImage.frame.size.height/2)-32, 64, 64)];
    [heartPopup setImage:[UIImage imageNamed:@"like"]];
    heartPopup.alpha = 0;
    [self addSubview:heartPopup];
    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        heartPopup.transform = CGAffineTransformMakeScale(1.3, 1.3);
        heartPopup.alpha = 1.0;
    }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.1f delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                             heartPopup.transform = CGAffineTransformMakeScale(1.0, 1.0);
                         }
                                          completion:^(BOOL finished) {
                                              [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                                                  heartPopup.transform = CGAffineTransformMakeScale(1.3, 1.3);
                                                  heartPopup.alpha = 0.0;
                                              }
                                                               completion:^(BOOL finished) {
                                                                   heartPopup.transform = CGAffineTransformMakeScale(1.0, 1.0);
                                                               }];
                                          }];
                     }];
}

-(MRCircularProgressView *)progressView
{
    if (!_progressView) {
        _progressView = [[MRCircularProgressView alloc]init];
        _progressView.center = self.postImage.center;
        _progressView.tintColor = [UIColor whiteColor];
        _progressView.backgroundColor = [UIColor lightGrayColor];
    }
    _progressView.tintColor = [UIColor colorWithRed:64.0/255.0 green:171.0/255.0 blue:238.0/255.0 alpha:1.0];
    _progressView.backgroundColor = [UIColor clearColor];
    _progressView.borderWidth = 2.0;
    
    _progressView.progress = 0.0f;
    _progressView.valueLabel.hidden = YES;
    return _progressView;
}

@end
