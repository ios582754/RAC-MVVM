//
//  RequestViewModel.h
//  ReactiveCocoa
//
//  Created by Mr.Wang on 16/4/20.
//  Copyright © 2016年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"
#import "AFNetworking.h"
//#import "STNetworkRequest.h"


@interface Tags :NSObject
@property (nonatomic , assign) NSInteger              count;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * title;

@end

@interface Images :NSObject
@property (nonatomic , copy) NSString              * small;
@property (nonatomic , copy) NSString              * large;
@property (nonatomic , copy) NSString              * medium;

@end

@interface Translator :NSObject

@end

@interface Series :NSObject
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * title;

@end

@interface Rating :NSObject
@property (nonatomic , assign) NSInteger              min;
@property (nonatomic , copy) NSString              * average;
@property (nonatomic , assign) NSInteger              max;
@property (nonatomic , assign) NSInteger              numRaters;

@end

@interface Books :NSObject
@property (nonatomic , copy) NSString              * isbn13;
@property (nonatomic , copy) NSString              * author_intro;
@property (nonatomic , copy) NSString              * publisher;
@property (nonatomic , copy) NSString              * pages;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , strong) NSArray<Tags *>              * tags;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , copy) NSString              * catalog;
@property (nonatomic , copy) NSString              * alt;
@property (nonatomic , copy) NSString              * isbn10;
@property (nonatomic , copy) NSString              * url;
@property (nonatomic , copy) NSString              * alt_title;
@property (nonatomic , strong) Images              * images;
@property (nonatomic , copy) NSString              * summary;
@property (nonatomic , copy) NSString              * pubdate;
@property (nonatomic , copy) NSString              * origin_title;
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * subtitle;
@property (nonatomic , strong) NSArray<Translator *>              * translator;
@property (nonatomic , strong) Series              * series;
@property (nonatomic , copy) NSString              * price;
@property (nonatomic , strong) Rating              * rating;
@property (nonatomic , strong) NSArray<NSString *>              * author;
@property (nonatomic , copy) NSString              * binding;

@end

@interface RequestViewModel :NSObject
@property (nonatomic , assign) NSInteger              count;
@property (nonatomic , strong) NSArray<Books *>              * books;
@property (nonatomic , assign) NSInteger              total;
@property (nonatomic , assign) NSInteger              start;
@property(nonatomic, strong, readonly)RACCommand *requestCommand;
@property(nonatomic, strong, readonly)RACCommand *clickCommand;

@end

