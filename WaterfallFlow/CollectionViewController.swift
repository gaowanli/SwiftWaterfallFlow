//
//  CollectionViewController.swift
//  WaterfallFlow
//
//  Created by 高万里 on 15/9/10.
//  Copyright (c) 2015年 高万里. All rights reserved.
//

import UIKit

let reuseIdentifier = "waterfallflowCell"

class CollectionViewController: UICollectionViewController {
    
    /// 布局对象
    @IBOutlet weak var layout: WaterfallFlowLayout!
    /// 数据源对象
    private lazy var dataSource: [WaterfallFlowItem]? = {
        var arrayM = [WaterfallFlowItem]()
        for i in 0..<100 {
            arrayM.append(WaterfallFlowItem())
        }
        return arrayM
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.layout.dataSource = dataSource
        self.layout.rowItemNum = 3
        self.collectionView?.contentSize = CGSizeMake(0, 10000)
        self.collectionView?.reloadData()
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource!.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! Cell
        if let item = dataSource?[indexPath.row] {
            cell.backgroundColor = item.backgroundColor
        }
        cell.indexLabel.text = "\(indexPath.item)"
        return cell
    }
}

class Cell: UICollectionViewCell {
    @IBOutlet weak var indexLabel: UILabel!
}