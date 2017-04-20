//
//  Copyright © 2017 Mobile Academy. All rights reserved.
//


import UIKit

class AgendaViewController: UITableViewController {

    var agendaProvider: AgendaProviding!

    // MARK: Initializers
    
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
        
        // TODO: reload agenda
    }

    // MARK: Table view
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AgendaItemCellIdentifier, for: indexPath) as! AgendaItemCell
        return cell;
    }
}
