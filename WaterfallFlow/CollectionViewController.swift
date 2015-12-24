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
    private var dataSource: [WaterfallFlowItem] = [WaterfallFlowItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: "refreshDataSource")
        
        refreshDataSource()
    }
    
    /// 刷新数据源
    func refreshDataSource() {
        dataSource.removeAll()
        for _ in 0..<40 {
            dataSource.append(WaterfallFlowItem())
        }
        
        layout.dataSource = dataSource
        layout.rowItemNum = 3
        collectionView?.reloadData()
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! Cell
        cell.backgroundColor = dataSource[indexPath.row].backgroundColor
        cell.indexLabel.text = "\(indexPath.item)"
        return cell
    }
}

class Cell: UICollectionViewCell {
    @IBOutlet weak var indexLabel: UILabel!
}