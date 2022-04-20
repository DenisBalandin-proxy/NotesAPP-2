//
//  Lauout.swift
//  NotesAPP
//
//  Created by Jorel on 18/04/2022.
//  Copyright © 2022 Jorel. All rights reserved.
//

import UIKit

class Lauout: UIView {
    
    
    
    
    
    let vc = ViewController()
    
  //  let mainTextView: UITextView = {
               
  //         let mainTextView = UITextView()
               
    //           return mainTextView
//               }()
    
    
    
    
    
    //   let view = UIView()
           
    
    

    
    
    
    
    func setConstraints(){
        
        
        
        vc.datePickField.translatesAutoresizingMaskIntoConstraints = false
        
        
       
        
        vc.mainTextView.translatesAutoresizingMaskIntoConstraints = false
        
        self.backgroundColor = .white
       
        self.addSubview(vc.mainTextView)
     self.addSubview(vc.titleTextField)
        self.addSubview(vc.datePickField)
        
         
        vc.mainTextView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        vc.mainTextView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        vc.mainTextView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        vc.mainTextView.topAnchor.constraint(equalTo: vc.titleTextField.safeAreaLayoutGuide.bottomAnchor).isActive = true
        vc.mainTextView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

        vc.mainTextView.backgroundColor = .yellow
        
        vc.mainTextView.becomeFirstResponder()
        
                vc.titleTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
              vc.titleTextField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        vc.titleTextField.topAnchor.constraint(equalTo: vc.datePickField.bottomAnchor, constant: 20).isActive = true
        
        
        
        vc.datePickField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
             vc.datePickField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
             vc.datePickField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true

             vc.datePickField.textAlignment = .center
        
        vc.titleTextField.placeholder = "Название заметки"
        
        vc.setCurrentDate()
        
        
        
        vc.datePickField.datePicker(
                            targer: self,
                            doneAction: #selector(vc.doneAction),
        cancelAction: #selector(vc.cancelAction),
                            datePickerMode: .date
                        )
        
        
        

        

     }
    
    
    func button() {
        

        
     
        
        
        
        
    }
    
    
    
    
}


