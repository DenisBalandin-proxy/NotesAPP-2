//
//  Model.swift
//  NotesAPP
//
//  Created by Jorel on 20/04/2022.
//  Copyright © 2022 Jorel. All rights reserved.
//

import UIKit

final class Storage {
    var title = String()
    var date = String()
    var text = String()
    let viewController = NoteViewController()

    init(title: String, text: String, date: String) {
        self.title = title
        self.date = date
        self.text = text
    }
    var emptiness = String()
    var empty: String {
        if title == "" && text == "" {
            emptiness = "Yes"
        }
        return emptiness
    }
}
