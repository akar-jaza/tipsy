//
//  ViewController.swift
//  tipsy_akar
//
//  Created by Akar jaza on 3/22/23.
//

import UIKit


extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

class ViewController: UIViewController {
    
    let textColor = UIColor(rgb: 0xff06B06B) // heavy Green
    let greenBackground = UIColor(rgb: 0xffD8F9EA) // light green
    let buttonsSize = UIFont.systemFont(ofSize: 35)
    let labelsSize =  UIFont.systemFont(ofSize: 25)
    let labelsColor = UIColor.lightGray // light grey
    
    lazy var billLabel: UILabel = {
        let billLabel = UILabel()
        billLabel.text = "Enter Bill Total"
        billLabel.font = labelsSize
        billLabel.textColor = labelsColor
        billLabel.translatesAutoresizingMaskIntoConstraints = false
        return billLabel
    }()
    
    lazy var textField: UITextField = {
        var textField = UITextField()
        textField.textAlignment = .center
        textField.placeholder = "e.g. 123.56"
        textField.font = .systemFont(ofSize: 40)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = textColor
        textField.textAlignment = .center
        textField.keyboardType = .decimalPad
        textField.minimumFontSize = 17
        textField.tintColor = .darkGray
        return textField
    }()
    
    var UpStackView: UIStackView = {
        let sv = UIStackView()
        sv.backgroundColor = .white
        sv.alignment = .center
        sv.axis = .vertical
        sv.spacing = 26
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    lazy var selectTipLabel: UILabel = {
        let billLabel = UILabel()
        billLabel.text = "Select Tip"
        billLabel.font = labelsSize
        billLabel.textColor = labelsColor
        
        billLabel.translatesAutoresizingMaskIntoConstraints = false
        return billLabel
    }()
    
    var tipStackView: UIStackView = {
        var tipStackView = UIStackView()
        tipStackView.axis = .horizontal
        tipStackView.distribution = .fillProportionally
        tipStackView.translatesAutoresizingMaskIntoConstraints = false
        
        return tipStackView
        
    }()
    
    lazy var choosSplitLabel: UILabel = {
        let choosSplitLabel = UILabel()
        choosSplitLabel.text = "Choose Split"
        choosSplitLabel.font = labelsSize
        choosSplitLabel.textColor = labelsColor
        choosSplitLabel.translatesAutoresizingMaskIntoConstraints = false
        return choosSplitLabel
    }()
    
    lazy var tipButtonOne: UIButton = {
        var tipButton = UIButton(type: .system)
        tipButton.setTitle("0%", for: .normal)
        tipButton.setTitleColor(textColor, for: .normal)
        tipButton.tintColor = textColor
        tipButton.titleLabel?.font = .systemFont(ofSize: 35, weight: .regular)
        tipButton.translatesAutoresizingMaskIntoConstraints = false

        return tipButton
    }()
    
    lazy var tipButtonTwo: UIButton = {
        var tipButton = UIButton(type: .system)
        tipButton.setTitle("10%", for: .normal)
        tipButton.setTitleColor(textColor, for: .selected)
        tipButton.tintColor = textColor
        tipButton.titleLabel?.font = .systemFont(ofSize: 35, weight: .regular)
        tipButton.translatesAutoresizingMaskIntoConstraints = false
        

        return tipButton
    }()
    
    lazy var tipButtonThree: UIButton = {
        var tipButton = UIButton(type: .system)
        tipButton.setTitle("20%", for: .normal)
        tipButton.setTitleColor(textColor, for: .normal)
        tipButton.tintColor = textColor
        tipButton.titleLabel?.font = .systemFont(ofSize: 35, weight: .regular)
        tipButton.translatesAutoresizingMaskIntoConstraints = false
        tipButton.sizeToFit()
        return tipButton
    }()
    
    var buttonAndStepperStackView: UIStackView = {
        var buttonAndStepperStackView = UIStackView()
        buttonAndStepperStackView.axis = .horizontal
        buttonAndStepperStackView.spacing = 27
        buttonAndStepperStackView.translatesAutoresizingMaskIntoConstraints = false
        
        return buttonAndStepperStackView
    }()
    
    lazy var number2Label: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = buttonsSize
        label.textColor = textColor
        label.text = "2"
        
        return label
    }()
    
