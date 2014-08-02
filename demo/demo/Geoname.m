//
//  Geoname.m
//  demo
//
//  Created by Josh Justice on 8/2/14.
//  Copyright (c) 2014 NeedBee. All rights reserved.
//

#import "Geoname.h"

#define ID_KEY              @"geonameId"
#define LAT_KEY             @"lat"
#define LNG_KEY             @"lng"
#define NAME_KEY            @"name"
#define TOPONYM_NAME_KEY    @"toponymName"
#define POPULATION_KEY      @"population"
#define WIKIPEDIA_KEY       @"wikipedia"
#define COUNTRY_CODE_KEY    @"countrycode"
#define FCL_KEY             @"fcl"
#define FCL_NAME_KEY        @"fclName"
#define FCODE_KEY           @"fcode"
#define FCODE_NAME_KEY      @"fcodeName"

@implementation Geoname

+(Geoname *)geonameFromDict:(NSDictionary *)dict
{
	if( nil == dict || [dict isMemberOfClass:[NSNull class]] ) {
		return nil;
	}
	Geoname *obj = [[Geoname alloc] init];
	if( obj ) {
		obj.geonameId       = ((NSNumber *)[dict objectForKey:ID_KEY]).intValue;
        obj.latitude        = ((NSNumber *)[dict objectForKey:LAT_KEY]).doubleValue;
        obj.longitude       = ((NSNumber *)[dict objectForKey:LNG_KEY]).doubleValue;
		obj.name            = [dict objectForKey:NAME_KEY];
		obj.toponymName     = [dict objectForKey:TOPONYM_NAME_KEY];
		obj.population      = ((NSNumber *)[dict objectForKey:POPULATION_KEY]).intValue;
		obj.wikipedia       = [dict objectForKey:WIKIPEDIA_KEY];
		obj.countryCode     = [dict objectForKey:COUNTRY_CODE_KEY];
		obj.fcl             = [dict objectForKey:FCL_KEY];
		obj.fclName         = [dict objectForKey:FCL_NAME_KEY];
		obj.fcode           = [dict objectForKey:FCODE_KEY];
		obj.fcodeName       = [dict objectForKey:FCODE_NAME_KEY];
	}
	return obj;
}

+(NSArray *)arrayFromDictArray:(NSArray *)dictArray
{
	NSMutableArray *objs = [NSMutableArray arrayWithCapacity:[dictArray count]];
	NSEnumerator *e = [dictArray objectEnumerator];
	NSMutableDictionary *dict;
	while( ( dict = [e nextObject] ) ) {
		[objs addObject:[Geoname geonameFromDict:dict]];
	}
	return objs;
}

@end
