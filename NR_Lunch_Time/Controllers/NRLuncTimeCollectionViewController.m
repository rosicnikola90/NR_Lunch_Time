//
//  CollectionViewController.m
//  NR_Lunch_Time
//
//  Created by MacBook on 5/8/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

#import "NRLuncTimeCollectionViewController.h"

@interface NRLuncTimeCollectionViewController ()

@property (nonatomic) NRRestorantsManager *manager;
@property (nonatomic, nullable, weak) NRRestourant *selectedRestourant;
@property (nonatomic) NSArray<NRRestourant*> *restourants;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation NRLuncTimeCollectionViewController

static NSString * const reuseIdentifier = @"NRcell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.activityIndicator setHidesWhenStopped:true];
    [self.collectionView registerNib:[UINib nibWithNibName:@"NRCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    [self managingManager];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.restourants == nil)
    {
        [self.activityIndicator startAnimating];
    }
}

- (void)managingManager
{
    self.manager = NRRestorantsManager.new;
    self.manager.delegate = self;
    [self.manager updateRestourantListFromWebWithURL:urlToRestourants];
}

- (IBAction)mapBarButtonPressed:(UIBarButtonItem *)sender
{
    NSLog(@"To be continued..");
}

- (void)updatedRestourantImage:(UIImage *)image atIndexPath:(NSIndexPath *)indexPath
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.restourants[indexPath.row].backgroundImageWithURL.restourantImage = image;
        [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
    });
}

- (void)reastourantArrayCreated:(NSArray<NRRestourant *> *)restourants
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (restourants != nil) {
            self.restourants = restourants;
            [self.activityIndicator stopAnimating];
            [self.collectionView reloadData];
        }
    });
}

- (void)updateCell:(NRCollectionViewCell *)cell WithRestourantData:(NRRestourant *)restourant
{
    cell.restourantNameLbl.text = restourant.name;
    cell.categoryTypeLbl.text = restourant.category;
    if (restourant.backgroundImageWithURL.restourantImage == nil)
    {
        cell.restourantImage.image = [UIImage imageNamed:@"cellGradientBackground"];
    }
    else
    {
    cell.restourantImage.image = restourant.backgroundImageWithURL.restourantImage;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (self.selectedRestourant != nil && [segue.identifier isEqualToString:@"showDetail"])
    {
        NRShowDetailViewController *destinationVC = segue.destinationViewController;
        destinationVC.restourant = self.selectedRestourant;
    }
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.restourants.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NRCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if ([self.restourants[indexPath.row] isKindOfClass:[NRRestourant class]])
    {
        NRRestourant *rest = self.restourants[indexPath.row];
        [self updateCell:cell WithRestourantData:rest];
        if (rest.backgroundImageWithURL.restourantImage == nil)
        {
            [self.manager getImageForRestourantURL:rest.backgroundImageWithURL.imageURL atIndex:indexPath];
        }
    }
    return cell;
}

#pragma mark <UICollectionViewFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width, 180);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedRestourant = self.restourants[indexPath.row];
    [self performSegueWithIdentifier:@"showDetail" sender:self];
}

@end
