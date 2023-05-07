//
//  StatisticViewController.swift
//  DairyApp
//
//  Created by sss on 21.11.2022.
//

import UIKit
import Charts

final class StatisticViewController: UIViewController {

    //MARK: - Property
    
    var presenter: StatisticPresenterProtocol!
   
    let segmentControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["ДЕНЬ", "НЕДЕЛЯ", "МЕСЯЦ"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentTintColor = UIColor(named: "selected2")
        segmentedControl.tintColor = .white
        return segmentedControl
    }()
    
    lazy var barChart: BarChartView = {
        let barChart = BarChartView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: view.bounds.width,
                                                  height: view.bounds.width)
        )
        barChart.backgroundColor = UIColor(named: "background")
        barChart.gridBackgroundColor = UIColor(named: "background") ?? UIColor.systemBackground
        barChart.animate(yAxisDuration: 2.0)
        barChart.pinchZoomEnabled = false
        barChart.drawBarShadowEnabled = false
        barChart.drawBordersEnabled = false
        barChart.doubleTapToZoomEnabled = false
        barChart.drawGridBackgroundEnabled = true
        barChart.leftAxis.axisMinimum = 0
        barChart.rightAxis.axisMinimum = 0
        barChart.translatesAutoresizingMaskIntoConstraints = false
        return barChart
    }()
    
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        settingsView()
        
        presenter?.loadingView(withIndex: segmentControl.selectedSegmentIndex)
    }
    

    //MARK: - Methods
    
    @objc private func segmentedControlChanged() {
        presenter?.loadingView(withIndex: segmentControl.selectedSegmentIndex)
    }
    
    private func settingsView() {
        title = "Статистика"
        view.backgroundColor = UIColor(named: "background")
        view.addSubview(segmentControl)
        view.addSubview(barChart)
        
        segmentControl.addTarget(self,
                                 action: #selector(segmentedControlChanged),
                                 for: .valueChanged)
        createConstraint()
    }
    
    private func createConstraint() {
        
        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            segmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            segmentControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            barChart.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 40),
            barChart.heightAnchor.constraint(equalToConstant: 350),
            barChart.widthAnchor.constraint(equalToConstant: 350),
            barChart.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}





//MARK: - StatisticViewProtocol
extension StatisticViewController: StatisticViewProtocol {
    
    func settingsCharts() {
        
        let emotionalEntries = presenter.emotionalIndexValues.enumerated().map {
            BarChartDataEntry(x: Double($0.offset), y: $0.element)
        }
        let physicalEntries = presenter.physicalIndexValues.enumerated().map {
            BarChartDataEntry(x: Double($0.offset), y: $0.element)
        }
        
        let emotionalSet = BarChartDataSet(entries: emotionalEntries, label: "НАСТРОЕНИЕ")
        emotionalSet.colors = [NSUIColor(cgColor: UIColor(named: "selected")?.cgColor ?? UIColor.systemIndigo.cgColor)]
        emotionalSet.valueFormatter = IntegerValueFormatter()
        emotionalSet.barBorderWidth = 0.45
        emotionalSet.valueFont = UIFont.systemFont(ofSize: 13,weight: .light)
        
        let physicalSet = BarChartDataSet(entries: physicalEntries, label: "ЗДОРОВЬЕ")
        physicalSet.valueFormatter = IntegerValueFormatter()
        physicalSet.colors = [NSUIColor(cgColor: UIColor(named: "button2")?.cgColor ?? UIColor.systemPink.cgColor)]
        physicalSet.barBorderWidth = 0.45
        physicalSet.valueFont = UIFont.systemFont(ofSize: 13,weight: .light)
        
        let groupSpace = 1.0
        let barSpace = 1.0
        let barWidth = 1.0
                
        let data = BarChartData(dataSets: [emotionalSet, physicalSet])
        data.barWidth = barWidth
        
        let groupCount = emotionalEntries.count
        let startYear = 0

        barChart.xAxis.axisMinimum = Double(startYear)
        let gg = data.groupWidth(groupSpace: groupSpace, barSpace: barSpace) * Double(groupCount)
        let groupSpace1 = 1 - groupSpace
        barChart.xAxis.axisMaximum = Double(startYear) + gg + gg * Double(groupSpace1)
        data.groupBars(fromX: Double(startYear), groupSpace: groupSpace, barSpace: barSpace)
        barChart.data = data
        barChart.notifyDataSetChanged()
    }
}
