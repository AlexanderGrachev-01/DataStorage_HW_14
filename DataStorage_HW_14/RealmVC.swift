import UIKit

class RealmVC: UIViewController {

    @IBOutlet weak var taskTextField: UITextField!
    
    @IBOutlet weak var taskTableView: UITableView!
    
    var tasks: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tasks = Persistance.shared.getTasksRm()
    }
    
    
    @IBAction func addTaskButton(_ sender: Any) {
        if let task = taskTextField.text {
            if task != "" {
                tasks.append(task)
                Persistance.shared.addTaskRM(text: task)
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
        cell.taskLabel.text = tasks[indexPath.row]
        return cell
    }
    
    
}
