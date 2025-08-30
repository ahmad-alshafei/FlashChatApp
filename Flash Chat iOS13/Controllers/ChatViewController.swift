//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by AhmadALshafei on 19/8/25.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestoreInternal

class ChatViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    let db = Firestore.firestore()
    
    
    
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        tableView.dataSource = self
        title = "Chat"
        messageTextfield.delegate = self
        tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "HeCell")
        
        
        
        loadMessage()
    }
    
    func loadMessage () {
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener{ querySnapshot,error in
            self.messages = []
            if let e = error {
                print ("happened Error in geting data from FireStore \(e)")
            }else {
                if let snapShotDoc = querySnapshot?.documents {

                    for dec in snapShotDoc {
                        let data = dec.data()
                        if let messageSender = data[K.FStore.senderField] as? String, let messagebody = data[K.FStore.bodyField] as? String  {
                            let newMessage = Message(sender: messageSender, body: messagebody)
                            self.messages.append(newMessage)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count-1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
    
    
@IBAction func buttonLogout(_ sender: UIBarButtonItem) {
    do {
        try Auth.auth().signOut()
        navigationController?.popToRootViewController(animated: true)
    } catch let signOutError as NSError {
        print("Error signing out: %@", signOutError)
    }
    
    
}
    
    
    @IBAction func sendPressed(_ sender: Any) {
        
        if messageTextfield.text != ""{
            if let messagebody = messageTextfield.text,let messagesender = Auth.auth().currentUser?.email{
                self.messageTextfield.text = ""
                
                db.collection(K.FStore.collectionName).addDocument(
                    data: [K.FStore.senderField : messagesender,
                           K.FStore.bodyField : messagebody,
                           K.FStore.dateField : Date().timeIntervalSince1970
                           
                          ]) { (error) in
                              if let e = error {
                                  print("happened Error in Saving data to FireStore \(e)")
                              }else {
                                  print("Successfully saved data.")
                              }
                          }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendPressed(self)
        return true
    }

    
}
extension ChatViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        if message.sender == Auth.auth().currentUser?.email {
            let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageViewCell
            cell.labelMessage.text = message.body
            let email = message.sender
            let username = email.components(separatedBy: "@").first ?? email
            
            cell.labelNameSender.text = username
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeCell", for: indexPath) as! MeCellTableViewCell
            cell.labelHeBody.text = message.body
            let email = message.sender
            let username = email.components(separatedBy: "@").first ?? email
            
            cell.labelHeSender.text = username
            
            return cell
        }
    }
    
}
