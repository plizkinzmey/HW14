import UIKit
import CloudKit


protocol NewTaskDelegate: AnyObject {
    func addTask(taskText: String)
    func updateConstraintTaskTableTop()
}

protocol TaskUpdateDelegate: AnyObject {
    func updateTask(taskText: String, taskId: String)
}

class ViewController2b: UIViewController {
    
    
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var taskTableTop: NSLayoutConstraint!
    @IBOutlet weak var taskNameField: UITextField!
    @IBOutlet weak var taskTable: UITableView!
    var tasks = PersistanceRealm.shared.loadTasks()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNewTask" {
            if let newTaskVC = segue.destination as? NewTaskViewController {
                newTaskVC.newTaskDelegate = self
            }
        }
    }
    
    
    @IBAction func plusButtonAction(_ sender: Any) {
        taskTableTop.constant = 50
    }
    
    
}

extension ViewController2b: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TaskTableViewCell
        cell.editTaskField.isHidden = true
        cell.acceptEditTaskButton.isHidden = true
        cell.exitWithoutSaveButton.isHidden = true
        cell.taskUpdateDelegate = self
        cell.nameTask.text = tasks[indexPath.row].0
        cell.taskId = tasks[indexPath.row].1
        if tasks[indexPath.row].2 == true {
            cell.checkBoxDone.on = true
        } else {
            cell.checkBoxDone.on = false
        }
        cell.checkBoxAction = {
            cell in
            PersistanceRealm.shared.updateTaskStatus(taskId: self.tasks[indexPath.row].1)
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = UIContextualAction(style: .destructive, title: "??????????????") {
            (_, _, completion) in
            PersistanceRealm.shared.removeTask(taskId: self.tasks[indexPath.row].1)
            tableView.beginUpdates()
            self.tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            tableView.reloadData()
            completion(true)
        }
        let config = UISwipeActionsConfiguration(actions: [done])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
}

extension ViewController2b: NewTaskDelegate {
    func addTask(taskText: String) {
        PersistanceRealm.shared.addTask(name: taskText)
        tasks = PersistanceRealm.shared.loadTasks()
        taskTable.reloadData()
    }
    
    func updateConstraintTaskTableTop() {
        taskTableTop.constant = 10
    }
}

extension ViewController2b: TaskUpdateDelegate {
    func updateTask(taskText: String, taskId: String) {
        PersistanceRealm.shared.updateTaskName(taskId: taskId, taskName: taskText)
        tasks = PersistanceRealm.shared.loadTasks()
        taskTable.reloadData()
    }
}
