import Foundation

class FormModel {
    
    private var peoples = [String]()
    
    init() {}
    
    var numberOfPeoples: Int {
        return peoples.count
    }
    
    //add name to table
    func addPeople(name: String) {
        peoples.append(name)
        peoples.sort()
        print("\(peoples[0])")
    }
    
    // returns the name of person at array id
    func person(atIndex index: Int) -> String? {
        return self.peoples.element(atIndex: index)
    }
    
    // reset peoples array to nil
    func resetPeoples() {
        peoples.removeAll()
    }
    
    // validate name
    func nameVal(name: String?) -> Bool {
        if (name?.count)! >= 3{
            return true
        } else { return false }
    }
    
    // validate email
    func emailVal(email: String?) -> Bool{
        if isValidEmail(email: email) == true {
            return true
        } else { return false }
    }
    
    // validate password
    func pwVal(password: String?) -> Bool {
        if (password?.count)! >= 7 {
            return true
        } else { return false }
    }
    
    // validate password
    func phoneVal(phone: String?) -> Bool {
        if isValidPhone(value: phone) == true {
            return true
        } else { return false }
    }
    
    //regex for email
    func isValidEmail(email:String?) -> Bool {
        guard email != nil else { return false }
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return pred.evaluate(with: email)
    }
    
    //regex for phone
    func isValidPhone(value: String?) -> Bool {
        let PHONE_REGEX = "^\\(\\d{3}\\)[ ]\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        return phoneTest.evaluate(with: value)
    }
    
    
}

extension Array {
    
    // extension of Array that returns nil if the element does
    // not contain an element
    func element(atIndex index: Int) -> Element? {
        if index < 0 || index >= self.count { return nil }
        return self[index]
    }
    
}
