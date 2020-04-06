//
//  MovieServicesTests.swift
//  FixedSolutionChallangeTests
//
//  Created by Alaa on 4/6/20.
//  Copyright © 2020 FixedSolution. All rights reserved.
//

import XCTest
@testable import FixedSolutionChallange

class MovieServicesTests: XCTestCase {

    typealias responseHandler = (Result<BaseModel<[MovieModel]>, ApiError>)->Void
    var jsonData = "{\"results\":[{\"title\": \"Bad boys\",\"poster_path\": \"/y95lQLnuNKdPAzw9F9Ab8kJ80c3.jpg\"}]}".data(using: .utf8)
    let httpResponse = HTTPURLResponse(url: URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=47cd13548fd27bb3d1b4d9a59c3bb745&language=en-US&page=1")!, statusCode: 200, httpVersion: nil, headerFields: nil)

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetMoviewWithExpectedURLHostAndPath() {
        let mockUrlSession = MockURLSession(data: nil,urlResponse: nil,err: nil)
        let networkManger = MovieNetworkManger(mockUrlSession)
        networkManger.discoverMovie(by: 1) { (result) in
            
        }
        XCTAssertEqual(mockUrlSession.cachedUrl?.host, "api.themoviedb.org")
        XCTAssertEqual(mockUrlSession.cachedUrl?.path, "/3/movie/now_playing")

    }
    
    func testGetMoviewServicesSuccessReturnsTags() {
        
        let mockUrlSession = MockURLSession(data: jsonData,urlResponse: httpResponse,err: nil)
        
        let networkManger = MovieNetworkManger(mockUrlSession)

        var movie:[MovieModel]?
        let movieExpectation = expectation(description: "movies")
        networkManger.discoverMovie(by: 1) { (result) in
            switch result{
            case .success(let model):
                movie = model.results
                movieExpectation.fulfill()
             default:
                break
            }
        }
        
        waitForExpectations(timeout: 10) { (err) in
            XCTAssertNotNil(movie)
            XCTAssertEqual(movie?.first?.title,"Bad boys")
        }

    }
    func testGetTagsInvalidJSONReturnsError() {
            jsonData = "[{\"t\"}]".data(using: .utf8)
           
           let mockUrlSession = MockURLSession(data: jsonData,urlResponse: httpResponse,err: nil)
           
           let networkManger = MovieNetworkManger(mockUrlSession)
           let errorExpectation = expectation(description: "error")
           var errorResponse: ApiError?
        networkManger.discoverMovie(by: 1) { (result) in
            switch result{
            case .failure(let err):
                errorResponse = err
                errorExpectation.fulfill()
            default:
                break
            }
        }
           waitForExpectations(timeout: 10) { (error) in
               XCTAssertNotNil(errorResponse)
           }
       }
}
