//
//  CryptoNewsViewController.swift
//  CryptoTracker
//
//  Created by Shamim Rahman on 12/4/21.
// crypto news api url
//https://crypto-news-live.p.rapidapi.com/news/coindesk/?rapidapi-key=4f066d1aa8msh929828ed47134c9p1170b5jsn6dc1f5c24224

// I used this youtube tutorial to create this UItableview
//https://www.youtube.com/watch?v=FNkS_QIngg8&list=LL&index=4&t=287s&ab_channel=PlanetVeracity


import UIKit
import SafariServices

class CryptoNewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var cryptoNews = [CryptoNews]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        downloadNews {
            self.tableView.reloadData()
        }
        
        tableView.delegate = self
        tableView.dataSource = self

    }
    
   
    // get the number of rows for the UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptoNews.count
    }
    
    // text styling
    func makeAttributedString(subtitle: String) -> NSAttributedString {
        let subtitleAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .subheadline)]
        let subtitleString = NSAttributedString(string: subtitle, attributes: subtitleAttributes)
        return subtitleString
    }
    
    // what I want to show in each of my cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
    
        cell.textLabel!.numberOfLines = 0
        cell.textLabel!.lineBreakMode = .byWordWrapping
        
        cell.textLabel!.font = .systemFont(ofSize: 20)
        cell.textLabel!.text = cryptoNews[indexPath.row].title
        
        cell.backgroundColor = .clear
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.adjustsFontSizeToFitWidth = true
      
        return cell
    }
    
    // I used https://www.youtube.com/watch?v=V2IfBdxjWs4&t=1720s&ab_channel=iOSAcademy to make this
    // function
    // go to safari when you click the news cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true  )
        guard let url = URL(string: cryptoNews[indexPath.row].url ) else  {
            return
        }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    // spacing for each cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
    // mark: api/json decoder
    func downloadNews(completed: @escaping () -> ()) {
        
        let url = URL(string: "https://crypto-news-live.p.rapidapi.com/news/coindesk/?rapidapi-key=4f066d1aa8msh929828ed47134c9p1170b5jsn6dc1f5c24224")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error == nil {
                do {
                    self.cryptoNews = try JSONDecoder().decode([CryptoNews].self, from: data!)
                    
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
