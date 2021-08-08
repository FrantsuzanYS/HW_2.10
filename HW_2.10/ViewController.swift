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

        if let result = valueTextField.text {
            if let _ = Int(result) {
                value = result}
            else {
                if valueTextField.text == "" {
                    value = "random"}
                else {
                    resultLabel.text = "Sorry! Please enter the correct number"
                    return
                }
                }
        }

        let type = String(sender.title(for: .normal) ?? "trivia")
        
        guard let url = URL(string: "http://numbersapi.com/\(value)/\(type)?json") else {return}
        
        URLSession.shared.dataTask(with: url) {data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "Not results")
                return
            }
            
            do {
                let numberFact = try JSONDecoder().decode(NumberFact.self, from: data)
                
                DispatchQueue.main.async {
                    self.resultLabel.text = numberFact.text
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
         }.resume()

}
}
