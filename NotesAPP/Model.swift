//
//  Model.swift
//  NotesAPP
//
//  Created by Jorel on 20/04/2022.
//  Copyright © 2022 Jorel. All rights reserved.
//

import UIKit

//class Model: UIView {


struct Model {
    
    var title: String
    var date: String
    var text: String

}

            struct EmptyCheck {
                
        var emptyState = String()
        var emptyString = String()
        var empty: String? {
            get {
                return emptyState
            }
            set (newValue) {
                if newValue?.isEmpty ?? true {
                    emptyState = "Yes"
                } else {
                    emptyState = "No"
                }
            }
        }
    }
    
//}
