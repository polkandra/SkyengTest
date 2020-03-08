
import UIKit
import RSLoadingView

protocol WordDetailsViewControllerProtocol: class {
    func startLoading()
    func finishLoading()
    func update()
    func setTable()
}

class WordDetailsViewController: UIViewController {

    struct Constants {
       static let cellID = "BaseWordCell"
       static let nibName = "BaseWordDetailsTableViewCell"
    }
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    var presenter: WordDetailsPresenter!
    
    //MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.fetchWordDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUI()
        let loadingView = RSLoadingView()
        loadingView.speedFactor = 3.0
        loadingView.sizeFactor = 1.0
        loadingView.showOnKeyWindow()
    }
    
    //MARK: - Helpers
    func setUI() {
        view.backgroundColor = AppStyle.mainAppColor
    }
}

//MARK: - UITableViewDataSource
extension WordDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellID, for: indexPath) as! BaseWordDetailsTableViewCell
        cell.configureSelf(with: presenter.wordModel)
        return cell
    }
}

//MARK: - UITableViewDataDelegate
extension WordDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//MARK: - WordsSearchViewControllerProtocol
extension WordDetailsViewController: WordDetailsViewControllerProtocol {
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
            self.tableView.separatorStyle = .none
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.backgroundColor = AppStyle.mainAppColor
            self.tableView.register(UINib(nibName: Constants.nibName, bundle: nil), forCellReuseIdentifier: Constants.cellID)
            self.navigationItem.title = self.presenter.wordModel.title
        }
    }
}
