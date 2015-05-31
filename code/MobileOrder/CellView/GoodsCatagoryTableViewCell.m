//
//  GoodsCatagoryTableViewCell.m
//  MobileOrder
//
//  Created by cszhan on 15-5-30.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import "GoodsCatagoryTableViewCell.h"
#import "NSString+Ex.h"

#define kGoodCatagoryPendingY     15.f
#define kGoodCatagoryPendingX     5.f

#define kGoodCatagoryDefaultHeight  50.f

#define kGoodCatagoryRatio      (1/4.f)

#define kGoodCatagoryWidth  kDeviceScreenWidth*kGoodCatagoryRatio-2*kGoodCatagoryPendingX

@interface  GoodsCatagoryTableViewCell (){

    CGFloat _cellHeight;
    
}

@property (nonatomic, strong) UIView   *selLineLabel;

@end

@implementation GoodsCatagoryTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)dealloc {
    self.selLineLabel = nil;
    self.titleLable = nil;
    SuperDealloc;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *titleLabel = [UIComUtil createLabelWithFont:kGoodCatagoryTextFont
                                               withTextColor:kGoodCatagoryTextColor
                                                    withText:@""
                                                   withFrame:CGRectMake(kGoodCatagoryPendingX, kGoodCatagoryPendingY,kGoodCatagoryWidth,kGoodCatagoryDefaultHeight-2*kGoodCatagoryPendingY)];
        
        //titleLabel.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:titleLabel];
        self.titleLable = titleLabel;
        CGFloat leftX = kDeviceScreenWidth*kGoodCatagoryRatio-2.f;
        UIView *selLine = [UIComUtil createSplitViewWithFrame:CGRectMake(leftX,0,2.f,titleLabel.frame.size.height)
                                                    withColor:[UIColor redColor]];
        [self.contentView addSubview:selLine];
        
        self.selLineLabel = selLine;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)getCellDefaultHeight {

    return kGoodCatagoryDefaultHeight;
}

+ (CGFloat)getCellHeightWithText:(NSString*)txt withWidth:(CGFloat)width {
    
    CGFloat height = [txt sizeWithWidth:width withTextAttribute:@{NSFontAttributeName:kGoodCatagoryTextFont}].height;
    height = height+2*kGoodCatagoryPendingY;
    if(height<kGoodCatagoryDefaultHeight)
        height = kGoodCatagoryDefaultHeight;
    return height;
}
+ (CGFloat)getCellHeightWithText:(NSString*)txt {
    
    CGFloat height = [txt sizeWithWidth:kGoodCatagoryWidth withTextAttribute:@{NSFontAttributeName:kGoodCatagoryTextFont}].height;
    height = height+2*kGoodCatagoryPendingY;
    if(height<kGoodCatagoryDefaultHeight)
        height = kGoodCatagoryDefaultHeight;
    return height;
}

- (void)updateCellUI {
    CGFloat contentHeight = [[self class] getCellHeightWithText:self.titleLable.text withWidth:self.frame.size.width];
    CGRect newRect = self.frame;
    newRect.size.height = contentHeight;
    //if(contentHeight>kGoodCatagoryDefaultHeight)
    self.frame = newRect;
    //[self setNeedsLayout];
}

- (void)updateCellUIWithHeight:(CGFloat)height {

    _cellHeight = height;
    
    CGRect newRect = self.frame;
    newRect.size.height = height;
    //if(contentHeight>kGoodCatagoryDefaultHeight)
    self.frame = newRect;
    
}
- (void)setCellSelectedStatus:(BOOL)status {
    
    self.selLineLabel.hidden = !status;
    if(status){
        self.titleLable.textColor = kGoodCatagorySelectedTextColor;
    }else {
        self.titleLable.textColor = kGoodCatagoryTextColor;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if(_cellHeight == 0)
        [self updateCellUI];
    self.titleLable.frame = CGRectMake(kGoodCatagoryPendingX,kGoodCatagoryPendingY,self.frame.size.width-2*kGoodCatagoryPendingX,self.frame.size.height-2*kGoodCatagoryPendingY);
}

@end
