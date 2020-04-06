//
//  MockTask.swift
//  FixedSolutionChallangeTests
//
//  Created by Alaa on 4/6/20.
//  Copyright © 2020 FixedSolution. All rights reserved.
//

import Foundation

class MockTask: URLSessionDataTask {

    private let data:Data?
    private let urlResponse:URLResponse?
    private let err:Error?
    
    var completionHander:((Data?,URLResponse?,Error?)->Void)?
    
     init(data:Data?,urlResponse:URLResponse?,err:Error?) {
        self.data = data
        self.urlResponse = urlResponse
        self.err = err
    }
    
    override func resume() {
        DispatchQueue.main.async {
            self.completionHander?(self.data, self.urlResponse, self.err)
        }

    }
}
