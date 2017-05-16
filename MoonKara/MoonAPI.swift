//
//  MoonAPI.swift
//  MoonKara
//
//  Created by JoJo on 5/6/17.
//  Copyright © 2017 JoJo. All rights reserved.
//

import UIKit
import Alamofire
import SWXMLHash
typealias  callback = ( _ complete: AnyObject,  _ code: Int) ->()

class MoonAPI: NSObject {
//    let urlSearchAPI: String = "https://www.googleapis.com/youtube/v3/search?part=snippet&q=karaoke&type=video&maxResults=50&key=AIzaSyBVxkvxotUl_DizzjfWzZtQrKyGqhPuUv8"
    let urlSuggestAPI: String = "http://suggestqueries.google.com/complete/search?ds=yt&hjson=t&client=youtube&alt=json&hl=hl&ie=utf_8&oe=utf_8&q="
    func urlSearchAPI(param: [String:String]) -> String {
        var strTmp: String = "https://www.googleapis.com/youtube/v3/search?"
        for key in param.keys {
            strTmp += ("\(key)=\(param[key]!)&")
        }
        let escapedString = strTmp.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)

        return escapedString!
    }
    
    func getSearchYoutubeAPI(param: [String: String], onComplete:  @escaping callback) {
        Alamofire.request(urlSearchAPI(param: param)).validate().responseJSON { response in
            let (resultValue, resultCode) = self.processingRequest(response: response)
            onComplete(resultValue!, resultCode)
            
        }
        
    }
    func getSuggestYoutubeAPI(keyword: String, onComplete: @escaping callback) {
        let escapedString = keyword.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let urlTmp = urlSuggestAPI + escapedString!
        Alamofire.request(urlTmp).validate().responseJSON { response in
            
            let (resultValue, resultCode) = self.processingRequest(response: response)
            onComplete(resultValue!, resultCode)
        }

    }
    //MARK: -- processing Request
    func processingRequest(response: DataResponse<Any>) -> (returnData: AnyObject?, code: Int) {
        switch response.result
        {
        case .success(let JSON):
            
            print("Validation Successful")
            return (JSON as AnyObject, 200)
        case .failure(let error):
            print(error)
            
            return (error.localizedDescription as AnyObject, (error as NSError).code)
        }
    }
}
