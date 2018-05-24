//
//  ViewerTests.m
//  ViewerTests
//
//  Created by Applied Materials on 21/05/18.
//  Copyright © 2018 Personal. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "responseImage.h"
#import "Utilities.h"
#import "ConstantsHeader.h"
#import "NetworkManager.h"
#import "ImageTableViewCell.h"
@interface ViewerTests : XCTestCase
{
    NSDictionary *details ;
}
@property  responseImage *resultImage;
@property  Utilities *utilities;
@end

@implementation ViewerTests

- (void)setUp {
    [super setUp];
    //result image
    self.resultImage = [[responseImage alloc]init];
    self.resultImage.title = @"Sajith";
    self.resultImage.imageURL = @"http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg";
    self.resultImage.descriptionText = @"description";
    //sample dic
    details = [[NSMutableDictionary alloc]init];
    [details setValue:@"Sajith" forKey:KeyTitle];
    [details setValue:@"http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg" forKey:KeyImageUrl];
    [details setValue:@"description" forKey:KeyDecription];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testResponseImage {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    responseImage *testImage = [[responseImage alloc]initWithDictionay:details];
    XCTAssertEqualObjects(self.resultImage.title, testImage.title, @"Not true");
    XCTAssertEqualObjects(self.resultImage.descriptionText, testImage.descriptionText, @"Not true");
    XCTAssertEqualObjects(self.resultImage.imageURL, testImage.imageURL, @"Not true");
}
-(void)testUtilities{
    NSArray *testResult =[Utilities parseDictionaryListToImageModelList:@[details]];
    responseImage *testFirtElement = (responseImage *)testResult[0];
    XCTAssertEqualObjects(testFirtElement.title,self.resultImage.title);
 XCTAssertEqualObjects(testFirtElement.descriptionText,self.resultImage.descriptionText);
    XCTAssertEqualObjects(testFirtElement.imageURL,self.resultImage.imageURL);
}
//Network manager
- (void)testNetworkManagerDataFetch {
    XCTestExpectation *expectation = [self expectationWithDescription:@"fetch data"];
    [NetworkManager fetchDatawithCompletion:^(NSDictionary *data) {
    XCTAssertNotNil(data);
    [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:30 handler:^(NSError *error) {
        XCTAssertNil(error);
    }];
}
- (void)testNetworkManagerretrieveJSON {
    XCTestExpectation *expectation = [self expectationWithDescription:@"retrieve json"];
    NSURL *url = [NSURL URLWithString:
                  @"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"];
    [NetworkManager retrieveJSONWithConnectionAtURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        XCTAssertNotNil(data);
            NSString *responseString = [[NSString alloc]initWithData:data encoding:kCFStringEncodingUTF8];
            NSData *datanew = [responseString dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:datanew options:kNilOptions error:&error];
        XCTAssertNotNil(jsonResponse);
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:30 handler:^(NSError *error) {
        XCTAssertNil(error);
    }];
}
-(void)testImageTableViewCell{
    ImageTableViewCell* sampleCell = [[ImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"] ;
    [sampleCell setupCell:self.resultImage];
    XCTAssertEqualObjects(sampleCell.title.text, @"Sajith");
    XCTAssertEqualObjects(sampleCell.descriptionLabel.text, @"description");
    XCTestExpectation *expectation = [self expectationWithDescription:@"retrieve image"];
    dispatch_async(dispatch_queue_create("com.app.viewer",NULL), ^{
        NSURL *url = [NSURL URLWithString:self.resultImage.imageURL];
            UIImage *profile = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        XCTAssertNotNil(profile);
         [expectation fulfill];
    });
    [self waitForExpectationsWithTimeout:30 handler:^(NSError *error) {
        XCTAssertNil(error);
    }];
}
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
