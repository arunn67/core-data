//
//  myViewController.swift
//  ArunCore
//
//  Created by BYOT on 08/02/23.
//

import UIKit
import CoreData

class myViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phone: UITextField!
    
    @IBOutlet weak var save: UIButton!
    @IBOutlet weak var edit: UIButton!
    var receiver = [String:String] ()
    
    @IBOutlet weak var backBTN: UIButton!
    var testno = 0
    
    
    @IBOutlet weak var deletBtn: UIButton!
    
    var ing = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        self.save.addTarget(self, action: #selector(saveaction(sender:)), for: .touchUpInside)
        self.edit.addTarget(self, action: #selector(editaction(sender:)), for: .touchUpInside)
        self.backBTN.addTarget(self, action: #selector(backbtn(sender: )), for: .touchUpInside)
        self.deletBtn.addTarget(self, action: #selector(deleteaction(sender:)), for: .touchUpInside)

        
      
       

        print(self.receiver)
        self.edit.isHidden = true
        self.deletBtn.isHidden = true
        self.name.text = self.receiver["name"]
        self.phone.text = self.receiver["phone"]
        
        if self.ing == "arun"{
            self.save.isHidden = true
            self.edit.isHidden = false
            self.deletBtn.isHidden = false
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    @objc func saveaction(sender:UIButton){
        if name.text! == ""{
            print("enter")
        }else if phone.text! == ""{
            print("enter")
        }
        else{
            self.saveTheData()

            
        }

    

   

}
    @objc func editaction(sender:UIButton){
        if name.text! == ""{
            print("enter")
        }
        
        else if phone.text! == ""{
            print("enter")
        }
        else{
            self.updatedata()
            let push = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            self.navigationController?.pushViewController(push, animated: true)
            
            
        }
        
}
    @objc func backbtn(sender:UIButton){
        self.name.text = ""
        self.phone.text = ""
       
    }
    
    @objc func deleteaction(sender:UIButton){
        if name.text! == ""{
            print("enter")
        }else if phone.text! == ""{
            print("enter")
        }
        else{
            self.deletedata()
            
        }
    }
    

    
    func saveTheData () {
        let app =  UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        let contacts =  NSEntityDescription.insertNewObject(forEntityName: "Contacts", into: context)
        contacts.setValue(self.name.text!, forKey: "name")
        contacts.setValue(self.phone.text!, forKey: "phone")
        do {
            try context.save()
        }
        catch let err as NSError{
            print(err.localizedDescription)
            
        }
        self.navigationController?.popViewController(animated: true)
        
    }
    func updatedata() {
        let app =  UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Contacts")
//        fetchrequest.predicate = NSPredicate(format: "name = %@ ", self.name.text!)
        
        do {
            let test = try context.fetch(fetchrequest)
            let objectupdate = test[self.testno] as! NSManagedObject
            objectupdate.setValue(self.name.text!, forKey: "name")
            objectupdate.setValue(self.phone.text!, forKey: "phone")
            do{
                try context.save()
                
            }catch{
                print("err")
            }


            
        }
        catch {
            print("eerr")
        }
        
    }
    func deletedata(){
        let app =  UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Contacts")
        fetchrequest.predicate = NSPredicate(format: "name = %@ ", self.name.text!)
        
        do {
            let test = try context.fetch(fetchrequest)
            let objectdelet = test[self.testno] as! NSManagedObject
            context.delete(objectdelet)
            do{
                try context.save()
                
            }catch{
                print("err")
            }


            
        }
        catch {
            print("eerr")
        }
        
    }
    
    
}
