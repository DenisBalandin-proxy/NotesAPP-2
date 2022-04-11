//
//  ViewController.swift
//  NotesAPP
//
//  Created by Jorel on 30/03/2022.
//  Copyright © 2022 Jorel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private let textView = UITextView()
    private let defaults = UserDefaults.standard
    private let textField = UITextField()

    private let myButton = UIBarButtonItem()
    private let mainTextView: UITextView = {
        let mainTextView = UITextView()
        mainTextView.translatesAutoresizingMaskIntoConstraints = false
        return mainTextView
    }()

    private let titleTextField: UITextField = {
        let titleTextField = UITextField()
        titleTextField.translatesAutoresizingMaskIntoConstraints = false

        return titleTextField
    }()

    let datePickField = UITextField()
    let date = Date()
    var holderDate = String()
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
    override func viewDidLoad() {
        super.viewDidLoad()

        mainTextView.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
        titleTextField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 22)

        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(
            self,
            selector: #selector(save),
            name: UIApplication.willTerminateNotification,
            object: nil
        )
        let myButton = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(stopFocusing))

        titleTextField.placeholder = "Название заметки"

        setCurrentDate()

        if datePickField.text != nil || datePickField.text != "" {
            datePickField.text = defaults.string(forKey: "dateField")
        }

        mainTextView.text = defaults.string(forKey: "mainText")
        titleTextField.text = defaults.string(forKey: "topText")

        view.addSubview(mainTextView)
        view.addSubview(textView)
        view.addSubview(titleTextField)
        view.addSubview(datePickField)

        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = myButton
        setConstraints()
        datePickField.translatesAutoresizingMaskIntoConstraints = false
        mainTextView.becomeFirstResponder()
        self.datePickField.datePicker(
            targer: self,
            doneAction: #selector(doneAction),
            cancelAction: #selector(cancelAction),
            datePickerMode: .date
        )
    }

    private func setCurrentDate() {
        // var a = String()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, YYYY"
        holderDate = dateFormatter.string(from: date)
        datePickField.placeholder = "\(holderDate)"
    }

    private func setConstraints() {
        titleTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        titleTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true

        datePickField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor).isActive = true
        datePickField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        datePickField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true

        datePickField.textAlignment = .center

        mainTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        mainTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        mainTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        mainTextView.topAnchor.constraint(equalTo: datePickField.bottomAnchor).isActive = true
        mainTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    @objc func stopFocusing() {
        save()

        mainTextView.text = defaults.string(forKey: "mainText")
        titleTextField.text = defaults.string(forKey: "topText")

        var emptyCck = EmptyCheck()
        emptyCck.empty = mainTextView.text
        let val1 = emptyCck.empty
        emptyCck.empty = titleTextField.text
        let val2 = emptyCck.empty

        if val1 == "Yes" && val2 == "Yes" {
            showEmptyNoteAlert(on: self)
        } else {
            mainTextView.resignFirstResponder()
            titleTextField.resignFirstResponder()
        }
    }

    @objc func save() {
        let mainText = mainTextView.text
        let topView = titleTextField.text
        let dateField = datePickField.text
        defaults.set(topView, forKey: "topText")
        defaults.set(mainText, forKey: "mainText")
        defaults.set(dateField, forKey: "dateField")
    }

    @objc func cancelAction() {
        self.datePickField.resignFirstResponder()
    }

    @objc func doneAction() {
        if let datePickerView = self.datePickField.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, YYY"
            let dateString = dateFormatter.string(from: datePickerView.date)
            self.datePickField.text = dateString
            self.datePickField.resignFirstResponder()
        }
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

extension UIViewController {
    func showAlertt(on viewController: UIViewController, with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    func showEmptyNoteAlert (on viewController: UIViewController) {
        showAlertt(on: viewController, with: "ERROR", message: "Your note is empty!")
    }
}
