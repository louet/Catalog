//
//  Log.swift
//  Catalog
//
//  Created by 권영각 on 2015. 10. 27..
//  Copyright © 2015년 LTCompany. All rights reserved.
//

import Foundation

class Log {
    func p(targetClass: AnyObject, message: String) {
        print("[\(targetClass)] : \(message)")
    }
}