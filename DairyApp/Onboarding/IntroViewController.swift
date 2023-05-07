//
//  IntroViewController.swift
//  DairyApp
//
//  Created by sss on 06.05.2023.
//

import UIKit

final class IntroViewController: UIViewController {
    
    //MARK: - Property
    
    var completion: ((Bool) -> Void)?
    
    private var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "button1")
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Пропустить", for: .normal)
        button.layer.cornerRadius = 18
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let scrollView = UIScrollView()
    let pageControll = UIPageControl()
    
    let content = ["First", "Second", "Third"]

    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "smallBackground")
        button.addTarget(self, action: #selector(presentationWasViewed), for: .touchUpInside)
        
        configurationScrollView()
        view.addSubview(pageControll)
        view.addSubview(button)
        pageControll.numberOfPages = content.count
        pageControll.pageIndicatorTintColor = UIColor(named: "button2")
        pageControll.currentPageIndicatorTintColor = UIColor(named: "button1")
        
        
        pageControll.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pageControll.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -190),
            pageControll.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            button.topAnchor.constraint(equalTo: pageControll.bottomAnchor, constant: 50),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
   
    
    //MARK: - Method
    
    @objc private func presentationWasViewed() {
        UserDefaults.standard.set(true, forKey: "presentationWasViewed")
        
        DispatchQueue.main.async {
            self.dismiss(animated: true) {
                self.completion?(true)
            }
        }
    }
    
    private func configurationScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.backgroundColor = UIColor(named: "backdround")
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        scrollView.contentSize = CGSize(width: view.bounds.width * 3, height: view.bounds.height)
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        
        addLabel(title: content[0], position: 0)
        addLabel(title: content[1], position: 1)
        addLabel(title: content[2], position: 2)
        
    }
    
    private func addLabel(title: String, position: CGFloat) {
        let label = UILabel()
        label.text = title
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        scrollView.addSubview(label)
        let width = view.bounds.width
        label.frame = CGRect(x: width * position, y: view.bounds.height / 3, width: width, height: 200)
        
    }
}

//MARK: - UIScrollViewDelegate

extension IntroViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControll.currentPage = Int(scrollView.contentOffset.x / view.bounds.width)
        
        
    }
}
