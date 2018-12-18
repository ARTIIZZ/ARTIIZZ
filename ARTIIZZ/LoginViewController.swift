//
//  LoginViewController.swift
//  ARTIIZZ
//
//  Created by Djason  Sylvaince on 12/16/18.
//  Copyright © 2018 Sandyna Sandaire. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.activityIndicator.stopAnimating()
    }
    
    @IBAction func loginfunc(_ sender: Any) {
        if(!(emailField.text?.isEmpty)! && !(passwordField.text?.isEmpty)!){
            self.activityIndicator.startAnimating()
            
            let urlString = "https://congregationdesfreresromains.org/artiizz/login/login.php"
            // Alamofire 4
            loginBtn.isHidden = true
            let params: Parameters = ["username_users": emailField.text!, "password_users": passwordField.text!]
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
                                print(userArray[0]["valid"].int!)
                                if(userArray[0]["valid"].int! == 1){
                                    print("good")
                                    //Access UserDefaults
                                    let defaults = UserDefaults.standard
                                    // Set a String value for some key.
                                    defaults.set(userArray[0]["id"].int!, forKey: "id")
                                    defaults.set(userArray[0]["lastname"].string, forKey: "lastname")
                                    defaults.set(userArray[0]["firstname"].string, forKey: "firstname")
                                    defaults.set(userArray[0]["email"].string, forKey: "email")
                                    defaults.set(userArray[0]["username"].string, forKey: "username")
                                    defaults.set(userArray[0]["created"].string, forKey: "created")
                                    defaults.set(userArray[0]["updated"].string, forKey: "updated")
                                    defaults.set(userArray[0]["valid"].int!, forKey: "valid")
                                    defaults.set(userArray[0]["profil"].string, forKey: "profil")
                                    
                                    defaults.set(userArray[0]["value"].string, forKey: "value")
                                    defaults.set(userArray[0]["type"].int!, forKey: "type")
                                    
                                    self.performSegue(withIdentifier: "vcLoginSuccess", sender: nil)
                                    /*
                                    let mainStoryboard = UIStoryboard(name: "Storyboard", bundle: Bundle.main)
                                    let vc : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "vcTabbar") as UIViewController
                                    self.present(vc, animated: true, completion: nil)
                                    */
                                }else{
                                    self.alertlogin(_title: "ERROR", _message: "Blocked account, please contact us for more information...")
                                }
                                
                            }else{
                               print("Not exist")
                                self.alertlogin(_title: "ERROR", _message: "Try with an existing account... or join now")
                            }
                            self.activityIndicator.stopAnimating()
                            
                        }
                        self.loginBtn.isHidden = false
                        //print("JSON: \(json)")
                    case .failure(let error):
                        print(error)
                        self.loginBtn.isHidden = false
                }
                
            }
            
        }else{
            alertlogin(_title: "EMPTY", _message: "Please, use your email and password to access...")
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
