//
//  Realm.swift
//  nikki
//
//  Created by 阿迦井翔 on 2020/05/08.
//  Copyright © 2020 kakeru.geek. All rights reserved.
//

import Foundation
import RealmSwift

class Diary:Object {
    // Diaryを保存
    @objc dynamic var title = ""
    // 表示用日付を保存
    @objc dynamic var diaryDate = ""
    // 配列用日付を保存
    @objc dynamic var keyDate = ""
    // uuidを保存
    @objc dynamic var id = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
