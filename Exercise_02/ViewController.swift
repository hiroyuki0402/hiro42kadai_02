//
//  ViewController.swift
//  Exercise_02
//
//  Created by 白石裕幸 on 2021/08/11.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet private var textField01: UITextField!
    @IBOutlet private var textField02: UITextField!
    @IBOutlet private var operatorSegmentedControl: UISegmentedControl!
    @IBOutlet private var resultLabel: UILabel!
    private let operators:[Operator] = [.addition,.subtraction,.multiplication,.division]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 初回表示時+を選択
        operatorSegmentedControl.selectedSegmentIndex = 0
        // Do any additional setup after loading the view.
    }
    
    // MARK: METHODs
    
    @IBAction func calculationButton(_ sender: Any) {
        
        let operatorsIndex = operators[operatorSegmentedControl.selectedSegmentIndex]
        
        switch operatorsIndex {
        case .addition:
            resultLabel.text = operatorsIndex.calculate(val01: Int(textField01.text!) ?? 0, val02: Int(textField02.text!) ?? 0)
        case .division:
            resultLabel.text = operatorsIndex.calculate(val01: Int(textField01.text!) ?? 0, val02: Int(textField02.text!) ?? 0)
        case .multiplication:
            resultLabel.text =  operatorsIndex.calculate(val01: Int(textField01.text!) ?? 0, val02: Int(textField02.text!) ?? 0)
        case.subtraction:
            resultLabel.text =  operatorsIndex.calculate(val01: Int(textField01.text!) ?? 0, val02: Int(textField02.text!) ?? 0)
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
// MARK: ENUM

enum Operator: Int {
    case addition,
         subtraction,
         multiplication,
         division
    
    func calculate(val01:Int,val02:Int)  -> String {
        
        switch self {
        case .addition:
            return (val01 + val02).description
        case .subtraction:
            return (val01 - val02).description
        case .multiplication:
            return (val01 * val02).description
        case .division:
            if val02 == 0 {
                return "割る数には0以外を入力してください"
            }else{
                return (val01 / val02).description
            }
        }
    }
}
