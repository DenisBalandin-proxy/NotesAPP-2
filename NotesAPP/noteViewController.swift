//
//  ViewController.swift
//  NotesAPP
//
//  Created by Jorel on 30/03/2022.
//  Copyright © 2022 Jorel. All rights reserved.
//

import UIKit

final class NoteViewController: UIViewController {
    let mainTextView: UITextView = {
        let mainTextView = UITextView()
        mainTextView.translatesAutoresizingMaskIntoConstraints = false
        mainTextView.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
        return mainTextView
    }()
    let titleTextField: UITextField = {
        let titleTextField = UITextField()
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 22)
        return titleTextField
    }()
    let datePickField = UITextField()
    let date = Date()
    var holderDate = String()
    public let defaults = UserDefaults.standard
    public let myButton = UIBarButtonItem()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
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
        navigationItem.rightBarButtonItem = myButton
        datePickField.datePicker(
            targer: self,
            doneAction: #selector(doneAction),
            cancelAction: #selector(cancelAction),
            datePickerMode: .date
        )
        setConstraints()
    }
    func setConstraints() {
        let layoutView = Layout(mainText: mainTextView, title: titleTextField, dateField: datePickField)
        view.addSubview(layoutView)
        NSLayoutConstraint.activate([
            layoutView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            layoutView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            layoutView.rightAnchor.constraint(equalTo: view.rightAnchor),
            layoutView.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])
        mainTextView.becomeFirstResponder()
    }
    public func setCurrentDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, YYYY"
        holderDate = dateFormatter.string(from: date)
        datePickField.placeholder = "\(holderDate)"
    }
    @objc public func stopFocusing() {
        save()
        mainTextView.text = defaults.string(forKey: "mainText")
        titleTextField.text = defaults.string(forKey: "topText")
        let fields = Storage(title: titleTextField.text ?? "", text: mainTextView.text, date: datePickField.text ?? "")
        if fields.empty == "Yes" {
            showEmptyNoteAlert(on: self)
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
        datePickField.resignFirstResponder()
    }
    @objc public func doneAction() {
        if let datePickerView = datePickField.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, YYY"
            let dateString = dateFormatter.string(from: datePickerView.date)
            datePickField.text = dateString
            datePickField.resignFirstResponder()
        }
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
