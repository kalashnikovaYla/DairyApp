//
//  SearchNoteViewController.swift
//  DairyApp
//
//  Created by sss on 02.05.2023.
//

import UIKit

final class SearchNoteViewController: UIViewController {
   
    var presenter: DairyPresenterProtocol
    
    private var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Показать все записи", for: .normal)
        button.setTitleColor(UIColor(named: "selected"), for: .normal)
        return button
    }()
    
    private var calendarView: UICalendarView!
    
    
    //MARK: - Init
    
    init(presenter: DairyPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createViews()
        view.backgroundColor = UIColor(named: "background")
        button.addTarget(self, action: #selector(showAllNoteButtonTapped), for: .touchUpInside)
    }
    

    private func createViews() {
        calendarView = UICalendarView()
        calendarView.backgroundColor = UIColor(named: "smallBackground")
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.calendar = .current
        calendarView.locale = .current
        calendarView.fontDesign = .rounded
        calendarView.layer.cornerRadius = 12
        calendarView.tintColor = UIColor(named: "selected")
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = dateSelection
        view.addSubview(calendarView)
        
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            calendarView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 10),
            calendarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            calendarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            calendarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
   
    @objc private func showAllNoteButtonTapped() {
        presenter.showAllNoteButtonIsapped()
        dismiss(animated: true)
    }

}

//MARK: - UICalendarSelectionSingleDateDelegate

extension SearchNoteViewController: UICalendarSelectionSingleDateDelegate {
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        let date = dateComponents?.date
        presenter.dateIsSelected(date: date)
        dismiss(animated: true)
    }
}
