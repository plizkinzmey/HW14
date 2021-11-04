import UIKit
import CoreData

protocol TaskUpdateCDDelegate: AnyObject {
    func updateTask(model: Tasks, newTaskName: String?, isDone: Bool?)
}

class ViewController2c: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var models = [Tasks]()
    
    
    @IBOutlet weak var CDTaskField: UITextField!
    @IBOutlet weak var CDAddTaskButton: UIButton!
    @IBOutlet weak var CDTableView: UITableView!
    
    func getAllTasks() {
        do {
            models = try context.fetch(Tasks.fetchRequest())
            DispatchQueue.main.async {
                self.CDTableView.reloadData()
            }
        }
        catch {
            
        }
    }
    
    func createTask (name: String) {
        
        let newTask = Tasks(context: context)
        newTask.title = name
        newTask.isDone = false
        
        do {
            try context.save()
            getAllTasks()
        }
        catch {
            
        }
        
    }
    
    func deleteTask(task: Tasks) {
        context.delete(task)
        
        do {
            try context.save()
            getAllTasks()
        }
        catch {
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllTasks()
    }
    
    @IBAction func addTaskCDButton(_ sender: Any) {
        self.createTask(name: CDTaskField.text!)
        CDTaskField.text = ""
    }
}

extension ViewController2c: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return models.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellCD") as! CDTaskTableViewCell
        let model = models[indexPath.row]
        cell.nameTask.text = model.title
        cell.model = model
        cell.isDone = model.isDone
        cell.editTaskField.isHidden = true
        cell.acceptEditTaskButton.isHidden = true
        cell.exitWithoutSaveButton.isHidden = true
        cell.taskUpdateCDDelegate = self
        
        if model.isDone == true {
            cell.checkBoxDone.on = true
        } else {
            cell.checkBoxDone.on = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") {
            (_, _, completion) in
            
            let model = self.models[indexPath.row]
            self.deleteTask(task: model)
            
            completion(true)
        }
        
        let config = UISwipeActionsConfiguration(actions: [delete])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
}

extension ViewController2c: TaskUpdateCDDelegate {
    func updateTask(model: Tasks, newTaskName: String?, isDone: Bool?) {
        if newTaskName != nil{
            model.title = newTaskName
            print(model.title)
            print(model.isDone)
        }
        if isDone != nil {
            model.isDone = !(model.isDone)
            print(model.title)
            print(model.isDone)
        }
        do {
            try context.save()
            getAllTasks()
        }
        catch {
            
        }
    }
}

