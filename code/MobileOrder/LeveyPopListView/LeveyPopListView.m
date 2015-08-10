//
//  LeveyPopListView.m
//  LeveyPopListViewDemo
//
//  Created by Levey on 2/21/12.
//  Copyright (c) 2012 Levey. All rights reserved.
//

#import "LeveyPopListView.h"
#import "FoodSubItemCell.h"
#import "GoodsCatagoryItem.h"

#define POPLISTVIEW_SCREENINSET 0.
#define POPLISTVIEW_HEADER_HEIGHT 50.

#define POPButtomViewHeight     60.
#define RADIUS 5.

#define kPendingX    20.f

#define kPendingX       40.f

#define kButtonWidth    60.f
#define kButtonHeight   30.f

#define kLeftPendingX  10.f

#define  kSize  CGSizeMake(300,300)

@interface LeveyPopListView () <CellDelegate>{

    NSInteger    _number;
    UILabel     *_numberLabel;
}
@property (nonatomic, strong) UIView *bgView;

- (void)fadeIn;
- (void)fadeOut;
@end

@implementation LeveyPopListView
@synthesize delegate;


#pragma mark - initialization & cleaning up

- (void)dealloc
{
    /*
     [_title release];
     [_options release];
     [_tableView release];
     
     [super dealloc];
     */
    self.bgView = nil;
    self.indexPath = nil;
    SuperDealloc;
}


- (id)initWithTitle:(NSString *)aTitle options:(NSArray *)aOptions
{
    //CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    CGRect rect = CGRectMake(0.f, 0.f,kSize.width, kSize.height);
    if (self = [super initWithFrame:rect])
    {
        self.backgroundColor = HexRGBA(250,250,250,0.8);
        _title = [aTitle copy];
        _options = [aOptions copy];
        
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(POPLISTVIEW_SCREENINSET, 
                                                                   POPLISTVIEW_SCREENINSET + POPLISTVIEW_HEADER_HEIGHT, 
                                                                   rect.size.width - 2 * POPLISTVIEW_SCREENINSET,
                                                                   rect.size.height - 2 * POPLISTVIEW_SCREENINSET - POPLISTVIEW_HEADER_HEIGHT - RADIUS-POPButtomViewHeight)];
        _tableView.separatorColor = [UIColor colorWithWhite:0 alpha:.2];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        [self addSubview:_tableView];
        
        CGRect numberRect =  CGRectMake(_tableView.frame.size.width/2.f, POPLISTVIEW_SCREENINSET + 10 + 5,
                                _tableView.frame.size.width/2.f,20);
        
        _numberLabel = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:12] withTextColor:[UIColor blackColor] withText:[NSString stringWithFormat:@"共 %ld 份",_number] withFrame:numberRect];
        
        [self addSubview:_numberLabel];
        
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0.f,_tableView.frame.size.height+_tableView.frame.origin.y,_tableView.frame.size.width, POPButtomViewHeight)];
        
        CGFloat currY = 20.f;
        
        UIButton *leftBtn = [UIComUtil createButtonWithNormalBGImageName:@"user_btn_h" withHightBGImageName:@"user_btn_h" withTitle:@"确定" withTag:1];
        leftBtn.backgroundColor = kCommonButtonBgColor;
        leftBtn.frame = CGRectMake(kPendingX,currY,kButtonWidth, kButtonHeight);
        [view addSubview:leftBtn];
        [leftBtn addTarget:self action:@selector(didPressButtonAction:) forControlEvents:UIControlEventTouchUpInside];
         UIButton *rightBtn = [UIComUtil createButtonWithNormalBGImageName:@"user_btn_h" withHightBGImageName:@"user_btn_h" withTitle:@"取消" withTag:0];
        [rightBtn addTarget:self action:@selector(didPressButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        rightBtn.backgroundColor = kCommonButtonBgColor;
        rightBtn.frame = CGRectMake(view.frame.size.width-kPendingX-kButtonWidth,currY,kButtonWidth,kButtonHeight);
        [view addSubview:rightBtn];
        
        [self addSubview:view];
        SafeAutoRelease(view);


    }
    return self;    
}

- (id)initWithTitle:(NSString *)aTitle  withNumber:(NSInteger)number options:(NSArray *)aOptions {
     _number = number;
    if(self = [self initWithTitle:aTitle options:aOptions]) {
       
    }
    return self;
}

- (void)didPressButtonAction:(id)sender {
    
    switch ([sender tag]) {
        case 0:{
            [self touchesEnded:nil withEvent:nil];
            }
            break;
        case 1:{
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(leveyPopListView:didSelectedIndex:)]) {
                
                [self.delegate leveyPopListView:self didSelectedIndex:0];
            }
            
            // dismiss self
            [self fadeOut];
        }
        default:
            break;
    }
}


#pragma mark - Private Methods
- (void)fadeIn
{
    self.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.alpha = 0;
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];

}
- (void)fadeOut
{
    
    [UIView animateWithDuration:.35 animations:^{
        self.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            
            [_bgView removeFromSuperview];
        }
    }];
}

#pragma mark - Instance Methods
- (void)showInView:(UIView *)aView animated:(BOOL)animated
{
    UIWindow *keyWnd= [[UIApplication sharedApplication]keyWindow];
    CGRect rect = [[UIScreen mainScreen] bounds];
    
    _bgView = [[UIView alloc]initWithFrame:rect];
    _bgView.backgroundColor = HexRGBA(0, 0, 0, 0.7);
    [_bgView addSubview:self];
    /*
    UITapGestureRecognizer *tapGuesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [_bgView addGestureRecognizer:tapGuesture];
    
    SafeRelease(tapGuesture);
    */
    [keyWnd addSubview:_bgView];
    
    if (animated) {
        [self fadeIn];
    }
}

