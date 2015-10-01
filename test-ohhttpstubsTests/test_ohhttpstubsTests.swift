//
//  test_ohhttpstubsTests.swift
//  test-ohhttpstubsTests
//
//  Created by Yu, William on 10/1/15.
//  Copyright © 2015 Yu, William. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Alamofire
import OHHTTPStubs

class RequestsSpec: QuickSpec {
    var data0:Result<String>? = nil
    var data:Result<String>? = nil
    var data2: NSData? = nil
    
    override func spec() {
        describe("the request") {
            it("needs to make a request") {
                
                stub(isHost("httpbin.org")) { _ in
                    let stubData = "Hello World!".dataUsingEncoding(NSUTF8StringEncoding)
                    return OHHTTPStubsResponse(data: stubData!, statusCode:200, headers:nil)
                }
                
                print("@@Start")
                Alamofire.request(.GET, "http://httpbin.org/get", parameters: ["foo": "bar"])
                    .responseString() { request, response, data in
                        print("###")
                        print(request)
                        print(response)
                        print(data)
                        print(data.value)
                        self.data = data
                }
                
                //                let url = NSURL(string: "http://httpbin.org/get")
                //                let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
                //                    print("###")
                //                    print(NSString(data: data!, encoding: NSUTF8StringEncoding))
                //                    self.data2 = data
                //                }
                //                task.resume()
                
                expect(self.data0).toEventuallyNot(beNil(), timeout: 3)
                expect(self.data).toEventuallyNot(beNil(), timeout: 3)
                print("@@End")
            }
        }
    }
}