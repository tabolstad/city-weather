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

class SearchView: UIView {

    weak var delegate: SearchViewDelegate?

    let textView = UITextView()
    let placeholderLabel = UILabel()
    let searchButton = UIButton()

    init(delegate: SearchViewDelegate?) {

        super.init(frame: .zero)

        self.delegate = delegate

        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 8
        textView.font = UIFont.systemFont(ofSize: 24)
        textView.delegate = self

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
        textView.resignFirstResponder()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewLayout() {

        textView.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false

        addSubview(textView)
        addSubview(placeholderLabel)
        addSubview(searchButton)

        let constraints = [
            textView.leadingAnchor.constraint(equalTo: leadingAnchor),
            textView.topAnchor.constraint(equalTo: topAnchor),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor),

            placeholderLabel.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: 10),
            placeholderLabel.trailingAnchor.constraint(equalTo: textView.trailingAnchor),
            placeholderLabel.topAnchor.constraint(equalTo: textView.topAnchor),
            placeholderLabel.bottomAnchor.constraint(equalTo: textView.bottomAnchor),

            searchButton.leadingAnchor.constraint(equalTo: textView.trailingAnchor, constant: 6),
            searchButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchButton.topAnchor.constraint(equalTo: topAnchor),
            searchButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            searchButton.heightAnchor.constraint(equalTo: searchButton.widthAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func showPlaceholder(_ showPlaceholder: Bool) {
        placeholderLabel.isHidden = showPlaceholder
        searchButton.isEnabled = showPlaceholder
    }
}

extension SearchView : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        showPlaceholder(!textView.text.isEmpty)
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        showPlaceholder(!textView.text.isEmpty)
        if !textView.text.isEmpty {
            delegate?.performSearch(city: textView.text)
        }
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        showPlaceholder(true)
    }
}
