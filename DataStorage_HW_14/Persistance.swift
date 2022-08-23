import Foundation
import RealmSwift
import CoreData


// Realm
class Task: Object {
    @objc dynamic var taskText = ""
}


// CoreData
let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
let entityDescription = NSEntityDescription.entity(forEntityName: "TaskCD", in: context)
let manegedObject = NSManagedObject(entity: entityDescription!, insertInto: context)


// UserDefaults
class Persistance {
    static let shared = Persistance()
    
    private let kUserNameKey = "Persistance.kUserNameKey"
    var userName: String {
        set { UserDefaults.standard.set(newValue, forKey: kUserNameKey) }
        get { return UserDefaults.standard.string(forKey: kUserNameKey) ?? "" }
    }
    
    private let kUserSurnameKey = "Persistance.kUserSurnameKey"
    var userSurname: String {
        set { UserDefaults.standard.set(newValue, forKey: kUserSurnameKey) }
        get { return UserDefaults.standard.string(forKey: kUserSurnameKey) ?? "" }
    }
    
    
    // Realm
    private let realm = try! Realm()
    
    func addTaskRM(task: Task) {
        try! realm.write {
            realm.add(task)
        }
    }
    
    func getTasksRm() -> [Task] {
        let allTasks = realm.objects(Task.self)
        var tasks: [Task] = []
        for task in allTasks {
            tasks.append(task)
        }
        return tasks
    }
    
    func deleteTaskRm(task: Task) {
        try! realm.write {
            realm.delete(task)
        }
    }
    
    
    // CoreData
    let fethRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskCD")

    
    func addTaskCD(taskText: String) {
        manegedObject.setValue(taskText, forKey: "text")
        appDelegate.saveContext()
    }
    
    
    func getTasksCD() -> [String] {
        var tasks: [String] = []
        do {
            let results = try context.fetch(fethRequest)
            for result in results as! [NSManagedObject] {
                tasks.append(result.value(forKey: "text") as! String)
            }
        } catch {
            print(error)
        }
        return tasks
    }
    
    func deleteTaskCD(taskText: String) {
        do {
            let results = try context.fetch(fethRequest)
            for result in results as! [NSManagedObject] {
                let res = result.value(forKey: "text") as! String
                if res == taskText {
                    context.delete(result)
                }
            }
            appDelegate.saveContext()
        } catch {
            print(error)
        }
        
    }
}


