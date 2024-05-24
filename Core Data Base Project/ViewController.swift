//
//  ViewController.swift
//  Core Data Base Project
//
//  Created by IMAC2 on 05/12/23.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet weak var idTextFieldOutlet: UITextField!
    @IBOutlet weak var nameTextFieldOutlet: UITextField!
    @IBOutlet weak var name2TextfieldOutlet: UITextField!
    @IBOutlet weak var savebuttonOutlet: UIButton!
    @IBOutlet weak var getdataButtonOutlet: UIButton!
    @IBOutlet weak var deleteButtonOutlet: UIButton!
    @IBOutlet weak var updateButtonOutlet: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        savebuttonOutlet.layer.cornerRadius = 10
        getdataButtonOutlet.layer.cornerRadius = 10
        updateButtonOutlet.layer.cornerRadius = 10
        deleteButtonOutlet.layer.cornerRadius = 10
        
    }

    @IBAction func saveButtonAction(_ sender: Any) {
        addData(id: Int(idTextFieldOutlet.text ?? "") ?? 0, name: nameTextFieldOutlet.text)
    }
    
    @IBAction func retriveButtonAction(_ sender: UIButton) {
        retriveData()
    }
    
    @IBAction func updateDataButtonAction(_ sender: UIButton) {
        updateDAta(name1: nameTextFieldOutlet.text ?? "", name2: name2TextfieldOutlet.text ?? "")
    }
    
    @IBAction func deleteDataButtonAction(_ sender: UIButton) {
        deleteData(name: nameTextFieldOutlet.text ?? "")
    }
    
    
    func addData(id:Int,name:String?){
        
        guard let appDeleget = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContext = appDeleget.persistentContainer.viewContext
        let userEntites = NSEntityDescription.entity(forEntityName: "Student", in: manageContext)!
        let user = NSManagedObject.init(entity: userEntites, insertInto: manageContext)
        user.setValue(id, forKey: "id")
        user.setValue(name, forKey: "name")
        
        appDeleget.saveContext()
        print("\nDAta save\n")

//        do{
//            try manageContext.save()
//            print(id)
//            print(name)
//        }catch (let error){
//            print(error.localizedDescription)
//        }
    }
    
    func retriveData(){
        
        guard let appDeleget = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContext = appDeleget.persistentContainer.viewContext
      //  let fetchRequest = Student.fetchRequest()
        let fetchRequest = Student.fetchRequest()
        
        do{
            let result = try manageContext.fetch(fetchRequest)
            
            for i in result{
                print(i.id)
                print(i.name ?? "")
            }
            print("\nDAta Get\n")
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func updateDAta(name1:String,name2:String){
        guard let appDeleget = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContext = appDeleget.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
        
        do{
            let result = try manageContext.fetch(fetchRequest)
            let objectUpdate = result[0] as! NSManagedObject
            objectUpdate.setValue(name2, forKey: "name")
            appDeleget.saveContext()
            print("\nData Update")
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func deleteData(name:String){
        guard let appDeleget = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContext = appDeleget.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        
        do{
            let result = try manageContext.fetch(fetchRequest)
            let objectDelete = result[0] as! NSManagedObject
            
            manageContext.delete(objectDelete)
            appDeleget.saveContext()
            print("\nData Delete\n")
        }catch{
            print(error.localizedDescription)
        }
    }
}

