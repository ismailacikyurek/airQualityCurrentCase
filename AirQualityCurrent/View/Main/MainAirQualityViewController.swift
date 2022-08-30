//
//  ViewController.swift
//  AirQualityCurrent
//
//  Created by İSMAİL AÇIKYÜREK on 19.08.2022.
//

import UIKit
import Alamofire

class MainAirQualityViewController: UIViewController {
    // MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    private let serviceManager = ServiceManager()
    private let service: AirQualityDataServiceProtocol = AirQualityDataService()
    var viewModel : MainAirQualityViewModelProtocol = MainAirQualityViewModel()
    var sentCity : String?
    // MARK: Funcutions
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.initialize()
        viewModel.setUpDelegate(self)
        searchBarProperties()
        loading()
    }
    
    func loading() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            guard let city = self?.viewModel.city else {return}
            self?.viewModel.filterCityArray = city
            self?.activityView.isHidden = true
            self?.tableView.isHidden = false
            self?.tableView.reloadData()
            }
    }
    
    func searchBarProperties() {
        searchbar.setImage(UIImage(), for: .search, state: .normal)
        searchbar.delegate = self
        searchbar.searchTextField.borderStyle = .none
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetails" {
            let nextViewController = segue.destination as? DetailsViewController
            nextViewController?.incomingCity = sentCity
        }
    }
}
// MARK: UITableView
extension MainAirQualityViewController : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filterCityArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if viewModel.filterCityArray.count != 0 {
            cell.textLabel?.text = viewModel.filterCityArray[indexPath.row]
        }
        else {
            cell.textLabel?.text = viewModel.city[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sentCity = viewModel.filterCityArray[indexPath.row]
        performSegue(withIdentifier: "goToDetails", sender: nil)
    }
}
// MARK: UISearchBar
extension MainAirQualityViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(searctext: searchText)
        tableView.reloadData()
    }
}
