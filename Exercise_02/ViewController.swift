//
//  ViewController.swift
//  Exercise_02
//
//  Created by 白石裕幸 on 2021/08/11.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    
    
    
    private var _calculationSymbol = Int()
    
    @IBOutlet var textField01: UITextField!
    @IBOutlet var textField02: UITextField!
    @IBOutlet var calculationSymbolObj: UISegmentedControl!
    @IBOutlet var resultLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate()
        layoutSetUp()
        
        //初回表示時+を選択
        calculationSymbolObj.selectedSegmentIndex = 0
        // Do any additional setup after loading the view.
    }
    
    
    //MARK:METHODs
    
    @IBAction func calculationButton(_ sender: Any) {
        
        let val01 = Int(textField01.text!) ?? 0
        let val02 = Int(textField02.text!) ?? 0
        
        
        switch _calculationSymbol{
        case 0:
            resultLabel.text = String(val01 + val02)
        case 1:
            resultLabel.text = String(val01 - val02)
        case 2:
            resultLabel.text = String(val01 * val02)
        case 3:
            if val02 == 0{
                resultLabel.text = "割る数には0以外を入力してください"
                break
            }else{
                resultLabel.text = String(val01 / val02)
            }
            
        default:
            break
        }
    }
    
    @IBAction func calculationSymbol(_ sender: UISegmentedControl) {
        
        
        switch sender.selectedSegmentIndex{
        case 0:
            _calculationSymbol = 0
        case 1:
            _calculationSymbol = 1
        case 2:
            _calculationSymbol = 2
        case 3:
            _calculationSymbol = 3
        default:
            break
            
        }
    }
    private func delegate(){
        textField01.delegate = self
        textField02.delegate = self
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func layoutSetUp(){
        textField01.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        textField02.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        
        calculationSymbolObj.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    
}
