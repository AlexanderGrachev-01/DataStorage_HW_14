import UIKit

protocol CoreDataCellDelegate {
    func deleteTask(id: Int)
}

class CoreDataCell: UITableViewCell {
    
    @IBOutlet weak var taskLabel: UILabel!
    
    var delegate: CoreDataCellDelegate?
    
    var id = 0

    @IBAction func doneTask(_ sender: Any) {
        delegate?.deleteTask(id: id)
    }
}
