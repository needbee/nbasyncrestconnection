//
//  Geoname.h
//
//  Sample business object. Note that we map the JSON returned object to a
//  normal Objective-C object.
//
//  Created by Josh Justice on 8/2/14.
//  Copyright (c) 2014 NeedBee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Geoname : NSObject

@property (nonatomic,assign) int geonameId;
@property (nonatomic,assign) double latitude;
@property (nonatomic,assign) double longitude;
@property (nonatomic,retain) NSString *name;
@property (nonatomic,retain) NSString *toponymName;
@property (nonatomic,retain) NSString *countryCode;
@property (nonatomic,assign) int population;
@property (nonatomic,retain) NSString *wikipedia;
@property (nonatomic,retain) NSString *fcl;
@property (nonatomic,retain) NSString *fclName;
@property (nonatomic,retain) NSString *fcode;
@property (nonatomic,retain) NSString *fcodeName;

// Translate one object in JSON into a Geoname object.
+(Geoname *)geonameFromDict:(NSDictionary *)dict;

// Translate an array of objects in JSON into a NSArray of Geoname objects
+(NSArray *)arrayFromDictArray:(NSArray *)dictArray;

@end
