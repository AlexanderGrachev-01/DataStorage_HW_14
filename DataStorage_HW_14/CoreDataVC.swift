import UIKit
import CoreData

class CoreDataVC: UIViewController {

    @IBOutlet weak var addTaskTextField: UITextField!
    
    @IBOutlet weak var tasksTableView: UITableView!
    
    var tasks: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tasks = Persistance.shared.getTasksCD()
    }
    
    @IBAction func addTask(_ sender: Any) {
        if let task = addTaskTextField.text {
            if task != "" {
                tasks.append(task)
                Persistance.shared.addTaskCD(taskText: task)
                tasksTableView.reloadData()
            }
        }
    }
}

extension CoreDataVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoreDataCell") as! CoreDataCell
        cell.taskLabel.text = tasks[indexPath.row]
        cell.id = indexPath.row
        cell.delegate = self
        return cell
    }
}

extension CoreDataVC: CoreDataCellDelegate {
    func deleteTask(id: Int) {
        tasks.remove(at: id)
        Persistance.shared.deleteTaskCD(taskText: tasks[id])
        tasksTableView.reloadData()
    }
}
