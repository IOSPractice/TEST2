//
//  TimeTable.swift
//  実習
//
//  Created by 大木一輝 on 2016/05/13.
//  Copyright © 2016年 mycompany. All rights reserved.
//

import UIKit

class TimeTable: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var cells: [MyCollectionViewCell] = []//cellの外部取得用
    var cellText: [String] = []
    var isEditingCell: Bool = false
    
    override func viewDidLoad() {
        //ナビゲーションバーの高さを取得
        
        //コレクションのデータソース、デリゲートの設定
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let saveBtn = UIBarButtonItem(title: "Save", style: .Plain, target: self, action: #selector(TimeTable.saveBtnAction(_:)))
        self.navigationItem.rightBarButtonItems = [saveBtn]
    }
    
    //saveボタンのアクション
    func saveBtnAction(sender: AnyObject) {
        
        if !isEditingCell {
            for cell in cells {
                cell.className.editable = true
                cell.classNum.editable = true
                cell.className.backgroundColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1.0)
                cell.classNum.backgroundColor = UIColor.whiteColor()
            }
            isEditingCell = true
            collectionView.reloadData()
        } else {
            for cell in cells {
                cell.className.editable = false
                cell.classNum.editable = false
                cell.className.backgroundColor = UIColor.whiteColor()
                cell.classNum.backgroundColor = UIColor.lightGrayColor()
            }
            isEditingCell = false
            collectionView.reloadData()
        }
    }

    
    //データの個数を返すメソッド
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 36
    }
    
    
    //セルの生成
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! MyCollectionViewCell
        
        cell.layer.borderWidth = 0.5
        cell.className.text = "これはテストです"
        cell.classNum.text = "1001"
        cells.append(cell)
        
        return cell
    }
    
    //セルのサイズ指定
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.size.width  / 6.0
        let height: CGFloat = collectionView.frame.size.height / 6.0
        return CGSizeMake(width, height)
    }
    
    //セルの垂直方向のマージンを設定
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    //セルの水平方向のマージンを設定
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }


}