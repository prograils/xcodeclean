//
//  WindowController.swift
//  XcodeClean
//
//  Created by Michal on 28/09/2018.
//  Copyright © 2018 MichalMajchrzycki. All rights reserved.
//

import Cocoa
import Foundation

class WindowController: NSWindowController, DeleteManagerDelegate {
    
    @IBOutlet weak var mainWindow: NSWindow!
    @IBOutlet weak var derivedDataCheck: NSButton!
    @IBOutlet weak var derivedDataButton: NSButton!
    @IBOutlet weak var archivesCheck: NSButton!
    @IBOutlet weak var archivesButton: NSButton!
    @IBOutlet weak var deviceSupportCheck: NSButton!
    @IBOutlet weak var deviceSupportButton: NSButton!
    @IBOutlet weak var coreSimulatorCheck: NSButton!
    @IBOutlet weak var coreSimulatorButton: NSButton!
    @IBOutlet weak var dtXcodeCheck: NSButton!
    @IBOutlet weak var dtXcodeButton: NSButton!
    @IBOutlet weak var backupCheck: NSButton!
    @IBOutlet weak var backupButton: NSButton!
    @IBOutlet weak var deleteButton: NSButton!
    @IBOutlet weak var checksStackView: NSStackView!
    @IBOutlet weak var progresBar: NSLevelIndicator!
    @IBOutlet weak var progresLabel: NSTextField!
    
    let paths = PathsToFolders()
    var path = ""
    var selectedPaths: [URL] = []
    var count = 0
    
    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    private func runSpinner() {
        checksStackView.isHidden = true
        deleteButton.isHidden = true
        progresBar.isHidden = false
        progresLabel.isHidden = false
    }
    
    private func stopSpinner() {
        count = 0
        checksStackView.isHidden = false
        deleteButton.isHidden = false
        progresBar.isHidden = true
        progresLabel.isHidden = true
    }
    
    
    // MARK: DeleteManagerDelegate
    
    func maxCount(value: Int) {
        if value >= 1 {
            progresBar.maxValue = Double(value)
        }
    }
    
    func updateProcess(value: Bool) {
        count += 1
        progresBar.doubleValue = Double(count)
        checkProgresBarStatus()
    }
    
    private func checkProgresBarStatus(){
        if progresBar.maxValue >= progresBar.doubleValue {
            stopSpinner()
        }
    }
    
    
    @IBAction func onOpenFinderAction(_ sender: NSButton) {
        
        if sender == derivedDataButton {
            path = paths.derivedData
        } else if sender == archivesButton {
            path = paths.archives
        } else if sender == deviceSupportButton {
            path = paths.deviceSupport
        } else if sender == coreSimulatorButton {
            path = paths.coreSimilator
        } else if sender == dtXcodeButton {
            path = paths.dtXcode
        } else if sender == backupButton {
            path = paths.backup
        }
        NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: paths.user + path)
    }
    
    @IBAction func onSelectPaths(_ sender: NSButton) {
        
        if sender.state == .on {
            let pathUrl = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent(("/" + sender.title), isDirectory: true)
            if FileManager.default.isExecutableFile(atPath: pathUrl.path) {
                selectedPaths.append(pathUrl)
            }
            
        } else {
            let pathUrl = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent(("/" + sender.title), isDirectory: true)
            if let index = selectedPaths.index(of: pathUrl) {
                selectedPaths.remove(at: index)
            }
        }
    }
    
    @IBAction func onDeleteAction(_ sender: NSButton) {
        DeleteManager.delegate = self
        if selectedPaths.count >= 1 {
            runSpinner()
            DeleteManager.delete(cache: selectedPaths)
        }
    }
}
