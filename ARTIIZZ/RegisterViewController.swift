//
//  RegisterViewController.swift
//  ARTIIZZ
//
//  Created by Djason  Sylvaince on 12/17/18.
//  Copyright © 2018 Sandyna Sandaire. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RegisterViewController: UIViewController {
    @IBOutlet weak var firstnameField: UITextField!
    @IBOutlet weak var lastnameField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmpassField: UITextField!
    @IBOutlet weak var typeuser: UISegmentedControl!
    @IBOutlet weak var activityindicator: UIActivityIndicatorView!
    @IBOutlet weak var signupBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func registerfunc(_ sender: Any) {
        //viewController.dismiss(animated: true)
        //typeuser.selectedSegmentIndex
        let titletype = typeuser.titleForSegment(at: typeuser.selectedSegmentIndex)
        
        if(!(firstnameField.text?.isEmpty)! && !(lastnameField.text?.isEmpty)! && !(emailField.text?.isEmpty)! && !(usernameField.text?.isEmpty)! && !(passwordField.text?.isEmpty)! && !(confirmpassField.text?.isEmpty)!){
            
            if(passwordField.text == confirmpassField.text){
                self.activityindicator.startAnimating()
                signupBtn.isHidden = true
                let urlString = "https://congregationdesfreresromains.org/artiizz/register/register.php"
                // Alamofire 4
                let params: Parameters = ["firstname_users": firstnameField.text!, "lastname_users": lastnameField.text!, "email_users": emailField.text!, "username_users": usernameField.text!, "password_users": passwordField.text!, "type": titletype!]
                
                Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
                    // method defaults to `.get`
                    //debugPrint(response)
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        let userArray = json ["response"]
                        print(userArray)
                        if let userArray = json ["response"].array {
                            //var username: String! = userArray[0]["key"].string
                            
                            if(userArray[0]["key"].string == "SUCCESS"){
                                self.alertlogin(_title: "SUCCESS", _message: "Great!!! Account created, please enjoy app and share with friend to get new artwork at home or to offer as a gift...")
                                self.dismiss(animated: true)
                            }else{
                                print("Not exist")
                                self.alertlogin(_title: "ERROR", _message: "Try with an existing account... or join now")
                            }
                            self.activityindicator.stopAnimating()
                        }
                        self.signupBtn.isHidden = false
                    //print("JSON: \(json)")
                    case .failure(let error):
                        print(error)
                        self.signupBtn.isHidden = false
                    }
                    
                }
            }else{
                self.alertlogin(_title: "ERROR", _message: "Password different, please clean and try again...")
                self.signupBtn.isHidden = false
            }
        }else{
            alertlogin(_title: "EMPTY", _message: "Please, use your email and password to access...")
        }
        
    }
    
    
    func alertlogin(_title: String, _message: String){
        
        let alertController = UIAlertController(title: _title, message: _message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
            // handle cancel response here. Doing nothing will dismiss the view.
            self.dismiss(animated: false, completion: nil)
        }
        // add the cancel action to the alertController
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true) {
            // optional code for what happens after the alert controller has finished presenting
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
