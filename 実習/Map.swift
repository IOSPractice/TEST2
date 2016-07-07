//
//  ViewController.swift
//  testapp
//
//  Created by 境聖也 on 2016/05/08.
//  Copyright © 2016年 kakkokari. All rights reserved.
//

import UIKit


class Map: UIViewController {
    
    
    
    //@IBOutlet weak var TextField: UITextField!
    @IBOutlet weak var TextField: UITextField!
    
    //@IBOutlet weak var Label: UILabel!
    @IBOutlet weak var Label: UILabel!
    
    
    let gou1 = 1100.0
    let gou2 = 2100.0
    let gou3 = 3100.0
    let gou6 = 6100.0
    let gou8 = 8100.0
    let gou9 = 9100.0
    let gou11 = 11100.0
    let gou12 = 12100.0
    let gou12s = 120.0
    
    //private var ImageView: UIImageView!
    @IBOutlet weak var ImageView: UIImageView!

    func ImageViewTest(num:Double) -> Void {
        // UIImageViewを作成する.
        
        //ImageView = UIImageView(frame: CGRectMake(0,0,350,270))
        // 表示する画像を設定する.
        
        //1
        if(num >= gou1 && num <= gou1 + 400){
            let myImage = UIImage(named: "TDUMAP01.png")
            //Users/seiya/Desktop/TDUMAP/TDUMAP01.png
            //let myImage = UIImage(named:"/TDUMAP/TDUMAP01.png")
            ImageView.image = myImage
        }
            //2
        else if(num >= gou2 && num <= gou2 + 400){
            let myImage = UIImage(named: "TDUMAP02.png")
            ImageView.image = myImage
        }
            //3
        else if(num >= gou3 && num <= gou3 + 300){
            let myImage = UIImage(named: "TDUMAP03.png")
            ImageView.image = myImage
        }
            //6
        else if(num >= gou6 && num <= gou6 + 400){
            let myImage = UIImage(named: "TDUMAP06.png")
            ImageView.image = myImage
        }
            //8
        else if(num >= gou8 && num <= gou8 + 400){
            let myImage = UIImage(named: "TDUMAP08.png")
            ImageView.image = myImage
        }
            //9
        else if(num >= gou9 && num <= gou9 + 400){
            let myImage = UIImage(named: "TDUMAP09.png")
            ImageView.image = myImage
        }
            //10
        else if((num >= 110 && num <= 119) || (num >= 200 && num <= 220)){
            let myImage = UIImage(named: "TDUMAP10.png")
            ImageView.image = myImage
        }
            //11
        else if(num >= gou11 && num <= gou11 + 300){
            let myImage = UIImage(named: "TDUMAP11.png")
            ImageView.image = myImage
        }
            //12
        else if((num >= gou12 && num <= gou12+499)||(num >= gou12s+100 && num <= gou12s+279)||(num >= gou12s && num <= gou12s+79)){
            let myImage = UIImage(named: "TDUMAP12.png")
            ImageView.image = myImage
        }
        
        //let myImage = UIImage(named: "/Users/seiya/Desktop/TDUMAP/TDUMAP00.png")
        
        // 画像をUIImageViewに設定する.
        //ImageView.image = myImage
        
        // 画像の表示する座標を指定する.
        ImageView.layer.position = CGPoint(x: self.view.bounds.width/2, y: 250.0)
        
        // UIImageViewをViewに追加する.
        self.view.addSubview(ImageView)
    }
    
