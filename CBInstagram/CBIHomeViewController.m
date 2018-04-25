//
//  CBIHomeViewController.m
//  CBInstagram
//
//  Created by Mohamad Farhand on 3/6/16.
//  Copyright © 2016 ideveloper. All rights reserved.
//

#import "CBIHomeViewController.h"
#import "CBIPostCell.h"
#import "CBIImageCache.h"
#import "CBIHeaderPost.h"
@interface CBIHomeViewController ()
{
    CBIPostCell *_CBISamplecell;

}
@property (nonatomic,strong) UIRefreshControl * refreshControl;

@end

@implementation CBIHomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [[CBIDownloadeQueueHandler sharedInstance]addDelegate:self delegateQueue:dispatch_get_main_queue()];
    [self manageAppearance];
    [self registerXIB];
    

}


-(void)manageAppearance
{
    self.title = @"MFInstagram";
    [self setNeedsStatusBarAppearanceUpdate];
    // Initialize the refresh control.
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.CBIPostTableView addSubview:self.refreshControl];
}

-(void)registerXIB
{
    [self.CBIPostTableView registerNib:[UINib nibWithNibName:@"CBIPostCell" bundle:nil] forCellReuseIdentifier:@"CBIPostCell"];
    [self.CBIPostTableView registerNib:[UINib nibWithNibName:@"CBIHeaderPost" bundle:nil] forCellReuseIdentifier:@"CBIHeaderPost"];
    _CBISamplecell = [[UINib nibWithNibName:@"CBIPostCell" bundle:[NSBundle mainBundle]] instantiateWithOwner:nil options:nil][0];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refresh:(UIRefreshControl *)refreshControl {
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSLog(@"\n\n refreshing.....");
        NSArray *directoryContents =  [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] error:NULL];
        
        if([directoryContents count] > 0)
        {
            for (NSString *path in directoryContents)
            {
                NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:path];
                
                [[NSFileManager defaultManager] removeItemAtPath:fullPath error:nil];
                
            }
        }
        
        [[CBIImageCache sharedInstance]setMainCacheDic:[[NSMutableDictionary alloc]init]];
        [[CBIDownloadeQueueHandler sharedInstance]setMainDownloadQueue:[[NSMutableArray alloc]init]];
        [[CBIDownloadeQueueHandler sharedInstance]setCurrentDownloadQueue:[[NSMutableArray alloc]init]];
        [[CBIDownloadeQueueHandler sharedInstance]setTokensDict:[[NSMutableDictionary alloc]init]];
        [self.CBIPostTableView reloadData];
        [self.refreshControl endRefreshing];
    });
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.posts.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CBIPostCell";
    CBIPostCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    [self configureCell:cell atIndexPath:indexPath];
    [cell setupCell];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CBIHeaderPost * customHeaderCell = [tableView dequeueReusableCellWithIdentifier:@"CBIHeaderPost"];
    
    CBIMediaUserEntity * tempEntity = [self.posts objectAtIndex:section];

    customHeaderCell.metaInfo = tempEntity;
    [customHeaderCell configure];
    return customHeaderCell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self configureCell:_CBISamplecell atIndexPath:indexPath];
    [_CBISamplecell layoutSubviews];
    
    CGFloat height = [_CBISamplecell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
//    NSLog(@"%f",height);
    return height;
}

-(void)downloadDidFinishedWithToken:(NSString *)token withFileName:(NSString *)filename
{
    // TODO : Reload only once Cell;
    [self.CBIPostTableView reloadData];
}


- (void)configureCell:(CBIPostCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    cell.postEntity = [self.posts objectAtIndex:indexPath.section];
    [cell configureCell];
}

@end
