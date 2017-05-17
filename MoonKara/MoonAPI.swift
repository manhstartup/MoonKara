//
//  MoonAPI.swift
//  MoonKara
//
//  Created by JoJo on 5/6/17.
//  Copyright © 2017 JoJo. All rights reserved.
//

import UIKit
import Alamofire
typealias  callback = ( _ complete: AnyObject,  _ code: Int) ->()

class MoonAPI: NSObject {
//    let urlSearchAPI: String = "https://www.googleapis.com/youtube/v3/search?part=snippet&q=karaoke&type=video&maxResults=50&key=AIzaSyBVxkvxotUl_DizzjfWzZtQrKyGqhPuUv8"
    let urlSuggestAPI: String = "http://suggestqueries.google.com/complete/search?ds=yt&hjson=t&client=youtube&alt=json&hl=hl&ie=utf_8&oe=utf_8&q="

    func urlSearchAPI(param: [String:String]) -> String {
        var strTmp: String = "https://www.googleapis.com/youtube/v3/search?"
        for key in param.keys {
            if(key == "q")
            {
                let escapedString: String = param[key]!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
                strTmp += ("\(key)=\(escapedString)&")
            }
            else
            {
                strTmp += ("\(key)=\(param[key]!)&")
            }
        }
        return strTmp
    }
    func urlDetailVideoAPI(param: [String:String]) -> String {
        var strTmp: String = "https://www.googleapis.com/youtube/v3/videos?"
        for key in param.keys {
                strTmp += ("\(key)=\(param[key]!)&")
        }
        return strTmp
    }
    func getSearchYoutubeAPI(param: [String: String], onComplete:  @escaping callback) {
        Alamofire.request(urlSearchAPI(param: param)).validate().responseJSON { response in
            let (resultValue, resultCode) = self.processingRequest(response: response)
            if (resultCode == 200)
            {
                let JSON = resultValue as! [String : AnyObject]
                let items = JSON["items"] as! [[String: AnyObject]]
                var videoId = ""
                for item in items
                {
                    videoId += (item["id"] as! [String: AnyObject])["videoId"] as! String
                    videoId += ","
                }
                if videoId.characters.count > 0
                {
                    videoId = videoId.substring(to: videoId.index(before: videoId.endIndex))
                    let paramVideos = ["part": "statistics,snippet","id": videoId,"key": "AIzaSyBVxkvxotUl_DizzjfWzZtQrKyGqhPuUv8"]
                    Alamofire.request(self.urlDetailVideoAPI(param: paramVideos)).validate().responseJSON { response in
                        let (resultValue, resultCode) = self.processingRequest(response: response)
                        onComplete(resultValue!, resultCode)
                        
                    }

                }
                else
                {
                    onComplete(resultValue!, resultCode)
                }

            }
            else
            {
                onComplete(resultValue!, resultCode)

            }
            
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
