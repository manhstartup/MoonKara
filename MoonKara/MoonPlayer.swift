//
//  MoonPlayer.swift
//  MoonKara
//
//  Created by JoJo on 5/17/17.
//  Copyright © 2017 JoJo. All rights reserved.
//

import UIKit
import AVFoundation

class MoonPlayer: UIView, UIGestureRecognizerDelegate {
    //MARK: PROPERTIES
    @IBOutlet weak var player: UIView!
    
    var state = stateOfVC.hidden
    var direction = Direction.none
    var videoPlayer = AVPlayer.init()

    //MARK: Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
    }
    //MARK: METHOD PLAYER
    func customization() {
        self.backgroundColor = UIColor.clear
        self.player.layer.anchorPoint.applying(CGAffineTransform(translationX: -0.5, y: -0.5))
        self.player.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MoonPlayer.tapPlayView)))
        self.player.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(MoonPlayer.minimizeGestureAction)))
        self.frame.origin = self.hiddenOrigin
        
        //create AVPlayer
        let playerLayer = AVPlayerLayer.init(player: self.videoPlayer)
        playerLayer.frame =  self.player.bounds
        self.player.layer.addSublayer(playerLayer)

    }
    func animate() {
        switch self.state {
        case .fullScreen:
            UIView.animate(withDuration: 0.3, animations: {
                self.player.transform = CGAffineTransform.identity
                UIApplication.shared.isStatusBarHidden = false
            })
        case .minimized:
            UIView.animate(withDuration: 0.3, animations: {
                UIApplication.shared.isStatusBarHidden = true
                let scale = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
                let trasform = scale.concatenating(CGAffineTransform.init(translationX: -self.player.bounds.width/4, y: -self.player.bounds.height/4))
                self.player.transform = trasform
            })
        default:break
            
        }
    }
    func changeValues(scaleFactor: CGFloat) {
        let scale = CGAffineTransform.init(scaleX: (1 - 0.5 * scaleFactor), y: (1 - 0.5 * scaleFactor))
        let trasform = scale.concatenating(CGAffineTransform.init(translationX: -(self.player.bounds.width / 4 * scaleFactor), y: -(self.player.bounds.height / 4 * scaleFactor)))
        self.player.transform = trasform

    }
    //MARK: METHOD SELF
    let hiddenOriginRight: CGPoint = {
        let y = UIScreen.main.bounds.height - (UIScreen.main.bounds.width * 9 / 32) - 10
        let x = UIScreen.main.bounds.width
        let coordinate = CGPoint.init(x: x, y: y)
        return coordinate
    }()
    let hiddenOrigin: CGPoint = {
        let y = UIScreen.main.bounds.height - (UIScreen.main.bounds.width * 9 / 32) - 10
        let x = -UIScreen.main.bounds.width
        let coordinate = CGPoint.init(x: x, y: y)
        return coordinate
    }()
    let minimizedOrigin: CGPoint = {
        let x = UIScreen.main.bounds.width/2 - 10
        let y = UIScreen.main.bounds.height - (UIScreen.main.bounds.width * 9 / 32) - 10
        let coordinate = CGPoint.init(x: x, y: y)
        return coordinate
    }()
    let fullScreenOrigin = CGPoint.init(x: 0, y: 0)

    func animatePlayView(toState: stateOfVC) {
        switch toState {
        case .fullScreen:
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: UIViewAnimationOptions.beginFromCurrentState, animations: {
                self.frame.origin = self.fullScreenOrigin
            })
        case .minimized:
            UIView.animate(withDuration: 0.3, animations: {
                self.frame.origin = self.minimizedOrigin
            })
        case .hidden:
            UIView.animate(withDuration: 0.3, animations: {
                if self.direction == .right
                {
                    self.frame.origin = self.hiddenOriginRight
                }
                else
                {
                    self.frame.origin = self.hiddenOrigin
                }
            })
        }
    }
    func positionDuringSwipe(scaleFactor: CGFloat) -> CGPoint {
        let width = UIScreen.main.bounds.width * 0.5 * scaleFactor
        let height = width * 9 / 16
        let x = (UIScreen.main.bounds.width - 10) * scaleFactor - width
        let y = (UIScreen.main.bounds.height - 10) * scaleFactor - height
        let coordinate = CGPoint.init(x: x, y: y)
        return coordinate
    }
    func didMinimize() {
        self.animatePlayView(toState: .minimized)
    }
    
    func didmaximize(){
        self.animatePlayView(toState: .fullScreen)
    }
    
    func didEndedSwipe(toState: stateOfVC){
        self.animatePlayView(toState: toState)
    }
    func swipeToMinimize(translation: CGFloat, toState: stateOfVC){
        switch toState {
        case .fullScreen:
            self.frame.origin = self.positionDuringSwipe(scaleFactor: translation)
        case .hidden:
            self.frame.origin.x = UIScreen.main.bounds.width/2 + translation - 10
        case .minimized:
            self.frame.origin = self.positionDuringSwipe(scaleFactor: translation)
        }
    }
    //MARK: ACTION
    func tapPlayView() {
        self.videoPlayer.play()
        self.state = .fullScreen
        self.didmaximize()
        self.animate()
    }
    @IBAction func minimizeAction(_ sender: UIButton)
    {
        self.state = .minimized
        self.didMinimize()
        self.animate()

    }
    @IBAction func minimizeGestureAction(_ sender: UIPanGestureRecognizer)
    {
        // xác định phương hướng trên/dưới/phải/trái khi bắt đầu pan
        if  sender.state == .began {
            let velocity = sender.velocity(in: nil)
            if abs(velocity.x) < abs(velocity.y){
                if velocity.y < 0 {
                    self.direction = .up
                }
                else
                {
                    self.direction = .down
                }
            }
            else
            {
                if velocity.x > 0 {
                    self.direction = .right
                }
                else{
                    self.direction = .left
                }
            }
        }
        //trong quá trình pan
        var finalState  = stateOfVC.fullScreen
        switch self.state {
        case .fullScreen:
            var yTranslation = sender.translation(in: nil).y
            if self.direction == .up {
                if yTranslation < 0 {
                    yTranslation = 0
                }
            }
            let factor = (yTranslation / UIScreen.main.bounds.height)
            self.changeValues(scaleFactor: factor)
            self.swipeToMinimize(translation: factor, toState: .minimized)
            finalState = .minimized
        case .minimized:
            if self.direction == .left {
                finalState = .hidden
                let factor: CGFloat = sender.translation(in: nil).x
                self.swipeToMinimize(translation: factor, toState: .hidden)
            }
            else if self.direction == .right {
                let factor: CGFloat = sender.translation(in: nil).x
                self.swipeToMinimize(translation: factor, toState: .hidden)
            }
            else if self.direction == .up {
                finalState = .fullScreen
                let factor = 1 - (abs(sender.translation(in: nil).y) / UIScreen.main.bounds.height)
                self.changeValues(scaleFactor: factor)
                self.swipeToMinimize(translation: factor, toState: .fullScreen)
            }
            else if self.direction == .down {
                finalState = .minimized
                let factor = 1 + (abs(sender.translation(in: nil).y) / UIScreen.main.bounds.height)
                self.changeValues(scaleFactor: factor)
                self.swipeToMinimize(translation: factor, toState: .minimized)

            }

        default: break
        }
        if sender.state == .ended {
            //state: fullScreen -> minimized
            if self.state == .fullScreen {
                let velocity = sender.velocity(in: nil).y
                let xLocation = self.frame.origin.y
                if abs(velocity) > 1000
                {
                    if xLocation > 50 {
                        finalState = .minimized
                        
                    }
                    else
                    {
                        finalState = .fullScreen
                    }
                }
                else
                {
                    if (xLocation > UIScreen.main.bounds.height*0.2)
                    {
                        finalState = .minimized
                    }
                    else
                    {
                        finalState = .fullScreen
                    }
                }
            }
                //sate: minimized -> hiden
            else if self.state == .minimized
            {
                let velocity = sender.velocity(in: nil)
                let xLocation = self.frame.origin.x
                if abs(velocity.x) > abs(velocity.y) {
                    if abs(velocity.x) > 1000
                    {
                        if xLocation > UIScreen.main.bounds.width - 50 {
                            finalState = .minimized
                            
                        }
                        else
                        {
                            finalState = .hidden
                        }
                    }
                    else
                    {
                        if (xLocation > UIScreen.main.bounds.width*0.5)
                        {
                            finalState = .minimized
                        }
                        else
                        {
                            finalState = .hidden
                        }
                    }
                }
                else
                {
                    
                }

            }
            
            self.state = finalState
            self.animate()
            self.didEndedSwipe(toState: self.state)
            if self.state == .hidden {
                self.videoPlayer.pause()
            }
        }
        
    }
    //MARK: - AVPlayer
    func playVideo(_ linkYoutube: String) {
        let urlYoutube = URL.init(string: linkYoutube)

        DispatchQueue.main.async(execute: {
            ParseLinkVideo.h264videosWithYoutubeURL(urlYoutube!, completion: { (videoInfo, error) in
                if let videoURLString = videoInfo?["url"] as? String,
                    let videoTitle = videoInfo?["title"] as? String {
                    print("\(videoTitle)")
                    print("\(videoURLString)")
                    let videoLink = URL.init(string: videoURLString)
                    let playerItem = AVPlayerItem.init(url: videoLink!)
                    self.videoPlayer.replaceCurrentItem(with: playerItem)
                    if self.state != .hidden {
                        self.videoPlayer.play()
                    }
                    
                }
                
            })
        })

    }
}
