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
    var toolbarHeight: CGFloat!//ナビゲーションバーの高さ
    
    
    override func viewDidLoad() {
        //ナビゲーションバーの高さを取得
        toolbarHeight = self.navigationController?.toolbar.frame.height
        
        //コレクションのデータソース、デリゲートの設定
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    //データの個数を返すメソッド
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 36
    }
    
    
    //セルの生成
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! MyCollectionViewCell
        
        cell.layer.borderWidth = 0.5
        cell.textView.text = "これはテストです"
        //cell.textView.tag = indexPath.row//タグ番号の登録。内容を取得するときに使用
        cells.append(cell)
        
        return cell
    }
    
    //セルのサイズ指定
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.size.width  / 6.0
        let height: CGFloat = (collectionView.frame.size.height - toolbarHeight) / 6.0
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