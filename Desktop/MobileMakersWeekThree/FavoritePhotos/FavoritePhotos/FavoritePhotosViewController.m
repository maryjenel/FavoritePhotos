//
//  FavoritePhotosViewController.m
//  FavoritePhotos
//
//  Created by Mary Jenel Myers on 1/26/15.
//  Copyright (c) 2015 Mary Jenel Myers. All rights reserved.
//

#import "FavoritePhotosViewController.h"
#import "ViewController.h"
#import "InstagramPhoto.h"
#import "CustomCollectionViewCell.h"

@interface FavoritePhotosViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property NSMutableArray *favPhotoArray;
@property (weak, nonatomic) IBOutlet UICollectionView *favPhotoCollectionView;



@end

@implementation FavoritePhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self load];
    if (!self.favPhotoArray)
    {
        self.favPhotoArray = [NSMutableArray new];
    }
    [self.favPhotoCollectionView reloadData];
}
-(void)load
{
    NSURL *pListPath;
    pListPath = [self plist];
    self.favPhotoArray = [NSMutableArray arrayWithContentsOfURL:pListPath];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.favPhotoArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"favoriteCell" forIndexPath:indexPath];
    NSString *photoString = [self.favPhotoArray objectAtIndex:indexPath.row];
    NSURL *url = [NSURL URLWithString:photoString];
    NSData *data = [[NSData alloc]initWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    
    cell.imageView.image = image;
    cell.fav.image = [UIImage imageNamed:@"highlightedheart"];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    InstagramPhoto *instaPhoto = [self.favPhotoArray objectAtIndex:indexPath.row];
    if (instaPhoto.favPhoto)
    {
        instaPhoto.favPhoto = !instaPhoto.favPhoto;
        [self.favPhotoArray removeObject:instaPhoto.standardPhotoURL];
        [self save];
    }
    else
    {
        instaPhoto.favPhoto = !instaPhoto.favPhoto;
        [self.favPhotoArray addObject:instaPhoto.standardPhotoURL];
        [self save];
    }
    [self.favPhotoCollectionView reloadData];
}
-(NSURL *)documentsDirectory
{
    return [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;

}


-(NSURL *)plist
{
    NSURL *pListPath = [[self documentsDirectory]URLByAppendingPathComponent:@"favphoto.plist"];
    return pListPath;
}


-(void)save
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSURL *pListPath;
    pListPath = [self plist];
    [self.favPhotoArray writeToURL:pListPath atomically:YES];
    [defaults synchronize];
}









@end
