import UIKit

class RealmVC: UIViewController {

    @IBOutlet weak var taskTextField: UITextField!
    
    @IBOutlet weak var taskTableView: UITableView!
    
    var tasks: [Task] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tasks = Persistance.shared.getTasksRm()
    }
    
    
    @IBAction func addTaskButton(_ sender: Any) {
        if let tasktxt = taskTextField.text {
            if tasktxt != "" {
                let task = Task()
                task.taskText = tasktxt
                tasks.append(task)
                Persistance.shared.addTaskRM(task: task)
                taskTableView.reloadData()
            }
        }
    }
}


extension RealmVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "realmTasks") as! RealmCell
        cell.taskLabel.text = tasks[indexPath.row].taskText
        cell.id = indexPath.row
        cell.delegate = self
        return cell
    }
}


extension RealmVC: RealmCellDelegate {
    func deleteTask(id: Int) {
        Persistance.shared.deleteTaskRm(task: tasks[id])
        tasks.remove(at: id)
        taskTableView.reloadData()
    }
}