    lazy var stepperUI: UIStepper = {
        let stepper = UIStepper()
        stepper.value = 2
        stepper.minimumValue = 2
        stepper.maximumValue = 25
        stepper.stepValue = 1
        stepper.tintColor = UIColor(rgb: 0xff009557)
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    }()
    lazy var calculateButton: UIButton = {
        var button = UIButton(type: .system)
        button.backgroundColor = textColor
        button.setTitle("Calculate", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30, weight: .regular)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    lazy var bottomStackView: UIStackView = {
        let bsv = UIStackView()
        bsv.alignment = .center
        bsv.translatesAutoresizingMaskIntoConstraints = false
        bsv.axis = .vertical
        bsv.spacing = 25
        bsv.backgroundColor = greenBackground
        return bsv
    }()
    
    
    lazy var bottomGreenView: UIView = {
        var uiView = UIView()
        uiView.backgroundColor = greenBackground
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        self.view.addSubview(UpStackView)
        self.view.addSubview(bottomGreenView)
        self.view.addSubview(calculateButton)
        UpStackView.addArrangedSubview(billLabel)
        UpStackView.addArrangedSubview(textField)
        
        bottomGreenView.addSubview(bottomStackView)
        
        
        bottomStackView.addArrangedSubview(selectTipLabel)
        bottomStackView.addArrangedSubview(tipStackView)
        bottomStackView.addArrangedSubview(choosSplitLabel)
        bottomStackView.addArrangedSubview(buttonAndStepperStackView)
        
        tipStackView.addArrangedSubview(tipButtonOne)
        tipStackView.addArrangedSubview(tipButtonTwo)
        tipStackView.addArrangedSubview(tipButtonThree)
        
        buttonAndStepperStackView.addArrangedSubview(number2Label)
        buttonAndStepperStackView.addArrangedSubview(stepperUI)
        
        NSLayoutConstraint.activate([
            billLabel.heightAnchor.constraint(equalToConstant: 30),
            billLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            billLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50),
            billLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
            
            
            selectTipLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
            choosSplitLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
            
            tipButtonOne.heightAnchor.constraint(equalToConstant: 54),
            tipButtonOne.widthAnchor.constraint(equalToConstant: 60),
            
            tipButtonTwo.heightAnchor.constraint(equalToConstant: 54),
            
            tipButtonThree.heightAnchor.constraint(equalToConstant: 54),
            tipButtonThree.widthAnchor.constraint(equalToConstant: 75),
            
            tipButtonOne.widthAnchor.constraint(equalTo: tipButtonTwo.widthAnchor, multiplier: 0.3),
            
            stepperUI.widthAnchor.constraint(equalToConstant: 93),
            stepperUI.heightAnchor.constraint(equalToConstant: 29),
            number2Label.widthAnchor.constraint(equalToConstant: 93),
            number2Label.heightAnchor.constraint(equalToConstant: 29),
            
            calculateButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 200),
            calculateButton.heightAnchor.constraint(equalToConstant: 60),
            calculateButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            calculateButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            bottomStackView.topAnchor.constraint(equalTo: bottomGreenView.topAnchor, constant: 20),
            bottomStackView.trailingAnchor.constraint(equalTo: bottomGreenView.trailingAnchor, constant: -20),
            bottomStackView.leadingAnchor.constraint(equalTo: bottomGreenView.leadingAnchor, constant: 20),
            
            
            bottomGreenView.topAnchor.constraint(equalTo: UpStackView.bottomAnchor, constant: 35),
            bottomGreenView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            bottomGreenView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            bottomGreenView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
            
            
            
        ])
    }
    
    
}

