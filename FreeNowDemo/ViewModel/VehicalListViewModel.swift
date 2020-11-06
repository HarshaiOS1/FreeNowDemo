//
//  VehicalListDataModel.swift
//  FreeNowDemo
//
//  Created by Harsha K on 01/11/20.
//

import Foundation

class VehicalListViewModel: NSObject {
    
    private(set) var vehicalListModel : VehicalListModel! {
        didSet {
            self.modelObserver()
        }
    }
    var modelObserver : (() -> ()) = {}
    
    func getVehicalListInHamburgArea(completion : @escaping (Bool, String?) -> ()) {
        print()
    
        let cleanStr = (NetworkConstants.urlWithHamburgLocation as NSString).replacingOccurrences(of: " ", with: "")
        if let url:URL = URL(string: cleanStr) {
            let request = URLRequest.init(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 120)
            URLSession.shared.dataTask(with: request) {(data, response, error) in
                if error != nil {
                    completion(false, error?.localizedDescription)
                }
                let string1 = String(data: data ?? Data(), encoding: String.Encoding.utf8) ?? "Data could not be printed"
                print(string1)
                guard let _data = data else {
                    completion(false, "no data")
                    return
                }
                do {
                    let decodModel =  try JSONDecoder().decode(VehicalListModel.self, from: _data)
                    self.vehicalListModel = decodModel
                } catch {
                    completion(false, "error")
                }
            }.resume()
        } else {
            completion(false, "error")
        }
    }
    
    func filterData(dropDownRow: Int) -> [PoiList]? {
        var filterModel : [PoiList]?
        if let list = vehicalListModel?.poiList {
            switch dropDownRow {
            case FilterOptions.none.rawValue:
                filterModel = vehicalListModel.poiList
            case FilterOptions.active.rawValue:
                filterModel = list.filter { ($0.state?.rawValue.uppercased() == State.active.rawValue.uppercased())}
            case FilterOptions.inactive.rawValue:
                filterModel = list.filter { ($0.state?.rawValue.uppercased() == State.inactive.rawValue.uppercased())}
            case FilterOptions.nearest.rawValue:
                filterModel = list.sorted { ($0.heading ?? 0) < ($1.heading ?? 0)}
            default:
                break
            }
        }
        return filterModel
    }
    
    enum FilterOptions: Int {
        case none = 0
        case active
        case inactive
        case nearest
    }
}
