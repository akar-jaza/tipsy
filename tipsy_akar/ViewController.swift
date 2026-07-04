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

    private var selectedTipPercent = 10
    private var splitCount = 2

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
        tipStackView.distribution = .equalSpacing
        tipStackView.alignment = .center
        tipStackView.spacing = 24
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
    
    lazy var tipButtonOne: UIButton = makeTipButton(title: "0%")
    
    lazy var tipButtonTwo: UIButton = makeTipButton(title: "10%")
    
    lazy var tipButtonThree: UIButton = makeTipButton(title: "20%")
    
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
        wireUpActions()
        selectTipButton(tipButtonTwo)
    }

    private func wireUpActions() {
        calculateButton.addTarget(self, action: #selector(calculateTapped), for: .touchUpInside)

        tipButtonOne.addTarget(self, action: #selector(tipButtonTapped(_:)), for: .touchUpInside)
        tipButtonTwo.addTarget(self, action: #selector(tipButtonTapped(_:)), for: .touchUpInside)
        tipButtonThree.addTarget(self, action: #selector(tipButtonTapped(_:)), for: .touchUpInside)

        stepperUI.addTarget(self, action: #selector(stepperChanged), for: .valueChanged)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc private func tipButtonTapped(_ sender: UIButton) {
        selectTipButton(sender)

        switch sender {
        case tipButtonOne:
            selectedTipPercent = 0
        case tipButtonTwo:
            selectedTipPercent = 10
        case tipButtonThree:
            selectedTipPercent = 20
        default:
            break
        }
    }

    private func makeTipButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false

        var config = UIButton.Configuration.plain()
        config.title = title
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = .systemFont(ofSize: 35)
            return outgoing
        }
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 14, bottom: 8, trailing: 14)
        config.background.cornerRadius = 8
        config.baseForegroundColor = textColor
        config.background.backgroundColor = .clear
        button.configuration = config

        return button
    }

    private func selectTipButton(_ selectedButton: UIButton) {
        [tipButtonOne, tipButtonTwo, tipButtonThree].forEach { button in
            guard var config = button.configuration else { return }
            let isSelected = button === selectedButton
            config.background.backgroundColor = isSelected ? textColor : .clear
            config.baseForegroundColor = isSelected ? .white : textColor
            button.configuration = config
        }
    }

    @objc private func stepperChanged() {
        splitCount = Int(stepperUI.value)
        number2Label.text = "\(splitCount)"
    }

    @objc private func calculateTapped() {
        dismissKeyboard()

        guard let billText = textField.text, let billTotal = Double(billText), billTotal > 0 else {
            showAlert(message: "Please enter a valid bill amount.")
            return
        }

        let tipMultiplier = 1.0 + (Double(selectedTipPercent) / 100.0)
        let totalWithTip = billTotal * tipMultiplier
        let amountPerPerson = totalWithTip / Double(splitCount)

        let resultsViewController = ResultsViewController()
        resultsViewController.amountPerPerson = amountPerPerson
        resultsViewController.splitCount = splitCount
        navigationController?.pushViewController(resultsViewController, animated: true)
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Invalid Input", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
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

            tipStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
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

