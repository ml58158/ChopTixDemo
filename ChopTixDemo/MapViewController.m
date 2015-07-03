//
//  ViewController.m
//  ChopTixDemo
//
//  Created by Matt Larkin on 7/2/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//

#import "MapViewController.h"
#import <MapboxGL/MapboxGL.h>
#import "SMCalloutView.h"
#import "mapbox.h"


@interface MapViewController () <MGLMapViewDelegate, MGLAnnotation, MGLOverlay, SMCalloutViewDelegate>

@property (nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) IBOutlet MGLMapView *mapView;
@property (nonatomic, strong) SMCalloutView *calloutView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getLocation];
    [self setupMapBox];

}


#pragma mark - Location Delegates

//Retrieves User's Location
-(void)getLocation{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 500;
    self.locationManager.pausesLocationUpdatesAutomatically = NO;
    self.locationManager.activityType = CLActivityTypeFitness;

    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }

    [self.locationManager startUpdatingLocation];
}


#pragma mark - MapBox Delegates and Methods

-(void)setupMapBox {
    MGLMapView *mapView = [[MGLMapView alloc] initWithFrame:self.view.frame];

    mapView.delegate = self;

    mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    self.mapView.userTrackingMode = MGLUserTrackingModeFollowWithHeading;
    self.mapView.showsUserLocation = YES;

    [self.view addSubview:mapView];

    //Centers map on user location
    CLLocationCoordinate2D centerCoordinate = CLLocationCoordinate2DMake(36.557334545,	-82.577549263);

    [mapView setCenterCoordinate:centerCoordinate zoomLevel:15 animated:YES];

    // Declare the marker `hello` and set its coordinates, title, and subtitle
    MGLPointAnnotation *hello = [[MGLPointAnnotation alloc] init];
    hello.coordinate = CLLocationCoordinate2DMake(40.7326808, -73.9843407);
    hello.title = @"Hello world!";
    hello.subtitle = @"Welcome to my marker";

    // Add marker `hello` to the map
    [mapView addAnnotation:hello];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait || [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad);
}

// Set the default marker; the marker name from the style's sprite JSON
- (NSString *)mapView:(MGLMapView *)mapView symbolNameForAnnotation:(id <MGLAnnotation>)annotation {
    return @"secondary_marker";
}

// Allow markers callouts to show when tapped
- (BOOL)mapView:(MGLMapView *)mapView annotationCanShowCallout:(id <MGLAnnotation>)annotation {
    return YES;
}


- (RMMapLayer *)mapView:(RMMapView *)mapView layerForAnnotation:(RMAnnotation *)annotation
{
    if (annotation.isUserLocationAnnotation)
        return nil;

    RMMarker *marker;

    // set 'training' marker image
    if ([annotation.userInfo isEqualToString:@"hello"])
    {
        marker = [[RMMarker alloc] initWithUIImage:[UIImage imageNamed:@"bikeImage.png"]];
    }
    // set 'supplies' marker image
    else if ([annotation.userInfo isEqualToString:@"hello"])
    {
        marker = [[RMMarker alloc] initWithUIImage:[UIImage imageNamed:@"bikeImage.png"]];
    }

    marker.canShowCallout = YES;

    return marker;
}


//    //Configures Custom Callout
//    self.calloutView = [SMCalloutView platformCalloutView];
//    self.calloutView.delegate = self;


-(void)defineAnnotation {


}


@end
