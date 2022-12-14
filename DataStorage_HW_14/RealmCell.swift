import UIKit

protocol RealmCellDelegate {
    func deleteTask(id: Int)
}

class RealmCell: UITableViewCell {
    
    @IBOutlet weak var taskLabel: UILabel!

    var delegate: RealmCellDelegate?
    
    var id = 0
    
    @IBAction func doneTask(_ sender: Any) {
        delegate?.deleteTask(id: id)
    }
}
