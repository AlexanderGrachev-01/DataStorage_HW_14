import Foundation
import RealmSwift
import CoreData

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
}


// Realm
class Task: Object {
    @objc dynamic var taskText = ""
}


// CoreData
//@objc class TaskCD: NSManagedObject {
//    @NSManagedObject public var text: String?
//}

