//
//  Lauout.swift
//  NotesAPP
//
//  Created by Jorel on 18/04/2022.
//  Copyright © 2022 Jorel. All rights reserved.
//

import UIKit

class Layout: UIView {
    init(mainText: UITextView, title: UITextField, dateField: UITextField) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        mainText.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(mainText)
        self.addSubview(title)
        self.addSubview(dateField)
        title.translatesAutoresizingMaskIntoConstraints = false
        dateField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainText.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
            mainText.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            mainText.rightAnchor.constraint(equalTo: self.rightAnchor),
            mainText.leftAnchor.constraint(equalTo: self.leftAnchor),
            title.topAnchor.constraint(equalTo: dateField.bottomAnchor, constant: 5),
            title.rightAnchor.constraint(equalTo: self.rightAnchor),
            title.leftAnchor.constraint(equalTo: self.leftAnchor),
            dateField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 5),
            dateField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            dateField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20)
        ])
        dateField.textAlignment = .center
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension UITextField {
    func datePicker<T>(
        targer: T,
        doneAction: Selector,
        cancelAction: Selector,
        datePickerMode: UIDatePicker.Mode = .date
    ) {
        let screenWidth = UIScreen.main.bounds.width
        func buttonItem(withSystemItemStyle style: UIBarButtonItem.SystemItem) -> UIBarButtonItem {
            let buttonTarget = style == .flexibleSpace ? nil : targer
            let action: Selector? = {
                switch style {
                case .cancel:
                    return cancelAction
                case .done:
                    return doneAction
                default:
                    return nil
                }
            }()
            let barButtonItem = UIBarButtonItem(
                barButtonSystemItem: style,
                target: buttonTarget,
                action: action
            )
            return barButtonItem
        }
        let datePicker = UIDatePicker(frame: CGRect(
            x: 0,
            y: 0,
            width: screenWidth,
            height: 216
        ))
        datePicker.datePickerMode = datePickerMode
        self.inputView = datePicker
        let toolBar = UIToolbar(frame: CGRect(
            x: 0,
            y: 0,
            width: screenWidth,
            height: 44
        ))
        toolBar.setItems(
            [buttonItem(withSystemItemStyle: .cancel),
             buttonItem(withSystemItemStyle: .flexibleSpace),
             buttonItem(withSystemItemStyle: .done)],
            animated: true
        )
        self.inputAccessoryView = toolBar
    }
}
