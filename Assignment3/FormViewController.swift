import UIKit

class FormViewController: UIViewController, UITextFieldDelegate {
    
    // text fields
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    

    @IBOutlet weak var nameValid: UIImageView!
    @IBOutlet weak var emailValid: UIImageView!
    @IBOutlet weak var passwordValid: UIImageView!
    @IBOutlet weak var phoneValid: UIImageView!
    

    // table field
    @IBOutlet weak var contactsTable: UITableView!
    
    // declare an instance of model
    private let formModel = FormModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
       
        
        // set the name field delegate
        nameText.delegate = self
        emailText.delegate = self
        passwordText.delegate = self
        phoneText.delegate = self
        
        
        // set the tableview data source
        contactsTable.dataSource = self
        
        signUpButton.isEnabled = false
        
        // constantly check if button was pressed
        nameText.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        emailText.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        passwordText.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        phoneText.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedBackground))
        view.addGestureRecognizer(tap)
    }
    
    
    
    // adds a name to the tableview
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        addPeople()
        clear()
    }
    
    // resets table and textviews
    @IBAction func resetButtonTapped (_ sender: UIButton) {
        clear()
        formModel.resetPeoples()
        resetPeople()
    }
    
    // clears the textViews
    @IBAction func clearButtonTapped (_ sender: UIButton) {
        clear()
    }
    
    // checks if background is tapped
    @objc func tappedBackground() {
        view.endEditing(true)
    }
    
    
    
    private func addPeople() {
        guard let name = nameText.text else {
            return
        }
        
        // add the name to the array in the instance class
        formModel.addPeople(name: name)
        nameText.text = nil
        
        // refresh the table
        contactsTable.reloadData()
        
        // assign first responder
        view.endEditing(true)
    }
    
    
    private func resetPeople() {
        
        // refresh the table
        contactsTable.reloadData()
        
        // assign first responder
        view.endEditing(true)
        
    }

    
    private func clear() {
        nameText.text = ""
        emailText.text = ""
        passwordText.text = ""
        phoneText.text = ""
        
        nameValid.image = nil
        emailValid.image = nil
        passwordValid.image = nil
        phoneValid.image = nil
        
        }
    
    
    // closes the keyboard upon the return key or done button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        if textField == nameText {
            textField.resignFirstResponder()
            emailText.becomeFirstResponder()
        } else if textField == emailText {
            textField.resignFirstResponder()
            passwordText.becomeFirstResponder()
        } else if textField == passwordText {
            textField.resignFirstResponder()
            phoneText.becomeFirstResponder()
        } else if textField == phoneText {
            textField.resignFirstResponder()
            signUpButton.becomeFirstResponder()
        }
        
        return true
    }

    
    
    // FUNCTION IS CALLED EVERYTIME A BUTTON ON THE KEYBOARD IS PRESSED
    @objc func editingChanged(_ textField: UITextField) {
    
        //manages the sign up button
        if formModel.nameVal(name: nameText.text), formModel.phoneVal(phone: phoneText.text), formModel.pwVal(password: passwordText.text), formModel.emailVal(email: emailText.text) == true{
            self.signUpButton.isEnabled = true
        } else {
            self.signUpButton.isEnabled = false
        }
        
        
        //manges the validation icons
        //name
        if formModel.nameVal(name: nameText.text) == true{
            let yourImage: UIImage = UIImage(named: "valid.jpg")!
            nameValid.image = yourImage
        } else {
            let yourImage: UIImage = UIImage(named: "invalid.jpg")!
            nameValid.image = yourImage
        }

        //email
        if formModel.emailVal(email: emailText.text) == true{
            let yourImage: UIImage = UIImage(named: "valid.jpg")!
            emailValid.image = yourImage
        } else {
            let yourImage: UIImage = UIImage(named: "invalid.jpg")!
            emailValid.image = yourImage
        }

        //password
        if formModel.pwVal(password: passwordText.text) == true{
            let yourImage: UIImage = UIImage(named: "valid.jpg")!
            passwordValid.image = yourImage
        } else {
            let yourImage: UIImage = UIImage(named: "invalid.jpg")!
            passwordValid.image = yourImage
        }

        //phone
        if formModel.phoneVal(phone: phoneText.text) == true{
            let yourImage: UIImage = UIImage(named: "valid.jpg")!
            phoneValid.image = yourImage
        } else {
            let yourImage: UIImage = UIImage(named: "invalid.jpg")!
            phoneValid.image = yourImage
        }
    }
    
}


// extension that determines number of rows in table
extension FormViewController {
    

    
    func textFieldShouldReturn(texter textField: UITextField) -> Bool {
        addPeople()
        return true
    }
}


// calls table and input name to cell
extension FormViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return formModel.numberOfPeoples
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath)

        guard let name = formModel.person(atIndex: indexPath.row) else {
            return cell
    }

    // Set the cell's text label to the movie title
    cell.textLabel?.text = name
    return cell
    }
}
















