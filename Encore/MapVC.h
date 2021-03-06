#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Annotation.h"
#import "Event.h"


@interface MapVC : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property CLLocationManager *locationManager;
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSString *venueName;
@property (strong, nonatomic) NSString *venueLocation;
@property (strong, nonatomic) Event *event;
@property CLLocationDegrees venueLatitude;
@property CLLocationDegrees venueLongitude;

@end