- (void)tapAction:(id)sender {

    [self touchesEnded:nil withEvent:nil];
}

#pragma mark - Tableview datasource & delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_options count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentity = @"PopListViewCell";
    
    FoodSubItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    CGFloat offsetY = 20.f;
    if(kDeviceCheckIphone6){
    
        offsetY = 75.f;
    }else if(kDeviceCheckIphone6Plus) {
        offsetY = 125.f;
    }
    if (cell ==  nil) {
        cell = SafeAutoRelease([[FoodSubItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity withFrame:CGRectMake(0.f, 0.f,kDeviceScreenWidth-offsetY,50)]);
    }
    int row = [indexPath row];
    //cell.imageView.image = [[_options objectAtIndex:row] objectForKey:@"img"];
    //cell.textLabel.text = [[_options objectAtIndex:row] objectForKey:@"text"];
    SubCatagoryItem *subItem = nil;
#if 0
    subItem = _options[row];
#else
    subItem = _options[row];
#endif
    [cell setCellItem:subItem];
    [cell setDelegate:self];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
#if 0
    // tell the delegate the selection
    if (self.delegate && [self.delegate respondsToSelector:@selector(leveyPopListView:didSelectedIndex:)]) {
        [self.delegate leveyPopListView:self didSelectedIndex:[indexPath row]];
    }
    
    // dismiss self
    [self fadeOut];
#endif
    
}

- (void)cellDidClickOrderAddBtn:(id)sender  withNumber:(NSInteger)number {
    
    [self updtePriceUI];
    [_tableView reloadData];
}

- (void)cellDidClickOrderSubBtn:(id)sender  withNumber:(NSInteger)number {;
    [self updtePriceUI];
    [_tableView reloadData];
}

- (void)updtePriceUI {

    _number = 0;
    for(SubCatagoryItem *item in _options){
        _number += item.number;
    }
    _numberLabel.text = [NSString stringWithFormat:@"共 %ld 份",_number];
    //[self setNeedsDisplayInRect:_numberLabel.frame];
}

#pragma mark - TouchTouchTouch
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if([touches count] >=1){
    
        UITouch *touch = [touches allObjects][0];
        
        CGPoint touchPoint = [touch locationInView:self];
        if(CGRectContainsPoint( _tableView.frame,touchPoint)){
        
            return;
        }
        
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(leveyPopListViewDidCancel)]) {
        [self.delegate leveyPopListViewDidCancel];
    }
    
    // dismiss self
    [self fadeOut];
}

- (void)layoutSubviews {

    self.center = CGPointMake(kDeviceScreenWidth/2.f, kDeviceScreenHeight/2.f);
}

#pragma mark - DrawDrawDraw

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    CGRect bgRect = CGRectInset(rect, POPLISTVIEW_SCREENINSET, POPLISTVIEW_SCREENINSET);
    CGRect titleRect = CGRectMake(POPLISTVIEW_SCREENINSET + 10, POPLISTVIEW_SCREENINSET + 10 + 5,
                                  rect.size.width -  2 * (POPLISTVIEW_SCREENINSET + 10), 30);
    CGRect separatorRect = CGRectMake(POPLISTVIEW_SCREENINSET, POPLISTVIEW_SCREENINSET + POPLISTVIEW_HEADER_HEIGHT - 2,
                                      rect.size.width - 2 * POPLISTVIEW_SCREENINSET, 2);
    
    CGContextSetShadowWithColor(ctx, CGSizeZero, 6., [UIColor colorWithWhite:0 alpha:.75].CGColor);
    [[UIColor colorWithWhite:0 alpha:1] setFill];
    
#if 0
    
    // Draw the background with shadow
   
    
    
    float x = POPLISTVIEW_SCREENINSET;
    float y = POPLISTVIEW_SCREENINSET;
    float width = bgRect.size.width;
    float height = bgRect.size.height;
    CGMutablePathRef path = CGPathCreateMutable();
	CGPathMoveToPoint(path, NULL, x, y + RADIUS);
	CGPathAddArcToPoint(path, NULL, x, y, x + RADIUS, y, RADIUS);
	CGPathAddArcToPoint(path, NULL, x + width, y, x + width, y + RADIUS, RADIUS);
	CGPathAddArcToPoint(path, NULL, x + width, y + height, x + width - RADIUS, y + height, RADIUS);
	CGPathAddArcToPoint(path, NULL, x, y + height, x, y + height - RADIUS, RADIUS);
	CGPathCloseSubpath(path);
	CGContextAddPath(ctx, path);
    CGContextFillPath(ctx);
    CGPathRelease(path);
#endif
    // Draw the title and the separator with shadow
    //CGContextSetShadowWithColor(ctx, CGSizeMake(0, 1), 0.5f, [UIColor blackColor].CGColor);
    [[UIColor colorWithRed:0.020 green:0.549 blue:0.961 alpha:1.] setFill];
    [_title drawInRect:titleRect withFont:[UIFont systemFontOfSize:16.]];
   
    CGContextFillRect(ctx, separatorRect);
    
    
}

@end
