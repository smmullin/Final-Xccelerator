//
//  SignUpViewController.swift
//  Xccelerator_New
//
//  Created by Kaylah Harden on 3/27/22.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTexrtField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //Check the signup fields and validate that the data is correct. If everything is correct, this method returns nil. Otherwise, it returns the error messages.
    func validateFields() -> String? {
        
        //Check that all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTexrtField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            
            return "Please fill in all fields"
        }
        
        //Check if the password is secure
        return nil
    }
    @IBAction func signupTapped(_ sender: Any) {
        //Validate the fields
        let error = validateFields()
        
        if error != nil{
            //Shw theres somethign wrong with the fields, show error message
            showError(error!)
        }
        
        else{
        //Create cleaned versions of the data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTexrtField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        //Create the User
            Auth.auth().createUser(withEmail: email, password: password) {(result, err) in
                //Check for errors
                if err != nil{
                    //There was an error creating the user
                    self.showError("Error creating user")
                }
                else{
                    //User was created successfully, now sore the first name and last name
                    let db = Firestore.firestore()
                    
                    db.collection("Users").addDocument(data: ["firstname":firstName, "lastname":lastName, "uid":result!.user.uid]){(error) in
                        if error != nil{
                            //Show error message
                            self.showError("Error saving user data...")
                        }
                        
                    }
                    //Transition to the homescreen
                    self.transitionToHome()
                }
            }
        }
    }
    func showError(_ message:String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    func transitionToHome(){
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController)
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    

}
