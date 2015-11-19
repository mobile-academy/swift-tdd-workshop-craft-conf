//
//  Copyright © 2017 Mobile Academy. All rights reserved.
//


import UIKit

class AgendaViewController: UITableViewController {

    var agendaProvider: AgendaProviding!

    // MARK: Initialisers

    override init(style: UITableViewStyle) {
        super.init(style: style)
        self.agendaProvider = AgendaProvider()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.agendaProvider = AgendaProvider()
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.agendaProvider.reloadAgenda { [weak self] in
            self?.tableView.reloadData()
        }
    }

    // MARK: Table view

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.agendaProvider.agendaItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let agendaItem = self.agendaProvider.agendaItems[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: AgendaItemCellIdentifier, for: indexPath) as! AgendaItemCell

        cell.timeLabel.text = agendaItem.time
        cell.nameLabel.text = agendaItem.name

        return cell;
    }
}
