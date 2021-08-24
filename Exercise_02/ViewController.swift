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
    private let operators: [Operator] = [.addition, .subtraction, .multiplication, .division]

    override func viewDidLoad() {
        super.viewDidLoad()
        // 初回表示時+を選択
        operatorSegmentedControl.selectedSegmentIndex = 0
    }

    // MARK: METHODs

    @IBAction private func calculationButton(_ sender: Any) {
        let value1 = Double(textField01.text ?? "0") ?? 0
        let value2 = Double(textField02.text ?? "0") ?? 0
        let selectOperators = operators[operatorSegmentedControl.selectedSegmentIndex]
        resultLabel.text =  selectOperators.calculate(val01: value1, val02: value2)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
// MARK: ENUM

public enum Operator: Int {
    case addition,
         subtraction,
         multiplication,
         division

    func calculate(val01: Double, val02: Double) -> String {
        switch self {
        case .addition:
            return String(val01 + val02)

        case .subtraction:

            return String(val01 - val02)

        case .multiplication:

            return String(val01 * val02)

        case .division:

            if val02 == 0 {
                return "割る数には0以外を入力してください"
            } else {
                return String(val01 / val02)
            }
        }
    }
}
