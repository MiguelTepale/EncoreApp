//
//  Model.m
//  ArtistSearchApp
//
//  Created by bl on 5/4/17.
//  Copyright © 2017 Miguel Tepale. All rights reserved.
//


#import "Model.h"


typedef void (^GetRequestCompletionHandler)(id);

typedef enum
{
    ARTIST_REQUEST,
    EVENT_REQUEST
}
RequestType;


@implementation Model
{
    RequestType _currentRequestType;
}

#pragma mark - Public Methods

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Method to asynchronously request artist's data.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (void) findArtist:(NSString *)artistName
{
    // Format a URL string for a query
    NSString *encodedName = [self addPercentEncodingForRFC3986:artistName];
    encodedName = [encodedName stringByReplacingOccurrencesOfString:@"%20" withString:@"+"];
    NSString *urlStr = [[NSString alloc] initWithFormat:@"https://itunes.apple.com/search?term=%@&media=music&entity=album", encodedName];

    GetRequestCompletionHandler completionHandler = ^ void (NSDictionary *dataDictionary)
    {
        // Extract the list of albums from the data
        NSMutableArray *albums = [self parseArtistData:dataDictionary];
        
        // Notify the delegate that the get was successful
        [self.artistDelegate didFindArtist:albums];
    };
    
    _currentRequestType = ARTIST_REQUEST;
    
    [self executeHTTPGetRequest:urlStr
          withCompletionHandler:completionHandler];
}

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Method to asynchronously request artist's events.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (void) findEvents:(NSString *)artistName
{
    // Format a URL string for a query
    NSString *encodedName = [self addPercentEncodingForRFC3986:artistName];
    NSString *urlStr = [[NSString alloc] initWithFormat:@"https://rest.bandsintown.com/artists/%@/events?app_id=indie", encodedName];
    
    GetRequestCompletionHandler completionHandler = ^ void (NSArray *dataArray)
    {
        // Extract the list of events from the data
        NSMutableArray *events = [self parseEventData:dataArray];
        
        // Notify the delegate that the get was successful
        [self.eventsDelegate didFindEvents:events];
    };
    
    _currentRequestType = EVENT_REQUEST;
    
    [self executeHTTPGetRequest:urlStr
          withCompletionHandler:completionHandler];
}

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Method implements the singleton pattern for this class.
//
//////////////////////////////////////////////////////////////////////////////////////////
+ (Model *) sharedInstance
{
    static Model *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate,
                  ^{
                      _sharedInstance = [[Model alloc] init];
                  });
    
    return _sharedInstance;
}

#pragma mark - Private Methods

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Method to encode a string for a URL as per RFC 3986.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (NSString *) addPercentEncodingForRFC3986: (NSString *)unencodedString
{
    // The following characters are allowed and should not be encoded
    NSMutableCharacterSet *allowed = [NSMutableCharacterSet alphanumericCharacterSet];
    [allowed addCharactersInString:@"-._~/?"];
    
    // Encode characters in string minus the allowed character set
    return [unencodedString stringByAddingPercentEncodingWithAllowedCharacters:allowed];
}

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Method to execute a http get request for JSON data from a REST API.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (void) executeHTTPGetRequest:(NSString *)urlStr
         withCompletionHandler:(GetRequestCompletionHandler)completionHandler
{
    // Initialize the request
    NSURL *URL = [NSURL URLWithString:urlStr];
    
    // Initialize a session for managing data transfer tasks
    NSURLSession *session = [NSURLSession sharedSession];
    
    // Create a background task that retrieves the contents of the URL
    [[session dataTaskWithURL:URL
            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
      {
          // If the get request did not failed then ...
          if (!error)
          {
              // convert the retrieved JSON data into a dictionary or array
              id dataObject = [NSJSONSerialization JSONObjectWithData:data
                                                              options:kNilOptions
                                                                error:&error];
              // If the conversion did not failed then ...
              if (!error)
              {
                  // Schedule in the main thread, the execution of the caller's completion handler
                  dispatch_async(dispatch_get_main_queue(),
                                 ^{
                                     completionHandler(dataObject);
                                 });
                  return;
              }
          }
          
          // Schedule in the main thread, the delegate notification of the error that occurred
          dispatch_async(dispatch_get_main_queue(),
                         ^{
                             switch (_currentRequestType)
                             {
                                 case ARTIST_REQUEST:
                                     [self.artistDelegate didNotFindArtist:[error localizedDescription]];
                                     break;
                                
                                 case EVENT_REQUEST:
                                     [self.eventsDelegate didNotFindEvents:[error localizedDescription]];
                                     break;
                                     
                                 default:
                                     NSAssert(false, @"Unrecognized request type.");
                             }
                         });
      }
      ] resume];
}

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Method to parse the returned data into an array of artist's albums.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (NSMutableArray *) parseArtistData:(NSDictionary *)dataDictionary
{
    NSArray *albumDataArray = dataDictionary[@"results"];
    NSMutableArray *albums = [[NSMutableArray alloc] init];
    
    for (NSDictionary *albumData in albumDataArray)
    {
        Album *a = [[Album alloc] init];
        
        a.id = [albumData[@"collectionId"] longLongValue];
        a.name = albumData[@"collectionName"];
        a.imageURL = albumData[@"collectionViewUrl"];
        
        [albums addObject:a];
    }
    
    return albums;
}

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Method to parse the returned data into an array of artist's events.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (NSMutableArray *) parseEventData:(NSArray *)dataArray
{
    NSMutableArray *events = [[NSMutableArray alloc] init];
    
    for (NSDictionary *eventData in dataArray)
    {
        Event *e = [[Event alloc] init];
        
        NSDictionary *venue = eventData[@"venue"];
        
        // convert date string to NSDate
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYY-MM-dd'T'HH:mm:ss"];
        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
        e.date = [dateFormatter dateFromString:venue[@"datetime"]];

        e.venueName = venue[@"name"];
        e.venueLocation = [[NSString alloc] initWithFormat:@"%@, %@", venue[@"city"], venue[@"region"]];
        e.longitude = [venue[@"longitude"] doubleValue];
        e.latitude = [venue[@"latitude"] doubleValue];
        
        NSArray *offerDataArray = eventData[@"offers"];
        if (0 == offerDataArray.count)
        {
            e.eventURL = nil;
            e.soldOut = true;
        }
        else
        {
            NSDictionary *offer = offerDataArray[0];
            e.eventURL = offer[@"url"];
            e.soldOut = ![offer[@"status"] isEqualToString:@"available"];
        }
        
        [events addObject:e];
    }
    
    return events;
}

@end
