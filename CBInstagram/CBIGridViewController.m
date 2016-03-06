//
//  CBIGridViewController.m
//  CBInstagram
//
//  Created by Mohamad Farhand on 3/6/16.
//  Copyright © 2016 ideveloper. All rights reserved.
//

#import "CBIGridViewController.h"
#import "CBICollectionViewCell.h"
#import "CBIProfileCell.h"
#import "CBISelfProvider.h"
@interface CBIGridViewController ()

@end

@implementation CBIGridViewController

static NSString * const reuseIdentifier = @"CBICollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    // Uncomment the following line to preserve selection between presentations
     self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self registerXIB];
    

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)registerXIB
{
    [self.collectionView registerNib:[UINib nibWithNibName:@"CBICollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"CBICollectionViewCell"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CBIProfileCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"CBIProfileCell"];

}







/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
        
    }
    else
     return self.posts.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        CBIProfileCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CBIProfileCell" forIndexPath:indexPath];
        cell.myInfo = [[CBISelfProvider sharedInstance]selfInformation];
        [cell setup];
        
        return cell;

    }
    
    else
    {
    CBICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.postEntity = [self.posts objectAtIndex:indexPath.row];
    [cell configureCell];
        return cell;

    
    }
    
}

#pragma mark CBIDownloadQueueHandlerDelegate

-(void)downloadDidFinishedWithToken:(NSString *)token withFileName:(NSString *)filename

{
    [self.collectionView reloadData];
}



#pragma mark collection view cell layout / size
- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section!=0) {
        
    return CGSizeMake(100, 100);
    }// will be w120xh100 or w190x100
    // if the width is higher, only one image will be shown in a line
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 80);
}

#pragma mark collection view cell paddings
- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 10, 2, 10); // top, left, bottom, right
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 5.0;
}


#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
