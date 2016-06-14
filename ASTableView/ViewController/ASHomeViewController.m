//
//  ASHomeViewController.m
//  tabviewsrcollew
//
//  Created by AllenQin on 16/6/13.
//  Copyright © 2016年 AllenQin. All rights reserved.
//

#import "ASHomeViewController.h"
#import "ASDetailViewController.h"
#import "ASTableViewCell.h"
#import "ASModel.h"

@interface ASHomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *tableView;
@property (copy,  nonatomic) NSArray *resultArr;

@end

@implementation ASHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:NO];
    [self initTableView];
    [self requireData];

}

-(void)initTableView{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource =self;
    _tableView.backgroundColor =[UIColor whiteColor];
    [_tableView registerClass:[ASTableViewCell class]forCellReuseIdentifier:@"cell" ];
    [self.view addSubview:_tableView];
}

- (void)requireData{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *dataFilePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:dataFilePath];
        NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *feedDicts = rootDict[@"feed"];
        NSMutableArray *entities = @[].mutableCopy;
        [SVProgressHUD show];
#pragma mark    图片比例建议在viewController   建议图片的高度从后台传入 否则太卡 并且断网的时候不会显示图片
        [feedDicts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ASModel *model = [[ASModel alloc] initWithDictionary:obj];
            UIImage *contentImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.imageName]]];
            model.imageWide = contentImage.size.width;
            model.imageheight = contentImage.size.height;
            [entities addObject:model];
        }];
        self.resultArr = entities;
        
        dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
               [self.tableView reloadData];
        });
     });
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resultArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ASTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(ASTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
    cell.model = self.resultArr[indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ASDetailViewController *detailViewController = [[ASDetailViewController alloc] init];
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}



#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [tableView fd_heightForCellWithIdentifier:@"cell" cacheByIndexPath:indexPath configuration:^(ASTableViewCell *cell) {
        [self configureCell:cell atIndexPath:indexPath];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
