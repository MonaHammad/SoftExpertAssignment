//
//  ViewController.swift
//  SoftExpert
//
//  Created by Mona Hammad on 1/21/20.
//  Copyright © 2020 Mona Hammad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    var hits: [Hits] = []
    var query = ""
    @IBOutlet weak var searchBar: UISearchBar!
    var currentPage : Int = 0
    var isLoadingList : Bool = false
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchBar.text?.isEmpty ?? true
    }

    func isFiltering() -> Bool {
        return searchBar.isFocused && !searchBarIsEmpty()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.estimatedRowHeight = 44
        tableView.tableFooterView = UIView()
        loadingView.isHidden = true
        activityIndicator.stopAnimating()
        searchBar.delegate = self
    }
    
    func getRecipes() {
        // Build up the URL
        isLoadingList = false

        let components = URLComponents(string: "https://api.edamam.com/search?q=\(query)&app_id=971ad906&app_key=00d8df64104f9eca991b868062fdc8f0&from=\(currentPage)")!
//        components.queryItems = ["title": "New York Highlights"].map { (key, value) in
//            URLQueryItem(name: key, value: value)
//        }

        // Generate and execute the request
        let request = URLRequest(url: components.url!)
        let task = URLSession.shared.dataTask(with: request) {[weak self] (data, response, error) in
            do {
                guard let data = data,
                    let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode,
                    error == nil else {
                    // Data was nil, validation failed or an error occurred.
                    throw error ?? Error.requestFailed
                }
                let model = try JSONDecoder().decode(Model.self, from: data)
                print("Created board title is \(model.q ?? "")") // New York Highlights
                self?.hits.append(contentsOf: model.hits ?? [])
                DispatchQueue.main.async {
                self?.tableView.reloadData()
                }
            } catch {
                print("Board creation failed with error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
}
enum Error: Swift.Error {
    case requestFailed
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell else {
            return UITableViewCell()
        }
        let recipe =  hits[indexPath.row].recipe
        cell.title.text = recipe?.label
        cell.source.text = recipe?.source
        if let imagePath = recipe?.image {
            cell.imageView?.downloaded(from: imagePath)
        }
        if let healthLabels = recipe?.healthLabels {
            for text in healthLabels {
                let label = UILabel()
                label.text = text
                label.textAlignment = .center
                cell.stackView.addArrangedSubview(label)
            }
        }
       
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hits.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height ) && !isLoadingList){
            self.isLoadingList = true
            self.loadMoreItemsForList()
        }
    }
    func loadMoreItemsForList(){
    currentPage += 1
    getRecipes()
    }
}
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
       guard searchBar.text != "" else {
            return
        }
        query = searchBar.text ?? ""
        currentPage = 0
        getRecipes()
    }
}
