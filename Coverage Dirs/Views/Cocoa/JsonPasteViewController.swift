//
//  JsonPasteViewController.swift
//  Coverage Dirs
//
//  Created by Dušan Tadić on 01.12.19.
//  Copyright © 2019 Dušan Tadić. All rights reserved.
//

import Cocoa

class JsonPasteViewController: NSViewController {

    @IBOutlet var jsonTextView: NSTextView!
    weak var delegate: JsonPasteViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }

    @IBAction func cancelClicked(_ sender: NSButton) {
        self.dismiss(self)
    }

    @IBAction func okClicked(_ sender: NSButton) {
        self.delegate?.jsonPasted(self.jsonTextView.string)
        self.dismiss(self)
    }

}

protocol JsonPasteViewControllerDelegate: AnyObject {
    func jsonPasted(_ json: String)
}
