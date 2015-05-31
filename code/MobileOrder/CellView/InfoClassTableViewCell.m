//
//  InfoClassTableViewCell.m
//  BSTell
//
//  Created by cszhan on 14-2-16.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "InfoClassTableViewCell.h"

@implementation InfoClassTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //self.backgroundView.backgroundColor = [UIColor grayColor];
        UIImageWithFileName(UIImage *image, @"hotmsg_cell_bg.png");
        //
        //self.layer.contents = (id)image.CGImage;
        UIImageView *rightImageBgView = [[UIImageView alloc]initWithImage:image];
        rightImageBgView.frame = CGRectMake(self.frame.size.width-image.size.width/kScale, 0.f,image.size.width/2.f, image.size.height/kScale);
        [self addSubview:rightImageBgView];
        SafeRelease(rightImageBgView);
        
        //for 
        
        UILabel *tmpLabel = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:17.f] withTextColor:[UIColor blackColor] withText:@"" withFrame:CGRectMake(image.size.width/kScale+10.f,0.f, 160.f, 40.f)];
        tmpLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:tmpLabel];
        SafeRelease(tmpLabel);
        self.titleLabel = tmpLabel;
        
        UIImageView *tmpImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        tmpImageView.frame = CGRectMake(0.f, 0.f,image.size.width/kScale, image.size.height/kScale);
        [self addSubview:tmpImageView];
        SafeRelease(tmpImageView);
        self.classImageView = tmpImageView;
        
        
        UIImageWithFileName(image, @"arrow_detail.png");
        
        UIImageView *detailView = [[UIImageView alloc]initWithImage:image];
        detailView.frame = CGRectMake(self.frame.size.width-image.size.width/kScale-10.f, 0.f,image.size.width/2.f, image.size.height/kScale);
        [self addSubview:detailView];
        detailView.center = CGPointMake(detailView.center.x, self.frame.size.height/2.f);
        SafeRelease(detailView);
        
        //self.layer.contents = (id)image.CGImage;
        //UIImageWithFileName(image, @"hotmsg_cell_bg.png");
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
