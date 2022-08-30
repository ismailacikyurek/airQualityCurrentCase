//
//  DetailsViewController.swift
//  AirQualityCurrent
//
//  Created by İSMAİL AÇIKYÜREK on 21.08.2022.
//

import UIKit 
import CoreData

class DetailsViewController: UIViewController {
    // MARK: Properties
    @IBOutlet weak var tableVieww: UITableView!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblCityName: UILabel!
    @IBOutlet weak var lblCO: UILabel!
    @IBOutlet weak var lblNO2: UILabel!
    @IBOutlet weak var lblSO2: UILabel!
    @IBOutlet weak var lblPM10: UILabel!
    @IBOutlet weak var lblPM25: UILabel!
    @IBOutlet weak var lblOzone: UILabel!
    @IBOutlet weak var lblpreviosCity: UILabel!
    var incomingCity : String?
    var viewModel : DetailsViewModelProtocol = DetailsViewModel()
    let time = TimeAndDate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        time.dateTime()
    }
    
    func setupUI () {
        viewModel.setUpDelegate(self)
        viewModel.cityName = incomingCity
        viewModel.initialize()
        self.tableVieww.backgroundColor = .black
    }
    
    func showSavedCoreData(content : AirQuality){
        lblCO.text = String(content.co)
        lblNO2.text = String(content.no2)
        lblOzone.text = String(content.ozone)
        lblPM10.text = String(content.pm10)
        lblPM25.text = String(content.pm25)
        lblSO2.text = String(content.so2)
        lblCityName.text = content.placeName
        lblTime.text = "\(content.day!) \(content.hour!)"
    }
}
// MARK: Extensions
extension DetailsViewController : DetailsViewModelOutputProtocol {
    func dataNotFound() {
        lblpreviosCity.text = "NO DATA FOR  \(incomingCity!)".uppercased()
        lblCityName.text = incomingCity
        lblTime.text = "Today \(time.date)"
    }
    
    func showDataAir(content: AirQualityModel) {
        guard let data = content.stations?[0] else {return}
        lblCO.text = String(data.co!)
        lblNO2.text = String(data.no2!)
        lblOzone.text = String(data.ozone!)
        lblPM10.text = String(data.pm10!)
        lblPM25.text = String(data.pm25!)
        lblSO2.text = String(data.so2!)
        lblCityName.text = data.placeName
        lblpreviosCity.text = "PREVIOUS ENTRIES FOR \(data.placeName!)".uppercased()
        lblTime.text = "Today \(time.hour)"
        viewModel.ListPreviousRecords(postalCode: data.postalCode!)
        tableVieww.reloadData()
    }
}

// MARK: UITableView
extension DetailsViewController : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = viewModel.list?.count else {return 0}
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PreviosTableViewCell
        guard let content = viewModel.list?[indexPath.row] else {return UITableViewCell()}
        cell.configure(content : content)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let data = viewModel.list?[indexPath.row] else {return}
        showSavedCoreData(content: data)
    }
}
