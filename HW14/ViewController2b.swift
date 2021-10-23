import UIKit


protocol NewTaskDelegate: class {
    func addTask(taskText: String)
    func updateConstraintTaskTableTop()
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
        cell.nameTask.text = tasks[indexPath.row].0
        cell.checkBoxAction = {
            cell in
            PersistanceRealm.shared.updateTask(taskId: self.tasks[indexPath.row].1)
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = UIContextualAction(style: .normal, title: "Done") {
            (_, _, completion) in
            PersistanceRealm.shared.removeTask(taskId: self.tasks[indexPath.row].1)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.tasks.remove(at: indexPath.row)
            tableView.endUpdates()
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
