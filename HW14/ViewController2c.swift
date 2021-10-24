import UIKit
import CoreData

class ViewController2c: UIViewController {
    
    var tasks: [Tasks] = []
    
    @IBOutlet weak var CDTaskField: UITextField!
    @IBOutlet weak var CDAddTaskButton: UIButton!
    @IBOutlet weak var CDTableView: UITableView!
    
    func saveTask(withTitle title: String) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Tasks", in: context) else { return }
        
        let taskObject = Tasks(entity: entity, insertInto: context)
        taskObject.title = title
        taskObject.isDone = false
        
        do {
            try context.save()
            tasks.append(taskObject)
            CDTableView.reloadData()
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Tasks> = Tasks.fetchRequest()
        
        do {
            tasks = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addTaskCDButton(_ sender: Any) {
        saveTask(withTitle: CDTaskField.text!)
    }
}

extension ViewController2c: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellCD") as! CDTaskTableViewCell
        let task = tasks[indexPath.row]
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        cell.CDTaskCellLAbel.text = task.title
        
        if tasks[indexPath.row].isDone == true {
            cell.checkBoxCD.on = true
        } else {
            cell.checkBoxCD.on = false
        }
        cell.checkBoxAction = {
            cell in
            do {
                try context.save()
                self.tasks[indexPath.row].isDone = !(self.tasks[indexPath.row].isDone)
                self.CDTableView.reloadData()
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") {
            (_, _, completion) in
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let index = indexPath.row
            
            context.delete(self.tasks[index] as NSManagedObject)
            do {
                try context.save()
                self.tasks.remove(at: indexPath.row)
                self.CDTableView.reloadData()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            completion(true)
        }
        
        let config = UISwipeActionsConfiguration(actions: [delete])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
}
