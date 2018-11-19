//
//  DeleteManager.swift
//  XcodeClean
//
//  Created by Michal Majchrzycki on 02.10.2018.
//  Copyright © 2018 MichalMajchrzycki. All rights reserved.
//

import Cocoa

protocol DeleteManagerDelegate {
    func maxCount(value: Int)
    func updateProcess(value: Bool)
}

public class DeleteManager {
    
    static var delegate: DeleteManagerDelegate?
    
    class func delete(cache: [URL]) {
        for cc in cache {
            do {
                if let list = try? FileManager.default.contentsOfDirectory(atPath: cc.path) {
                    delegate?.maxCount(value: list.count)
                    for file in list {
                        delegate?.updateProcess(value: trash(file: cc.appendingPathComponent(file)))
                    }
                }
            }
        }
    }
    
    static func trash(file: URL) -> Bool {
        do {
            try? FileManager.default.trashItem(at: file, resultingItemURL: nil)
            return true
        } catch {
            return false
        }
    }
}
