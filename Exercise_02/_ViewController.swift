//
//  _ViewController.swift
//  Exercise_02
//
//  Created by 白石裕幸 on 2021/08/18.
//

import UIKit

class _ViewController: UIViewController, UITextFieldDelegate {
    
    private let screenSize_height = UIScreen.main.bounds.height
    private let screenSize_width = UIScreen.main.bounds.width
    private let operators:[Operator] = [.addition,.subtraction,.multiplication,.division]
    
    
    private let textField:UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .lightGray
        textField.keyboardType = .numberPad
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let textField2:UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .lightGray
        textField.keyboardType = .numberPad
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let operatorSegmentedControl:UISegmentedControl = {
        let segmentParams = ["+","-","x","÷"]
        let segmentedControl = UISegmentedControl(items: segmentParams)
        segmentedControl.backgroundColor = .lightGray
        segmentedControl.selectedSegmentTintColor = .darkGray
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        return segmentedControl
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        label.textColor = .darkGray
        label.textAlignment = .left
        return label
    }()
    
    private let calculationButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setTitle("計算", for: .normal)
        button.titleLabel?.textColor = .darkGray
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
        // Do any additional setup after loading the view.
    }
    
    
    @objc private func tapAction(){
        
        let operatorsIndex = operators[operatorSegmentedControl.selectedSegmentIndex]
        
        switch operatorsIndex {
        case .addition:
            resultLabel.text = operatorsIndex.calculate(val01: Double(textField.text!) ?? 0, val02: Double(textField2.text!) ?? 0)
        case .division:
            resultLabel.text = operatorsIndex.calculate(val01: Double(textField.text!) ?? 0, val02: Double(textField2.text!) ?? 0)
        case .multiplication:
            resultLabel.text =  operatorsIndex.calculate(val01: Double(textField.text!) ?? 0, val02: Double(textField2.text!) ?? 0)
        case.subtraction:
            resultLabel.text =  operatorsIndex.calculate(val01: Double(textField.text!) ?? 0, val02: Double(textField2.text!) ?? 0)
        }
        view.endEditing(true)
    }
    
    private func setUpLayout() {
        textField.delegate = self
        textField2.delegate = self
        view.backgroundColor = .white
        // 初回表示時+を選択
        operatorSegmentedControl.selectedSegmentIndex = 0
        
        let stackView = UIStackView(arrangedSubviews: [textField,textField2,operatorSegmentedControl,calculationButton,resultLabel])
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        view.addSubview(stackView)
        view.addSubview(textField)
        view.addSubview(textField2)
        view.addSubview(operatorSegmentedControl)
        view.addSubview(calculationButton)
        view.addSubview(resultLabel)
        
        [
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ].forEach { $0.isActive = true }
        
        stackView.anchor(_leftAnchor: view.leftAnchor, _rightAnchor: view.rightAnchor, _centerYAnchor: view.centerYAnchor)
        
        textField.anchor(_topAnchor: stackView.topAnchor, _leftAnchor: view.leftAnchor, _rightAnchor: view.rightAnchor, _height: 50, _topPadding: 100, _leftPadding: 40, _rightPadding: 40)
        
        textField2.anchor(_topAnchor: textField.bottomAnchor, _leftAnchor: view.leftAnchor, _rightAnchor: view.rightAnchor, _height: 50, _topPadding: 20, _leftPadding: 40, _rightPadding: 40)
        
        operatorSegmentedControl.anchor(_topAnchor: textField2.bottomAnchor, _leftAnchor: view.leftAnchor, _rightAnchor: view.rightAnchor, _height: 50, _topPadding: 20, _leftPadding: 40, _rightPadding: 40)
        
        calculationButton.anchor(_topAnchor: operatorSegmentedControl.bottomAnchor, _leftAnchor: view.leftAnchor, _rightAnchor: view.rightAnchor, _height: 50, _topPadding: 15, _leftPadding: 50, _rightPadding: 50)
        
        resultLabel.anchor(_topAnchor: calculationButton.bottomAnchor, _leftAnchor: view.leftAnchor, _rightAnchor: view.rightAnchor, _height: 50, _topPadding: 20, _leftPadding: 25, _rightPadding: 25)
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension UIView {
    
    func anchor(_topAnchor: NSLayoutYAxisAnchor? = nil,
                _leftAnchor: NSLayoutXAxisAnchor? = nil,
                _bottomAnchor: NSLayoutYAxisAnchor? = nil,
                _rightAnchor: NSLayoutXAxisAnchor? = nil,
                _centerYAnchor: NSLayoutYAxisAnchor? = nil,
                _centerXAnchor: NSLayoutXAxisAnchor? = nil,
                _width: CGFloat? = nil,
                _height: CGFloat? = nil,
                _topPadding: CGFloat = 0,
                _bottomPadding: CGFloat = 0,
                _leftPadding: CGFloat = 0,
                _rightPadding: CGFloat = 0){
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = _topAnchor {
            topAnchor.constraint(equalTo: top, constant: _topPadding).isActive = true
        }
        if let left = _leftAnchor {
            leftAnchor.constraint(equalTo: left, constant: _leftPadding).isActive = true
        }
        if let bottom = _bottomAnchor {
            bottomAnchor.constraint(equalTo: bottom, constant: -_bottomPadding).isActive = true
        }
        if let right = _rightAnchor {
            rightAnchor.constraint(equalTo: right, constant: -_rightPadding).isActive = true
        }
        if let centerY = _centerYAnchor {
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
        if let centerX = _centerXAnchor {
            centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        if let width = _width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let heigth = _height {
            heightAnchor.constraint(equalToConstant: heigth).isActive = true
        }
    }
}


