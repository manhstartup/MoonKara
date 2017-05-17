//
//  MoonTabBarVC.swift
//  MoonKara
//
//  Created by JoJo on 5/17/17.
//  Copyright © 2017 JoJo. All rights reserved.
//

import UIKit

class MoonTabBarVC: UITabBarController,UITabBarControllerDelegate {
    var playerView: MoonPlayer!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.delegate = self
        playerView = MoonPlayer.fromNib() as! MoonPlayer
        playerView.customization()
        self.view.addSubview(playerView)
        NotificationCenter.default.addObserver(self, selector: #selector(displayPlayer(notification:)), name: NSNotification.Name("open"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //create Tab one
        
    }
    
    func displayPlayer(notification: NSNotification) {
        if let item = notification.userInfo {
            let videoID = item["id"]  as! String
            let linkYoutube = "https://www.youtube.com/watch?v=" +  videoID
            // do something with your image
            playerView.state = .fullScreen
            playerView.animate()
            playerView.didEndedSwipe(toState: playerView.state)
            playerView.playVideo(linkYoutube)
        }

    }

}
