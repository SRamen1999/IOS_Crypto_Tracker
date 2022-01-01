//
//  ViewController.swift
//  CryptoTracker
//
//  Created by Shamim Rahman on 11/28/21.
//  crypto info api
//https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=false

// sources used
// I used this youtube tutorial to create this UItableview thats performs a segue
//https://www.youtube.com/watch?v=FNkS_QIngg8&list=LL&index=4&t=287s&ab_channel=PlanetVeracity

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
   
        
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
 
    var cryptos = [Crypto]()
    var filteredData: [Crypto]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        filteredData = cryptos
        
        downloadJSON {
            self.filteredData = self.cryptos
            self.tableView.reloadData()
            //print(self.filteredData[0].name)
            //print(self.filteredData[0].current_price as Any)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //timer to refresh the updates crypto prices
        _ = Timer.scheduledTimer(timeInterval: 40, target: self, selector: #selector(refreshData), userInfo: nil, repeats: true)
        
    }
    
    // refresh function
    @objc func refreshData() -> Void {
        viewDidLoad()
    }
    
    
    // get the number of rows for the UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    // what I want to show in each of my cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CryptoTrackerTableViewCell
        
        
        let imageUrlString = filteredData[indexPath.row].image
        let imageUrl:URL = URL(string: imageUrlString)!
        let imageData:NSData = NSData(contentsOf: imageUrl)!
        cell.imageLabel.image = UIImage(data: imageData as Data)
            
        cell.nameLabel.text = filteredData[indexPath.row].name.capitalized
            
        cell.priceLabel.text = "Price: \((filteredData[indexPath.row].current_price)!)"
        cell.accessoryType = .disclosureIndicator
        cell.nameLabel.font = .systemFont(ofSize: 20)
        cell.priceLabel.font = .systemFont(ofSize: 20)

        return cell
    }
   
    
    // spacing for each cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // perform a segue when clicking on the crypto cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    // mark: when clicking on the crypto go to the details screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CryptoViewController {
            destination.crypto = filteredData[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    // mark: Search bar config
    // I used this youtube tutorial https://www.youtube.com/watch?v=iH67DkBx9Jc&ab_channel=AjayGandecha
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = []
        if searchText == "" {
            filteredData = cryptos
        }
        else {
            for i in cryptos {
                if i.name.lowercased().contains(searchText.lowercased()) {
                    filteredData.append(i)
                }
            }
        }
        self.tableView.reloadData()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchbar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    // end of searchBar functions
      
    
    // mark: api/json decoder
    func downloadJSON(completed: @escaping () -> ()) {
        
        let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=false")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error == nil {
                do {
                    self.cryptos = try JSONDecoder().decode([Crypto].self, from: data!)
                    
                    DispatchQueue.main.async {
                        completed()
                    }
                }catch{
                    print("JSON Error")
                }
            }
        }.resume()
    }
    
   
}



