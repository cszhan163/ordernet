//
//  NoteItemCell.m
//  BSTell
//
//  Created by cszhan on 14-2-1.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "NoteItemCell.h"

#define kNoteLeftPendingX  10.f

#define kNoteLeftPendingY  10.f

@implementation NoteItemCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:(NSString *)reuseIdentifier];
    if (self) {
        // Initialization code
        
        UIImageWithFileName(UIImage* image, @"round.png");
        assert(image);
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        [self addSubview:imageView];
        
        imageView.frame = CGRectMake(kNoteLeftPendingX, kNoteLeftPendingY+5.f, image.size.width/kScale, image.size.width/kScale);
        SafeRelease(imageView);
        
        CGRect rect  = CGRectMake(kNoteLeftPendingX+15.f, kNoteLeftPendingY, 250.f, 30);
        UILabel *label = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:16] withTextColor:[UIColor blackColor] withText:@"1月测试竞拍测试奖牌估计熬好你那d都是嘎山噶" withFrame:rect];
        label.textAlignment = NSTextAlignmentLeft;
        [self addSubview:label];
        self.noteTextLabel = label;
        SafeRelease(label);
        rect  = CGRectMake(kNoteLeftPendingX+15.f, kNoteLeftPendingY+25, 250, 20);
        label = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:12] withTextColor:[UIColor blackColor] withText:@"2014年1月21日        2小时" withFrame:rect];
        label.textAlignment = NSTextAlignmentLeft;
        [self addSubview:label];
        self.noteDetailTextLabel = label;
        SafeRelease(label);
        /*
        UIImageWithFileName(UIImage* image, @"cell_split.line.png");
        assert(image);
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        [self addSubview:imageView];
        */
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
