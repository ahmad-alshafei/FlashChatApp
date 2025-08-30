//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by AhmadALshafei on 19/8/25.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import UIKit
import CLTypingLabel
class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    @IBOutlet weak var messageapp: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Welcome"
        messageapp.text  = ""
        titleLabel.text = "⚡️FlashChat"
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.messageapp.text = "Chat faster, simpler, smarter"
        }

       
    }
    
    // MARK: - We can add animation on text by use this functation or use hilp from cocopods CLTypingLabel
    
    func animateText(_ text: String, label: UILabel) {
        label.text = ""
        for (index, letter) in text.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1 * Double(index)) {
                label.text?.append(letter)
            }
        }
    }


}
