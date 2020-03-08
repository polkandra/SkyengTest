import UIKit

public class SearchBar: UISearchBar {
    
    private var throttler: Throttler? = nil
    
    public var throttlingInterval: Double? = 0 {
        didSet {
            guard let interval = throttlingInterval else {
                self.throttler = nil
                return
            }
            self.throttler = Throttler(seconds: Int(interval))
        }
    }
    
    public var onCancel: (() -> (Void))? = nil
    public var onSearch: ((String) -> Void)? = nil
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
    }
}

extension SearchBar: UISearchBarDelegate {
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        resignFirstResponder()
        self.onCancel?()
    }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        resignFirstResponder()
    }
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let throttler = self.throttler else {
            self.onSearch?(searchText)
            return
        }
        throttler.throttle {
            DispatchQueue.main.async {
                self.onSearch?(self.text ?? "")
            }
        }
    }
}


