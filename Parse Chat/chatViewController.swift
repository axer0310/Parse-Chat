//
//  chatViewController.swift
//  Parse Chat
//
//  Created by Arthur on 2017/2/23.
//  Copyright © 2017年 Jungyoon Yu & Arthur Wu. All rights reserved.
//

import UIKit
import Parse

class chatViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var arthurMesg: UITextField!
    var messages: [PFObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
            tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 20
        tableView.rowHeight = UITableViewAutomaticDimension
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(chatViewController.onTimer), userInfo: nil, repeats: true)
        

        
        self.tableView.reloadData()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
           }
    
    @IBAction func sendMesg(_ sender: Any)
    {
        var msg = PFObject(className:"Message")

        
        var buffer = ""
        if let buffer = arthurMesg.text
        {
            msg["text"] = arthurMesg.text
            msg["user"] = PFUser.current()
        }
        
        msg.saveInBackground { (result, error) in

            if let error = error
            {
                print(error.localizedDescription)
            }
            else
            {

                print(msg["text"])
                self.arthurMesg.text = ""

            }
        }
 
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
            return messages.count;
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {

        let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath) as! chatCell;
        
                   let chat = messages[indexPath.row];
       
        
            let message = chat["text"] as! String;
        var user: PFUser!
        user = chat["user"] as! PFUser
        
        
        
        cell.label.text = user.username! + ": " + message;
     
        return cell;
    }

    func onTimer() {
        // Add code to be run periodically

        let query = PFQuery(className: "Message")
        query.whereKeyExists("user")
        query.includeKey("user")
        query.whereKeyExists("text")
        query.order(byDescending: "createdAt")
        query.limit = 100

        query.findObjectsInBackground { (object, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let messages = object {
                self.messages = messages.reversed()

                self.tableView.reloadData()
                
            }
        }
        print("keep getting")
    }
     /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
