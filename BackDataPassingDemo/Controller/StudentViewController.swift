import UIKit

class StudentViewController: UIViewController {
    
   //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
   //MARK: Arrays
    //var names: [String] = ["shivani"]
    //var contacts: [String] = ["7972"]
    //var streams: [String] = ["ios"]
    
    var students = [StudentModel]()
    
   //MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Student List"
        
        addPlusBarButtonItem()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        let studentNib = UINib(nibName: "StudentTableViewCell",
                               bundle: nil)
        self.tableView.register(studentNib,
                                forCellReuseIdentifier: "StudentTableViewCell")
        
      
        //let studentShivani = StudentModel(name: "shivani", contact: "7972", stream: "civil")
        //self.students.append(studentShivani)
        
    }
    
     //MARK: Other methods
    func addPlusBarButtonItem() {
    let addButton = UIBarButtonItem(barButtonSystemItem: .add,
                                    target: self,
                                    action: #selector(addButtonAction))
        
        self.navigationItem.rightBarButtonItem = addButton
        
    }

    func navigateToAddUpdateVC(index: Int?) {
        guard let addUpdateStudentVC = self.storyboard?.instantiateViewController(withIdentifier: "AddUpdateViewController") as? AddUpdateViewController else {
            return
        }
        
        addUpdateStudentVC.delegate = self
        addUpdateStudentVC.indexOfData = index
        self.navigationController?.pushViewController(addUpdateStudentVC,
                                                      animated: true)
        
    }
    @objc func addButtonAction() {
        navigateToAddUpdateVC(index: nil)
    }
    
}

   //MARK: UITableViewDataSource methods
   extension StudentViewController: UITableViewDataSource {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     self.students.count
 }
 
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     guard let studentCell = self.tableView.dequeueReusableCell(withIdentifier: "StudentTableViewCell") as? StudentTableViewCell else {
         return UITableViewCell()
         
     }
       let student = students[indexPath.row]
       
       studentCell.nameLabel.text = students[indexPath.row].name
       studentCell.contactLabel.text =  students[indexPath.row].contact
       studentCell.streamLabel.text = students[indexPath.row].stream
     
     return studentCell
 }
}

   //MARK: UITableViewDelegate
   extension StudentViewController: UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "AddUpdateViewController") as? AddUpdateViewController {
            
            vc2.delegate = self
            vc2.name = students[indexPath.row].name
            vc2.contact = students[indexPath.row].contact
            vc2.stream = students[indexPath.row].stream
            vc2.indexOfData = indexPath.row
            self.navigationController?.pushViewController(vc2, animated: true)
        }
        
    }
    
}

//MARK: AddUpdateViewControllerProtocol
extension StudentViewController: AddUpdateViewControllerProtocol {
    
    func passData(name: String?, contact: String?, stream: String?, indexOfData: Int?) {
        let studentToAdd = StudentModel(name: name ?? "",
                                        contact: contact ?? "",
                                        stream: stream ?? "")
        
        if let rowIndex = indexOfData {
            self.students[rowIndex] = studentToAdd
        } else {
            self.students.append(studentToAdd)
        }
        self.tableView.reloadData()
        
        
    }
    
}












