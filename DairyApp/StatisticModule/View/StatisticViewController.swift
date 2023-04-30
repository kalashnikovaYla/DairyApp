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
    let coreDataManager = CoreDataManager()
    
    let segmentControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["День", "Неделя", "Месяц"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    var emotionalIndexValues = [Double]()
    var physicalIndexValues = [Double]()
    
    var barChart: BarChartView!
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Статистика"
        view.backgroundColor = UIColor(named: "background")
        view.addSubview(segmentControl)
        segmentControl.addTarget(self, action: #selector(segmentedControlChanged), for: .valueChanged)
        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            segmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        createChart()
    }
    

    //MARK: - Methods
    
    @objc func segmentedControlChanged() {
        loadChartDataForCurrentSegment()
    }
    
    
    func createChart() {
        //Create bar chart
        barChart = BarChartView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.width))
        barChart.backgroundColor = UIColor(named: "smallBackground")
        barChart.gridBackgroundColor = UIColor(named: "smallBackground") ?? UIColor.systemBackground
        
        
        //Configure the axis
        let xAxis = barChart.xAxis
        let rightAxis = barChart.rightAxis
        
        //Configure legend
        let legend = barChart.legend
        
        //Supply data
        loadChartDataForCurrentSegment()
        
        xAxis.labelPosition = .bottom
        xAxis.labelFont = UIFont.systemFont(ofSize: 10)
        xAxis.drawGridLinesEnabled = false
        xAxis.granularity = 0.5
        xAxis.centerAxisLabelsEnabled = true
        
          
        //Configure Right Axis
        rightAxis.enabled = false
          
        //Configure Legend
        legend.enabled = true
        legend.horizontalAlignment = .center
        legend.verticalAlignment = .top
        legend.orientation = .horizontal
        legend.drawInside = false

    
        view.addSubview(barChart)
        barChart.center = view.center
        
        barChart.animate(yAxisDuration: 2.0)
        barChart.pinchZoomEnabled = false
        barChart.drawBarShadowEnabled = false
        barChart.drawBordersEnabled = false
        barChart.doubleTapToZoomEnabled = false
        barChart.drawGridBackgroundEnabled = true
    }

    func loadChartDataForCurrentSegment() {
    
        switch segmentControl.selectedSegmentIndex {
        case 0:
            coreDataManager.searchTodayNote { [weak self] result in
                guard let self = self else {return}
                switch result {
                case .success(let notes):
                    //self.settingsCurrentData(notes: notes)
                    
                    self.emotionalIndexValues = notes.compactMap {
                        Double($0.emotionalIndex)
                    }
                    self.physicalIndexValues = notes.compactMap {
                        Double($0.physicalIndex)
                    }
                    self.settingsCharts(emotionalIndexValues: emotionalIndexValues, physicalIndexValues: physicalIndexValues)
                case .failure(let error):
                    print(error)
                }
            }
            
        case 1:
            coreDataManager.searchWeekdayNote { [weak self] result in
                guard let self = self else {return}
                switch result {
                case .success(let notes):
                    let averageArrays = self.averageValuesByDay(notes: notes)
                    self.emotionalIndexValues = averageArrays.emotionalIndex.map{ Double($0)}
                    self.physicalIndexValues = averageArrays.physicalIndex.map{ Double($0)}
                    
                    self.settingsCharts(emotionalIndexValues: emotionalIndexValues, physicalIndexValues: physicalIndexValues)
                case .failure(let error):
                    print(error)
                }
            }
        case 2:
            coreDataManager.searchMonthNote { [weak self] result in
                guard let self = self else {return}
                switch result {
                case .success(let notes):
                    
                    let averageArrays = self.averageValuesByDay(notes: notes)
                    self.emotionalIndexValues = averageArrays.emotionalIndex.map{ Double($0)}
                    self.physicalIndexValues = averageArrays.physicalIndex.map{ Double($0)}
                    
                    self.settingsCharts(emotionalIndexValues: emotionalIndexValues, physicalIndexValues: physicalIndexValues)
                    
                case .failure(let error):
                    print(error)
                }
            }
        default:
            break
        }
    }
    
    
    func settingsCharts(emotionalIndexValues: [Double], physicalIndexValues: [Double]) {
        
        let emotionalEntries = emotionalIndexValues.enumerated().map {
            BarChartDataEntry(x: Double($0.offset), y: $0.element)
        }
        let physicalEntries = physicalIndexValues.enumerated().map {
            BarChartDataEntry(x: Double($0.offset), y: $0.element)
        }
        let emotionalSet = BarChartDataSet(entries: emotionalEntries, label: "Эмоциональное состояние")
        emotionalSet.colors = [NSUIColor(cgColor: UIColor(named: "selected")?.cgColor ?? UIColor.systemIndigo.cgColor)]
        emotionalSet.barBorderWidth = 0.45
        let physicalSet = BarChartDataSet(entries: physicalEntries, label: "Физическое состояние")
        physicalSet.colors = [NSUIColor(cgColor: UIColor(named: "button2")?.cgColor ?? UIColor.systemPink.cgColor)]
        physicalSet.barBorderWidth = 0.45
        
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
    
    func averageValuesByDay(notes: [Note]) -> (emotionalIndex: [Float], physicalIndex: [Float]) {
        let calendar = Calendar.current
        
        let groups = Dictionary(grouping: notes) { note -> Date in
            
            let components = calendar.dateComponents([.year, .month, .day], from: note.date ?? Date())
            return calendar.date(from: components)!
        }
        let emotionalIndex = groups.mapValues { notes -> Float in
            let values = notes.map { $0.emotionalIndex }
            return values.reduce(0, +) / Float(values.count)
        }.values.sorted()
        let physicalIndex = groups.mapValues { notes -> Float in
            let values = notes.map { $0.physicalIndex }
            return values.reduce(0, +) / Float(values.count)
        }.values.sorted()
        return (emotionalIndex, physicalIndex)
    }

}

//MARK: - StatisticViewProtocol
extension StatisticViewController: StatisticViewProtocol {
    
}