    //@IBAction func button(sender: AnyObject) {
    @IBAction func button(sender: UIButton) {
    
    
        // textFieldの値を取得する
        //let inputText = TextField.text
        
        _ = TextField.text
        
        var myValue=0.0
        
        if Double(TextField.text!) != nil{
            
            myValue=Double(TextField.text!)!
            
        }
        // 取得した値をLabel上に表示する
        //Label.text = inputText
        
        /*10号館*/
        if(myValue >= 110 && myValue <= 119){
            Label.text = "10号館１階"
        }else if(myValue >= 200 && myValue <= 220){
            Label.text = "10号館2階"
        }
            /*1号館*/
        else if(myValue >= 1100 && myValue <= 1199){
            Label.text = "1号館１階"
        }else if(myValue >= 1200 && myValue <= 1299){
            Label.text = "1号館2階"
        }else if(myValue >= 1300 && myValue <= 1399){
            Label.text = "1号館3階"
        }else if(myValue >= 1400 && myValue <= 1499){
            Label.text = "1号館4階"
        }
            /*2号館*/
        else if(myValue >= 2100 && myValue <= 2199){
            Label.text = "2号館1階"
        }else if(myValue >= 2200 && myValue <= 2299){
            Label.text = "2号館2階"
        }else if(myValue >= 2300 && myValue <= 2399){
            Label.text = "2号館3階"
        }else if(myValue >= 2400 && myValue <= 2499){
            Label.text = "2号館4階"
        }
            /*3号館*/
        else if(myValue >= 3100 && myValue <= 3199){
            Label.text = "３号館１階"
        }else if(myValue >= 3200 && myValue <= 3299){
            Label.text = "３号館2階"
        }else if(myValue >= 3300 && myValue <= 3399){
            Label.text = "３号館3階"
        }
            /*6号館*/
        else if(myValue >= 6100 && myValue <= 6199){
            Label.text = "6号館１階"
        }else if(myValue >= 6200 && myValue <= 6299){
            Label.text = "6号館2階"
        }else if(myValue >= 6300 && myValue <= 6399){
            Label.text = "6号館3階"
        }else if(myValue >= 6400 && myValue <= 6499){
            Label.text = "6号館4階"
        }
            /*8号館*/
        else if(myValue >= 8100 && myValue <= 8199){
            Label.text = "8号館１階"
        }else if(myValue >= 8200 && myValue <= 8299){
            Label.text = "8号館2階"
        }else if(myValue >= 8300 && myValue <= 8399){
            Label.text = "8号館3階"
        }else if(myValue >= 8400 && myValue <= 8499){
            Label.text = "8号館4階"
        }
            /*9号館*/
        else if(myValue >= gou9 && myValue <= gou9+99){
            Label.text = "9号館１階"
        }else if(myValue >= gou9+100 && myValue <= gou9+199){
            Label.text = "9号館2階"
        }else if(myValue >= gou9+200 && myValue <= gou9+299){
            Label.text = "9号館3階"
        }else if(myValue >= gou9+300 && myValue <= gou9+399){
            Label.text = "9号館4階"
        }
            /*11号館*/
        else if(myValue >= gou11 && myValue <= gou11+99){
            Label.text = "11号館１階"
        }else if(myValue >= gou11+100 && myValue <= gou11+199){
            Label.text = "11号館2階"
        }else if(myValue >= gou11+200 && myValue <= gou11+299){
            Label.text = "11号館3階"
        }
            /*12号館*/
        else if((myValue >= gou12 && myValue <= gou12+99)||(myValue >= gou12s && myValue <= gou12s+79)){
            Label.text = "12号館１階"
        }else if((myValue >= gou12+100 && myValue <= gou12+199)||(myValue >= gou12s+100 && myValue <= gou12s+179)){
            Label.text = "12号館2階"
        }else if((myValue >= gou12+200 && myValue <= gou12+299)||(myValue >= gou12s+200 && myValue <= gou12s+279)){
            Label.text = "12号館3階"
        }else if(myValue >= gou12+300 && myValue <= gou12+399){
            Label.text = "12号館4階"
        }else if(myValue >= gou12+400 && myValue <= gou12+499){
            Label.text = "12号館5階"
        }else{
            Label.text = "ERROR"
        }
        
        ImageViewTest(myValue)
        
        // 次の入力の為にtextFieldをクリアする
        //TextField.text = nil
        
        TextField.resignFirstResponder()
        
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

