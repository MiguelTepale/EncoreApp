//
//  Annotation.m
//  Encore
//
//  Created by George E. Correa on 5/5/17.
//  Copyright © 2017 Miguel Tepale. All rights reserved.
//

#import "Annotation.h"

@implementation Annotation

- (nonnull instancetype) initWithTitle:(nonnull NSString *) title andSubtitle:(nonnull NSString *) subtitle andCoordinate:(CLLocationCoordinate2D) coordinate {
    self = [super init];
    if (self) {
        self.title = title;
        self.subtitle = subtitle;
        self.coordinate = coordinate;
    }
    
    return self;
}

@end
