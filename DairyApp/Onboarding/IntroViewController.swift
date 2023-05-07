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
        button.backgroundColor = UIColor(named: "onboardingButton")
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Пропустить", for: .normal)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let scrollView = UIScrollView()
    let pageControll = UIPageControl()
    
    let content = ["Привет! Рады увидеть тебя в приложении Dairy! 🥳",
                   "Ты можешь записывать все, что происходило с тобой за день 📑",
                   "Ставить теги, прикреплять фото 🎆",
                   "И тогда дневник подготовит для тебя статистику твоего самочувтвия 🫶"]

    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configurationScrollView()
        configurationSubView()
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
        scrollView.backgroundColor = UIColor(named: "ondoardBackground")
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        scrollView.contentSize = CGSize(width: view.bounds.width * 4, height: view.bounds.height)
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        
        addLabel(title: content[0], position: 0)
        addLabel(title: content[1], position: 1)
        addLabel(title: content[2], position: 2)
        addLabel(title: content[3], position: 3)
        
    }
    
    private func addLabel(title: String, position: CGFloat) {
        let label = UILabel()
        label.text = title
        label.textColor = UIColor(named: "textColor")
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 23, weight: .heavy)
        scrollView.addSubview(label)
        let width = view.bounds.width
        label.frame = CGRect(x: width * position, y: view.bounds.height / 3, width: width, height: 200)
        
    }
    
    private func configurationSubView() {
        
        view.backgroundColor = UIColor(named: "ondoardBackground")
        button.addTarget(self, action: #selector(presentationWasViewed), for: .touchUpInside)
        
        view.addSubview(pageControll)
        view.addSubview(button)
        
        pageControll.numberOfPages = content.count
        pageControll.pageIndicatorTintColor = .white
        pageControll.currentPageIndicatorTintColor = UIColor(named: "onboardingButton")
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
}

//MARK: - UIScrollViewDelegate

extension IntroViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControll.currentPage = Int(scrollView.contentOffset.x / view.bounds.width)
    }
}
