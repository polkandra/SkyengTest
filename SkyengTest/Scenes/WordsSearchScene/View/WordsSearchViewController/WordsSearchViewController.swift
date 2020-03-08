
import UIKit
import RSLoadingView

//MARK: - WordsSearchViewControllerProtocol
protocol WordsSearchViewControllerProtocol: class {
    func startLoading()
    func finishLoading()
    func update()
    func setTable()
}

class WordsSearchViewController: UIViewController {
    
    struct Constants {
        static let cellID = "DefaultCell"
        static let navTitle = "Dictionary"
    }
    
    //MARK: - Outlets
    @IBOutlet weak var searchBar: SearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    var presenter: WordSearchPresenter!
    
    //MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        
        searchBar.onSearch = { [weak self] text in
            guard let unwrappedSelf = self else { return }
            if text.count >= 2 {
                unwrappedSelf.tableView.isHidden = false
                unwrappedSelf.presenter.fetchWords(by: text)
            } else {
                unwrappedSelf.tableView.isHidden = true
            }
        }
    }
    
    func setUI() {
        view.backgroundColor = AppStyle.mainAppColor
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = Constants.navTitle
        
        searchBar.barTintColor = AppStyle.mainAppColor
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.textColor = .black
        
        tableView.isHidden = true
    }
    
    //MARK: - Helpers
    func configureDefaultCell(by cell: UITableViewCell, and indexPath: IndexPath) {
        cell.selectionStyle = .none
        cell.contentView.backgroundColor = AppStyle.mainAppColor
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = AppStyle.tableFont
        cell.textLabel?.text = presenter.wordsModels[indexPath.row].title
    }
}

//MARK: - UITableViewDataSource
extension WordsSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.wordsModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellID, for: indexPath)
        configureDefaultCell(by: cell, and: indexPath)
       
        return cell
    }
}

//MARK: - UITableViewDataDelegate
extension WordsSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = presenter.wordsModels[indexPath.row]
        presenter.didTapOnModel(model: model)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//MARK: - WordsSearchViewControllerProtocol
extension WordsSearchViewController: WordsSearchViewControllerProtocol {
    func update() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func startLoading() {
        DispatchQueue.main.async {
            let loadingView = RSLoadingView()
            loadingView.showOnKeyWindow()
            loadingView.speedFactor = 3.0
            loadingView.sizeFactor = 1.0
        }
    }
    
    func finishLoading() {
        DispatchQueue.main.async {
            RSLoadingView.hideFromKeyWindow()
        }
    }
    
    func setTable() {
        DispatchQueue.main.async {
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.backgroundColor = AppStyle.mainAppColor
            self.tableView.keyboardDismissMode = .onDrag
            self.tableView.separatorStyle = .none
            self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellID)
        }
    }
}
