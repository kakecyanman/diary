//
//  Event.swift
//  nikki
//
//  Created by 阿迦井翔 on 2020/04/21.
//  Copyright © 2020 kakeru.geek. All rights reserved.
//

import Foundation
import RealmSwift

class Event: Object {
    
    @objc dynamic var date: String = ""
    @objc dynamic var event: String = ""
    
}
