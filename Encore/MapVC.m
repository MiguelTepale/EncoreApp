#import "MapVC.h"

@interface MapVC ()

@end

@implementation MapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Add a back button on the left side of the navigation bar
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"←"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(performBackNavigation:)];
    [backButton setTitleTextAttributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:30] }
                              forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = backButton;
    
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

//  Method is called when the user hit the back button.
- (void) performBackNavigation:(id)sender
{
    // Exit current screen
    [self.navigationController popViewControllerAnimated:NO];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setVenueAnnotation {
    // *Use for testing*
    self.venueLatitude = self.event.latitude;
    self.venueLongitude = self.event.longitude;
    self.venueName = self.event.venueName;
    self.venueLocation = self.event.venueLocation;
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(self.venueLatitude, self.venueLongitude);
    
    Annotation *venuePin = [[Annotation alloc] initWithTitle:self.venueName andSubtitle:self.venueLocation andCoordinate:coordinate];
    
    [self.mapView addAnnotation:venuePin];
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 500, 500);
    [self.mapView setRegion:region animated:YES];
}

@end
