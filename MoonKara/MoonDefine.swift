//
//  MoonDefine.swift
//  MoonKara
//
//  Created by JoJo on 5/17/17.
//  Copyright © 2017 JoJo. All rights reserved.
//

import UIKit
extension UIView {
    class func fromNib<T : UIView>() -> T {
        let kclass:String = String.init(describing: self)
        return Bundle.main.loadNibNamed(kclass, owner: nil, options: nil)![0] as! T
    }
}

enum stateOfVC
{
    case minimized
    case fullScreen
    case hidden
}
enum Direction {
    case up
    case down
    case left
    case right
    case none
}
