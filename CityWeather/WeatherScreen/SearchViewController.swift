//
//  SearchViewController.swift
//  CityWeather
//
//  Created by Timothy Bolstad on 9/14/24.
//

import UIKit
import SwiftUI

protocol SearchViewDelegate: AnyObject {
    func performSearch(city: String)
}

struct SearchViewRepresentable: UIViewRepresentable {
    typealias UIViewType = SearchView

    private var delegate: SearchViewDelegate?

    init(delegate: SearchViewDelegate?) {
        self.delegate = delegate
    }

    func makeUIView(context: Context) -> SearchView {
        SearchView(delegate: delegate)
    }

    func updateUIView(_ uiView: SearchView, context: Context) {
    }
}

/// Text field for entering user search queries
class SearchView: UIView {

    weak var delegate: SearchViewDelegate?

    let textField = UITextField()
    let placeholderLabel = UILabel()
    let searchButton = UIButton()

    init(delegate: SearchViewDelegate?) {

        super.init(frame: .zero)

        self.delegate = delegate

        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8
        textField.font = UIFont.systemFont(ofSize: 24)
        textField.delegate = self
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        textField.leftView = paddingView
        textField.leftViewMode = .always

        placeholderLabel.textColor = UIColor.Text.placeholder
        placeholderLabel.font = UIFont.italicSystemFont(ofSize: 24)
        placeholderLabel.text = "search_placeholder_text".localized
        placeholderLabel.backgroundColor = UIColor.clear
        placeholderLabel.isUserInteractionEnabled = false

        searchButton.setTitleColor(UIColor.tintColor, for: UIControl.State.normal)
        searchButton.setTitleColor(UIColor.Text.placeholder, for: UIControl.State.disabled)
        searchButton.setImage(UIImage(systemName: "magnifyingglass")
                              , for: UIControl.State.normal)
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: UIControl.Event.touchUpInside)
        searchButton.isEnabled = false

        setupViewLayout()
    }

    @objc
    func searchButtonTapped() {
        textField.resignFirstResponder()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewLayout() {

        textField.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false

        addSubview(textField)
        addSubview(placeholderLabel)
        addSubview(searchButton)

        let constraints = [
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),

            placeholderLabel.leadingAnchor.constraint(equalTo: textField.leadingAnchor, constant: 10),
            placeholderLabel.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            placeholderLabel.topAnchor.constraint(equalTo: textField.topAnchor),
            placeholderLabel.bottomAnchor.constraint(equalTo: textField.bottomAnchor),

            searchButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 6),
            searchButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchButton.topAnchor.constraint(equalTo: topAnchor),
            searchButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            searchButton.heightAnchor.constraint(equalTo: searchButton.widthAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func showPlaceholder(_ showPlaceholder: Bool) {
        placeholderLabel.isHidden = !showPlaceholder
        searchButton.isEnabled = !showPlaceholder
    }
}

extension SearchView : UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {

        guard let newText = textField.text else {
            showPlaceholder(true)
            return
        }
        showPlaceholder(newText.isEmpty)
        if !newText.isEmpty {
            let searchText = newText.trimmingCharacters(in: .whitespacesAndNewlines)
            delegate?.performSearch(city: searchText)
        }
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        showPlaceholder(false)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
