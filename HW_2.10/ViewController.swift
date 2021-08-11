//
//  ViewController.swift
//  HW_2.10
//
//  Created by emmisar on 08.08.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var valueTextField: UITextField!
    @IBOutlet var typeButtons: [UIButton]!
    @IBOutlet var resultLabel: UILabel!
    
    var value = "random"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultLabel.text = """
            Hey! This application is for fun.
            Press the button and find out an interesting fact about a number or date!
            Good luck!
            """
    }
    
    @IBAction func clickTypeButton(_ sender: UIButton) {

        let value = checkTextFieldValue()
        
        guard value != "" else {return}

        let type = String(sender.title(for: .normal) ?? "trivia")
        
        let url = "http://numbersapi.com/\(value)/\(type)?json"
        NetworkManager.shared.fetchData(from: url) { result in
            switch result {
            case .success(let numberFact):
                self.resultLabel.text = numberFact.text
            case .failure(let error):
                print(error)
            }
        }
        
}
    
    func checkTextFieldValue() -> String {
        
        if let result = valueTextField.text {
            if let _ = Int(result) {
                return result}
            else {
                if valueTextField.text == "" {
                    return "random"}
                else {
                    resultLabel.text = "Sorry! Please enter the correct number"
                }
                }
        }
        
        return ""
    }
}
