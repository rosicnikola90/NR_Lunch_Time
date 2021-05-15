//
//  NRShowDetailViewController.m
//  NR_Lunch_Time
//
//  Created by MacBook on 5/13/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

#import "NRShowDetailViewController.h"

@interface NRShowDetailViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *restourantNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *twiterLabel;
@property (nonatomic) CLLocationCoordinate2D *restourantLocation;
@property (nonatomic) MKPointAnnotation *locationAnotation;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation NRShowDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.mapView setUserInteractionEnabled:false];
    self.title = @"Lunch Tyme";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUIWithRestorantDetails:self.restourant];
    [self setLocationAnotationForRestourant:self.restourant];
    [self.mapView setRegion:[self centerMapForRestourantLocationAnotation:self.locationAnotation]];
}

- (void)setLocationAnotationForRestourant:(NRRestourant*)restourant
{
    self.locationAnotation = [[MKPointAnnotation alloc] init];
    self.locationAnotation.coordinate = CLLocationCoordinate2DMake([restourant.latitude doubleValue], [restourant.longitude doubleValue]);
    [self.locationAnotation setTitle:restourant.name];
    [self.mapView addAnnotation:self.locationAnotation];
}

- (void)updateUIWithRestorantDetails:(NRRestourant*)restourant
{
    if (restourant.address != nil && restourant.address.count == 3)
    {
        NSString *fullAddress = [NSString stringWithFormat:@"%@, %@, %@", restourant.address[0], restourant.address[1], restourant.address[2] ];
        self.addressLabel.text = fullAddress;
    }
    else
    {
        [self.addressLabel setHidden:true];
    }
    
    if (restourant.phoneNo != nil)
    {
        self.phoneLabel.text = restourant.phoneNo;
    }
    else
    {
        [self.phoneLabel setHidden:true];
    }
    
    if (restourant.twitter != nil)
    {
        self.twiterLabel.text = [NSString stringWithFormat:@"@%@", restourant.twitter];
    }
    else
    {
        [self.twiterLabel setHidden:true];
    }
    if (restourant.name != nil)
    {
        self.restourantNameLabel.text = restourant.name;
    }
    if (restourant.category != nil)
    {
        self.categoryLabel.text = restourant.category;
    }
}

- (MKCoordinateRegion)centerMapForRestourantLocationAnotation:(MKPointAnnotation *)anotation {
    return MKCoordinateRegionMake(anotation.coordinate , MKCoordinateSpanMake(0.005, 0.005));
}

@end
