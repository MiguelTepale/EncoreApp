//
//  Annotation.h
//  Encore
//
//  Created by George E. Correa on 5/5/17.
//  Copyright © 2017 Miguel Tepale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Annotation : NSObject <MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy, nullable) NSString *title;
@property (nonatomic, copy, nullable) NSString *subtitle;

- (nonnull instancetype) initWithTitle:(nonnull NSString *) title andSubtitle:(nonnull NSString *) subtitle andCoordinate:(CLLocationCoordinate2D) coordinate;

@end
