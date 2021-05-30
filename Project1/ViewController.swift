//
//  ViewController.swift
//  Project1
//
//  Created by Повелитель on 28.05.2021.
//

import UIKit

class ViewController: UITableViewController {

    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
                        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        pictures.sort()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            // 1: Try loading "Detail" view controller & type casting it to be DetailViewController
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController
            
        {
            // 2: If success -> set property values over in DetailViewController.swift
            vc.selectedImage = pictures[indexPath.row]
            // Set "selectedImage" string value
        
            // Set values to selectedImagePosition & totalNumberOfImages
            vc.selectedPictureNumber = indexPath.row + 1
            // "+1" to show human-readable index number instead of Swift index number approach
            
            vc.totalPictures = pictures.count
            // Equates total count of pictures array
            
            // 3: Now push it onto the navigation controller
            navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    
}
