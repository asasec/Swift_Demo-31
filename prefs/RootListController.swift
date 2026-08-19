import UIKit
import Preferences
import CepheiPrefs

class RootListController: HBRootListController {
    override var specifiers: NSMutableArray? {
        get {
            if let specifiers = _specifiers {
                return specifiers
            }

            _specifiers = self.loadSpecifiersFromPlistName(
                "Root",
                target: self
            )

            return _specifiers
        }

        set {
            super.specifiers = newValue
        }
    }
}
