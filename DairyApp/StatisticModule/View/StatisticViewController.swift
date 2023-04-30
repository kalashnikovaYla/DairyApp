//
//  StatisticViewController.swift
//  DairyApp
//
//  Created by sss on 21.11.2022.
//

import UIKit
import Charts

class StatisticViewController: UIViewController {

    var presenter: StatisticPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Статистика"
        view.backgroundColor = UIColor(named: "background")
        
        createChart()
    }
    

    func createChart() {
        //Create bar chart
        let barChart = BarChartView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.width))
        
        //Configure the axis
        let xAxis = barChart.xAxis
        let rightAxis = barChart.rightAxis
        
        //Configure legend
        let legend = barChart.legend
        
        //Supply data
        var entries = [BarChartDataEntry]()
        for x in 0 ..< 7 {
            entries.append(BarChartDataEntry(x: Double(x), y: Double.random(in: 0...20)))
        }
        let set = BarChartDataSet(entries: entries, label: "Настроение")
        set.colors = [
            NSUIColor(cgColor: UIColor(named: "selected")?.cgColor ?? UIColor.systemIndigo.cgColor)
        ]
        let data = BarChartData(dataSet: set)
        
        barChart.data = data
        
        view.addSubview(barChart)
        barChart.center = view.center
    }

}


extension StatisticViewController: StatisticViewProtocol {
    
}
