
import UIKit

class AddUpdateViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var contactTextField: UITextField!    
    @IBOutlet weak var streamTextField: UITextField!
    
    //MARK: Variables
    weak var delegate: AddUpdateViewControllerProtocol?
    
    var dataToPassClosure: ((StudentModel, Int?) -> Void)?
    
    var name: String?
    var contact: String?
    var stream: String?
    var indexOfData: Int?
    
    //MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Student Details"
        self.nameTextField.text = self.name
        self.contactTextField.text = self.contact
        self.streamTextField.text = self.stream
    }
    
    //MARK: Other Methods
    func setData() {
        self.nameTextField.text = self.name ?? ""
        self.contactTextField.text = self.contact ?? ""
        self.streamTextField.text = self.stream ?? ""
    }
    
    //MARK: Button Action
    @IBAction func addUpdateButtonAction(_ sender: Any) {
        
        let name = nameTextField.text ?? ""
        let contact = contactTextField.text ?? ""
        let stream = streamTextField.text ?? ""
        
        self.delegate?.passData(name: name, contact: contact, stream: stream, indexOfData: indexOfData )
        self.navigationController?.popViewController(animated: true)
    
    }

}
