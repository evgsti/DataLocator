//
//  ViewController.swift
//  DataLocator
//
//  Created by Евгений on 31.08.2024.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - Private Properties
    private let url = URL(string: "https://ipapi.co/json/")!
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCourse()
    }
    
    // MARK: - Private Methods
    private func showAlert(withTitle title: String, andMessage message: String) {
        DispatchQueue.main.async { [unowned self] in
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            
            alert.addAction(okAction)
            present(alert, animated: true)
            
            /*
             Если в основной поток передать только present(alert, animated: true),
             то появляется предупреждение Unsupported enumeration of UIWindowScene windows on non-main thread.
             Решения этой проблемы не нашел.
             */
            
        }
    }
}

// MARK: - Networking
extension ViewController {
    private func fetchCourse() {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self else { return }
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let location = try JSONDecoder().decode(Location.self, from: data)
                print(location)
                showAlert(withTitle: "Успех!", andMessage: "Данные получены")
            } catch {
                print(error.localizedDescription)
                print(error)
                showAlert(withTitle: "Ошибка!", andMessage: "Данные не получены")
            }
        }.resume()
    }
}
