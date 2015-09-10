//
//  WaterfallFlowItem.swift
//  WaterfallFlow
//
//  Created by 高万里 on 15/9/10.
//  Copyright (c) 2015年 高万里. All rights reserved.
//

import UIKit

class WaterfallFlowItem: NSObject {
    var width: CGFloat
    var height: CGFloat
    var backgroundColor: UIColor
    
    override init() {
        width = CGFloat(arc4random_uniform(110) % 100 + 100)
        height = CGFloat(arc4random_uniform(110) % 100 + 100)
        backgroundColor = UIColor(red: CGFloat(arc4random_uniform(255)) / 255.0, green: CGFloat(arc4random_uniform(255)) / 255.0, blue: CGFloat(arc4random_uniform(255)) / 255.0, alpha: 1.0)
    }
}
