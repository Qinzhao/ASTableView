//
//  ASDetailViewController.m
//  tabviewsrcollew
//
//  Created by AllenQin on 16/6/14.
//  Copyright © 2016年 AllenQin. All rights reserved.
//

#import "ASDetailViewController.h"
#import "ASDetailTableViewCell.h"
#import "ASDetailModel.h"

@interface ASDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *tableView;
@property (copy,  nonatomic) NSArray *resultArr;



@end

@implementation ASDetailViewController

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
    [_tableView registerClass:[ASDetailTableViewCell class]forCellReuseIdentifier:@"detailcell" ];
    [self.view addSubview:_tableView];
}

- (void)requireData{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *dataFilePath = [[NSBundle mainBundle] pathForResource:@"data1" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:dataFilePath];
        NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *feedDicts = rootDict[@"feed"];
        NSMutableArray *entities = @[].mutableCopy;
        [SVProgressHUD show];
        [feedDicts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ASDetailModel *model = [[ASDetailModel alloc] initWithDictionary:obj];
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
    
    ASDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailcell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(ASDetailTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
    cell.model = self.resultArr[indexPath.row];
}



#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [tableView fd_heightForCellWithIdentifier:@"detailcell" cacheByIndexPath:indexPath configuration:^(ASDetailTableViewCell *cell) {
        [self configureCell:cell atIndexPath:indexPath];
    }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
