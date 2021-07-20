//
//  GifLiveLikeProjectTests.swift
//  GifLiveLikeProjectTests
//
//  Created by Abhinav Mandloi on 12/07/21.
//

import XCTest
@testable import GifLiveLikeProject

class GifLiveLikeProjectTests: XCTestCase {
    
    func testTreandingAPI() {
        
        let expectation = self.expectation(description: "testTreandingAPI")
        
        let gifTrendingService: TrendingGifService = TrendingGifService()
        
        gifTrendingService.getGifs(){ (_gifResponse) in
            
            if(_gifResponse?.gif != nil)
            {
                XCTAssertNotNil(_gifResponse?.gif[0].title)
                XCTAssertNotNil(_gifResponse?.gif[0].url)
                expectation.fulfill()
            }
            else {
                XCTFail("Gif Request request error")
                expectation.fulfill()
                
            }
        }
        self.waitForExpectations(timeout: 10) { (error) in
            XCTAssertNil(error, "Something went wrong, request took too long.")
        }
    }
    
    func testSearchAPI() {
        
        let expectation = self.expectation(description: "testTreandingAPI")
        
        let gifSearchService: SearchGifService = SearchGifService(gifSearchText: "Happy")
        
        gifSearchService.getGifs(){ (_gifResponse) in
            
            if(_gifResponse?.gif != nil)
            {
                XCTAssertNotNil(_gifResponse?.gif[0].title)
                XCTAssertNotNil(_gifResponse?.gif[0].url)
                
                expectation.fulfill()
            }
            else {
                XCTFail("Gif Request request error")
                expectation.fulfill()
                
            }
        }
        self.waitForExpectations(timeout: 10) { (error) in
            XCTAssertNil(error, "Something went wrong, request took too long.")
        }
    }
    
    
    
}
