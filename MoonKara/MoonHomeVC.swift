//
//  MoonHomeVC.swift
//  MoonKara
//
//  Created by JoJo on 5/6/17.
//  Copyright © 2017 JoJo. All rights reserved.
//

import UIKit
import SDWebImage
let moonSongCellId = "moonSongCellId"
class MoonHomeVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    //MARK: - PROPERTIES
    @IBOutlet weak var tableView: UITableView!
    var listVideo = [[String: AnyObject]]()
    
    //MARK: VIEWCONTROLLER LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let getSearch: MoonAPI = MoonAPI()
        let param = ["part": "snippet","type": "video","maxResults": "50","key": "AIzaSyBVxkvxotUl_DizzjfWzZtQrKyGqhPuUv8","q": "karaoke"]
        getSearch.getSearchYoutubeAPI(param: param) { (response, code) in
            if code == 200
            {
                if let items = response["items"]
                {
                    self.listVideo = items as! [[String : AnyObject]]
                    self.tableView.reloadData()
                }
            }
        }
//        getSearch.getSuggestYoutubeAPI(keyword: "con mua tuoi thanh xuan") { (response, code) in
//            
//        }
        //
        tableView.register(UINib.init(nibName: "MoonSongCell", bundle: nil), forCellReuseIdentifier: moonSongCellId)
        tableView.estimatedRowHeight = 70
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: TABLEVIEW DELEGATE
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listVideo.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: moonSongCellId, for: indexPath) as! MoonSongCell
        let snippet = self.listVideo[indexPath.row]["snippet"] as! [String: AnyObject]
        let thumbNail = (((snippet["thumbnails"] as! [String: AnyObject])["default"] as! [String: AnyObject]))["url"] as! String
        let url = URL.init(string: thumbNail)
        cell.imgThumbnail.sd_setImage(with: url)
        cell.lbTitle.text = snippet["title"] as? String
        let statistics = self.listVideo[indexPath.row]["statistics"] as! [String: AnyObject]
        cell.lbCountView.text = statistics["viewCount"] as? String
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: NSNotification.Name("open"), object: nil)
    }

}
