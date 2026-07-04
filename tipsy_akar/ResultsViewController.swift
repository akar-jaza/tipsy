//
//  ResultsViewController.swift
//  tipsy_akar
//
//  Created by Akar jaza on 3/22/23.
//

import UIKit

class ResultsViewController: UIViewController {

    var amountPerPerson: Double = 0
    var splitCount: Int = 2

    private let textColor = UIColor(rgb: 0xff06B06B)
    private let greenBackground = UIColor(rgb: 0xffD8F9EA)

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Total per person"
        label.font = .systemFont(ofSize: 25)
        label.textColor = .lightGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 48, weight: .bold)
        label.textColor = textColor
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var splitLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = .lightGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var recalculateButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = textColor
        button.setTitle("Recalculate", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(recalculateTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = greenBackground
        setupUI()
        updateLabels()
    }

    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(amountLabel)
        view.addSubview(splitLabel)
        view.addSubview(recalculateButton)

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: amountLabel.topAnchor, constant: -16),

            amountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            amountLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),

            splitLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            splitLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 16),

            recalculateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recalculateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            recalculateButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 200),
            recalculateButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    private func updateLabels() {
        amountLabel.text = String(format: "$%.2f", amountPerPerson)
        splitLabel.text = "Split between \(splitCount) people"
    }

    @objc private func recalculateTapped() {
        navigationController?.popViewController(animated: true)
    }
}
