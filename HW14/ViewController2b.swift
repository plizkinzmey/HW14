import UIKit

class ViewController2b: UIViewController {
    
    @IBOutlet weak var addTaskToTableButton: UIButton!
    @IBOutlet weak var taskNameField: UITextField!
    @IBOutlet weak var taskTable: UITableView!
    var tasks = PersistanceRealm.shared.loadTasks()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addTaskToTableAction(_ sender: Any) {
        PersistanceRealm.shared.addTask(name:taskNameField.text!)
        tasks = PersistanceRealm.shared.loadTasks()
        taskTable.reloadData()
    }
    
}

extension ViewController2b: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TaskTableViewCell
        cell.nameTask.text = tasks[indexPath.row].0
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = UIContextualAction(style: .normal, title: "Done") {
            (_, _, completion) in
            PersistanceRealm.shared.removeTask(taskId: self.tasks[indexPath.row].1)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .right)
            self.tasks.remove(at: indexPath.row)
            tableView.endUpdates()
            completion(true)
        }
        let config = UISwipeActionsConfiguration(actions: [done])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
}
