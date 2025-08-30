//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by AhmadALshafei on 19/8/25.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController , UITextFieldDelegate{

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBOutlet weak var lblErrorMsg: UILabel!
    
    override func viewDidLoad() {
        title = "Register"
        lblErrorMsg.text = ""
        emailTextfield.delegate = self
        passwordTextfield.delegate = self

        emailTextfield.attributedPlaceholder = NSAttributedString(
            string: "Your Email" ,
            attributes: [
                .foregroundColor: UIColor.lightGray,
                .font: UIFont.systemFont(ofSize: 18, weight: .medium)
            ]
        )
        
        passwordTextfield.attributedPlaceholder = NSAttributedString(
            string: "Your Password",
            attributes: [
                .foregroundColor: UIColor.lightGray,
                .font: UIFont.systemFont(ofSize: 18, weight: .medium)
            ]
        )


    }
    @IBAction func registerPressed(_ sender: UIButton) {
        
        if let email = emailTextfield.text, let password = passwordTextfield.text{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    self.lblErrorMsg.text = e.localizedDescription
                } else {
                    self.performSegue(withIdentifier: K.registerSegue, sender: self)
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextfield {
            passwordTextfield.becomeFirstResponder()
        }else if textField == passwordTextfield {
            view.endEditing(true)
            if let email = emailTextfield.text, let password = passwordTextfield.text{
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if let e = error {
                        self.lblErrorMsg.text = e.localizedDescription
                    } else {
                        self.performSegue(withIdentifier: K.registerSegue, sender: self)
                    }
                }
            }

        }
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
