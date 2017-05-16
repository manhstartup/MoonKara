//
//  MoonHomeVC.swift
//  MoonKara
//
//  Created by JoJo on 5/6/17.
//  Copyright © 2017 JoJo. All rights reserved.
//

import UIKit
class MoonHomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let getSearch: MoonAPI = MoonAPI()
        let param = ["part": "snippet","type": "video","maxResults": "5","key": "AIzaSyBVxkvxotUl_DizzjfWzZtQrKyGqhPuUv8","q": "karaoke"]
//        getSearch.getSearchYoutubeAPI(param: param) { (response, code) in
//            
//        }
        getSearch.getSuggestYoutubeAPI(keyword: "con mua tuoi thanh xuan") { (response, code) in
            
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
