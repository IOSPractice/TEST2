//
//  ClassObject.swift
//  実習
//
//  Created by 大木一輝 on 2016/06/11.
//  Copyright © 2016年 mycompany. All rights reserved.
//

import RealmSwift

class ClassObject: Object {
    dynamic var index: Int = -1
    dynamic var classNam: String = ""
    dynamic var classNum: String = ""
    
    override static func primaryKey() -> String? {
        return "index"
    }
    
}