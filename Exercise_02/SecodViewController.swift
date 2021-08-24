//
//  _ViewController.swift
//  Exercise_02
//
//  Created by 白石裕幸 on 2021/08/18.
//

import UIKit

class SecodViewController: UIViewController, UITextFieldDelegate {
    private let screenSizeHeight = UIScreen.main.bounds.height
    private let screenSizeWidth = UIScreen.main.bounds.width
    private let operators: [Operator] = [.addition, .subtraction, .multiplication, .division]

    private let textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .lightGray
        textField.keyboardType = .numberPad
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let textField2: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .lightGray
        textField.keyboardType = .numberPad
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let operatorSegmentedControl: UISegmentedControl = {
        let segmentParams = ["+", "-", "x", "÷"]
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

    @objc
    func tapAction() {
        let value1 = Double(textField.text ?? "0") ?? 0
        let value2 = Double(textField2.text ?? "0") ?? 0
        let selectOperators = operators[operatorSegmentedControl.selectedSegmentIndex]
        resultLabel.text =  selectOperators.calculate(val01: value1, val02: value2)
        view.endEditing(true)
    }

    private func setUpLayout() {
        textField.delegate = self
        textField2.delegate = self
        view.backgroundColor = .white
        // 初回表示時+を選択
        operatorSegmentedControl.selectedSegmentIndex = 0

        let stackView = UIStackView(arrangedSubviews:
                                        [textField, textField2, operatorSegmentedControl, calculationButton,
                                         resultLabel])

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

        stackView.anchor(left: view.leftAnchor, right: view.rightAnchor,
                         centerY: view.centerYAnchor)

        textField.anchor(top: stackView.topAnchor,
                         left: view.leftAnchor, right: view.rightAnchor, height: 50, topPadding: 100,
                         leftPadding: 40, rightPadding: 40)

        textField2.anchor(top: textField.bottomAnchor,
                          left: view.leftAnchor, right: view.rightAnchor, height: 50, topPadding: 20,
                          leftPadding: 40, rightPadding: 40)

        operatorSegmentedControl.anchor(top: textField2.bottomAnchor,
                                        left: view.leftAnchor, right: view.rightAnchor, height: 50, topPadding: 20,
                                        leftPadding: 40, rightPadding: 40)

        calculationButton.anchor(top: operatorSegmentedControl.bottomAnchor,
                                 left: view.leftAnchor, right: view.rightAnchor, height: 50, topPadding: 15,
                                 leftPadding: 50, rightPadding: 50)

        resultLabel.anchor(top: calculationButton.bottomAnchor,
                           left: view.leftAnchor, right: view.rightAnchor, height: 50, topPadding: 20,
                           leftPadding: 25, rightPadding: 25)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension UIView {
    func anchor( top: NSLayoutYAxisAnchor? = nil,
                 left: NSLayoutXAxisAnchor? = nil,
                 bottom: NSLayoutYAxisAnchor? = nil,
                 right: NSLayoutXAxisAnchor? = nil,
                 centerY: NSLayoutYAxisAnchor? = nil,
                 centerX: NSLayoutXAxisAnchor? = nil,
                 width: CGFloat? = nil, height: CGFloat? = nil,
                 topPadding: CGFloat = 0, bottomPadding: CGFloat = 0,
                 leftPadding: CGFloat = 0, rightPadding: CGFloat = 0
    ) {
        self.translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            topAnchor.constraint(equalTo: top, constant: topPadding).isActive = true
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: leftPadding).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -bottomPadding).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -rightPadding).isActive = true
        }
        if let centerY = centerY {
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
        if let centerX = centerX {
            centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
