//
//  PathsToFolders.swift
//  XcodeClean
//
//  Created by Michal Majchrzycki on 02.10.2018.
//  Copyright © 2018 MichalMajchrzycki. All rights reserved.
//

import Foundation

public struct PathsToFolders {
    let user = FileManager.default.homeDirectoryForCurrentUser.path
    let derivedData = "/Library/Developer/Xcode/DerivedData"
    let archives = "/Library/Developer/Xcode/Archives"
    let deviceSupport = "/Library/Developer/Xcode/iOS DeviceSupport"
    let coreSimilator = "/Library/Developer/CoreSimulator/Devices"
    let dtXcode = "/Library/Caches/com.apple.dt.Xcode"
    let backup = "/Library/Application Support/MobileSync/Backup"
}
