//
//  ViewController.m
//  FavoritePhotos
//
//  Created by Mary Jenel Myers on 1/25/15.
//  Copyright (c) 2015 Mary Jenel Myers. All rights reserved.
//

#import "ViewController.h"
#import "InstagramPhoto.h"
#import "CustomCollectionViewCell.h"
#import "FavoritePhotosViewController.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate, UISearchBarDelegate>
@property NSMutableArray *photoArray;
@property NSArray *dataArray;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property NSMutableArray *favPhotoArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.urlString = @"https://api.instagram.com/v1/tags/snow/media/recent?client_id=60a5cb339aa14bbdbb74632bbd8b926d";
    self.photoArray = [NSMutableArray new];
    [self searchedInstagramPhotos];
    self.searchBar.delegate = self;
    [self load];
    if (!self.favPhotoArray)
    {
        self.favPhotoArray = [NSMutableArray new];
    }


}



-(void)searchedInstagramPhotos
{
    NSURL *url = [NSURL URLWithString:self.urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         NSDictionary *instagramDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
         self.dataArray = [instagramDictionary objectForKey:@"data"];
         for (int i = 0; i < 10; i++)
         {

             NSDictionary *images = [[self.dataArray objectAtIndex:i] objectForKey:@"images"];
             NSString *filter = [[self.dataArray objectAtIndex:i] objectForKey:@"filter"];
             InstagramPhoto *instaPhoto = [[InstagramPhoto alloc] initWithStandardImage:images filter:filter];
             instaPhoto.favPhoto = false;
             [self.photoArray addObject:instaPhoto];

         }
         [self.collectionView reloadData];

     }];
}

-(CustomCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageCell" forIndexPath:indexPath];
    InstagramPhoto *photo = [self.photoArray objectAtIndex:indexPath.row];
    NSURL *url = [NSURL URLWithString:photo.standardPhotoURL];
    NSData *data = [[NSData alloc]initWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    cell.imageView.image = image;
    if (photo.favPhoto)
    {
        cell.fav.image = [UIImage imageNamed:@"highlightedheart"];
    }
    else
    {
        cell.fav.image = [UIImage imageNamed:@"heart"];
    }
    return cell;
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    InstagramPhoto *instaPhoto = [self.photoArray objectAtIndex:indexPath.row];
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
    [self.collectionView reloadData];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.urlString = [NSString stringWithFormat:@"https://api.instagram.com/v1/tags/%@/media/recent?client_id=60a5cb339aa14bbdbb74632bbd8b926d", searchBar.text];
    self.photoArray = [NSMutableArray new];
    [self searchedInstagramPhotos];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photoArray.count;
}

-(NSString *)selectedPhoto
{
    NSInteger row = self.collectionView.indexPathsForSelectedItems.count;
    return  [self.photoArray objectAtIndex:row];
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

-(void)load
{
    NSURL *pListPath;
    pListPath = [self plist];
    self.favPhotoArray = [NSMutableArray arrayWithContentsOfURL:pListPath];
}


@end

