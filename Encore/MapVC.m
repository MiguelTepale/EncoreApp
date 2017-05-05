#import "MapVC.h"

@interface MapVC ()

@end

@implementation MapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestAlwaysAuthorization];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
    
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = true;
    
    self.mapView.mapType = MKMapTypeStandard;
    [self setVenueAnnotation];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setVenueAnnotation {
    // *Use for testing*
//    self.venueLatitude = 40.70859189999999;
//    self.venueLongitude = -74.01492050000002;
//    self.venueName = @"Turn To Tech";
//    self.venueLocation = @"Learn, Build Apps, Get Hired";
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(self.venueLatitude, self.venueLongitude);
    
    Annotation *venuePin = [[Annotation alloc] initWithTitle:self.venueName andSubtitle:self.venueLocation andCoordinate:coordinate];
    
    [self.mapView addAnnotation:venuePin];
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 250, 250);
    [self.mapView setRegion:region animated:YES];
}

@end
