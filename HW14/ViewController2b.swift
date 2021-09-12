import UIKit

class ViewController2b: UIViewController {
    
    @IBOutlet weak var addTaskToTableButton: UIButton!
    @IBOutlet weak var taskNameField: UITextField!
    let tasks = PersistanceRealm.shared.loadTasks()
    override func viewDidLoad() {
        super.viewDidLoad()
        print(tasks)
    }
    
    @IBAction func addTaskToTableAction(_ sender: Any) {
        PersistanceRealm.shared.addTask(name:taskNameField.text!)
        PersistanceRealm.shared.removeTask(id: "1")
        print(tasks)
    }
    
}

extension ViewController2b: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TaskTableViewCell
        cell.nameTask.text = tasks[indexPath.row].0
        return cell
    }

}
