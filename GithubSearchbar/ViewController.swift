//
//  ViewController.swift
//  GithubSearchbar
//
//  Created by 10362 on 2024/1/8.
//

import UIKit

class ViewController: UIViewController {

    let authToken = "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"  //Expires on Fri, Jun 28 2024.
    var searchKeyword = "swift"
    
    @IBOutlet weak var tfSearch: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSearchPressed(_ sender: Any) {
        guard let searchRepo = tfSearch.text else { return  }
        self.searchAPI(with: searchRepo)
    }
    func searchAPI(with searchRepoName : String) {
        let urlString: String = "https://api.github.com/search/repositories?q=\(searchRepoName)"
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.addValue("token \(authToken)", forHTTPHeaderField: "Authorization")
            
            // 創建 URLSession 並發送請求
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                if let data = data {
                    // 在這裡處理返回的數據，這可能涉及 JSON 解析等操作
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        print(json)
                    } catch {
                        print("Error parsing JSON: \(error)")
                    }
                }
            }
            task.resume()
        }
    }
}

