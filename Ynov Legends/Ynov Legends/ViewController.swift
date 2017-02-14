//
//  ViewController.swift
//  Ynov Legends
//
//  Created by iMac staff 2 on 10/01/2017.
//  Copyright © 2017 iMac staff 2. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var serverPickerView: UIPickerView!
    
    @IBOutlet weak var userNameSearchBar: UISearchBar!
    
    
    // Initialise pickerdata pour séléctionner région
    var pickerData = ["EUW", "BR", "EUNE", "JP", "KR", "LAN", "LAS", "NA", "OCE", "RU", "TR"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        serverPickerView.delegate = self
        serverPickerView.dataSource = self
        userNameSearchBar.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let rowString = pickerData[row]
        let string = NSAttributedString(string: rowString, attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
        return string
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
   
    
    func searchBarSearchButtonClicked(_ userNameSearchBar: UISearchBar){
        print("SEARCH DELEGATE")
        self.performSegue(withIdentifier: "details", sender: self)
    }
        
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        if segue.identifier == "details"{
            let destination = segue.destination as! DetailsViewController
            destination.userName = userNameSearchBar.text!
            destination.server = pickerData[serverPickerView.selectedRow(inComponent: 0)]
        }

}
}
