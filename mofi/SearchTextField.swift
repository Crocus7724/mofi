//
// Created by 山本一樹 on 2018/01/28.
// Copyright (c) 2018 Kazuki Yamamoto. All rights reserved.
//

import Foundation
import Cocoa

struct hoge {

}

class SearchTextField: NSTextField {
    convenience init(){
        self.init()
    }

    override func cancelOperation(_ sender: Any?) {
        NSApp.terminate(self)
    }
}

