//
//  MockURLSession.swift
//  FixedSolutionChallangeTests
//
//  Created by Alaa on 4/6/20.
//  Copyright © 2020 FixedSolution. All rights reserved.
//

import Foundation

class MockURLSession: URLSession {

    var cachedUrl:URL?
    private let mockDataTask:MockTask
     init(data:Data?,urlResponse:URLResponse?,err:Error?) {
        mockDataTask = MockTask(data: data, urlResponse: urlResponse, err: err)
    }
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        cachedUrl = request.url
        mockDataTask.completionHander = completionHandler
        return mockDataTask
    }
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        cachedUrl = url
        mockDataTask.completionHander = completionHandler
        return mockDataTask
    }
}
