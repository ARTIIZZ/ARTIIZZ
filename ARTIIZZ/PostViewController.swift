//
//  PostViewController.swift
//  ARTIIZZ
//
//  Created by Djason  Sylvaince on 12/18/18.
//  Copyright © 2018 Sandyna Sandaire. All rights reserved.
//

import UIKit

class PostViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var categorie: UIPickerView!
    var categorieData: [String] = [String]()
    @IBOutlet weak var material: UIPickerView!
    var materialData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        categorieData = ["Painting", "Drawing", "Photography", "Sculpture", "Others"]
        
        materialData = ["Oil", "Acrylic", "Pencil", "Charcoal", "Watercolor", "Pastel", "Pen", "Mixed"]
        
        self.categorie.delegate = self
        self.categorie.dataSource = self
        
        self.material.delegate = self
        self.material.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // The number of columns in your Picker View
    // component just means column.
    

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categorieData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return categorieData[row]
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
