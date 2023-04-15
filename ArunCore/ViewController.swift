//
//  ViewController.swift
//  ArunCore
//
//  Created by BYOT on 08/02/23.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var contactdata  = NSArray()
    var sender  = [String:String]()
    var num = 0
    var str = "arun"
    
    

    @IBOutlet weak var coreTBL: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.coreTBL.delegate = self
        self.coreTBL.dataSource = self
//        print(sender)
        

    }
    override func viewWillAppear(_ animated: Bool) {
        let app =  UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Contacts")
        do{
            self.contactdata = try context.fetch(fetchrequest) as NSArray
            DispatchQueue.main.async {
                self.coreTBL.reloadData()
            }
            
            
        }
        catch let err as NSError{
            print(err.localizedDescription)
            
        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }



    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contactdata.count

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coreTableViewCell", for: indexPath)as! coreTableViewCell
        let user = self.contactdata.object(at: indexPath.row) as! NSManagedObject
        cell.nameLbl.text = "\(user.value(forKey: "name")     ?? "")"
        cell.phoneLbl.text = "\(user.value(forKey: "phone")  ?? "" )"
        
    
//        print("\(user.value(forKey: "name")     ?? "")")
        
//
//        print(self.contactdata[indexPath.row])
//        print(self.sender)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let push = storyboard?.instantiateViewController(withIdentifier: "myViewController") as! myViewController
        self.navigationController?.pushViewController(push, animated: true)
        let arun = self.contactdata .object(at: indexPath.row) as! NSManagedObject
        self.sender = ["name":"\(arun.value(forKey: "name")     ?? "")"  ,   "phone":"\(arun.value(forKey: "phone")  ?? "" )"]
        self.num = indexPath.row
        push.testno = self.num
        push.ing = self.str
        


        push.receiver = [:]
       push.receiver =  self.sender
        print(self.sender)
        
                
    }
    


}

