import UIKit
import Preferences
import CepheiPrefs

class RootListController: HBRootListController {

    private var cachedSpecifiers: NSMutableArray?

    override var specifiers: NSMutableArray? {
        get {
            if let cached = cachedSpecifiers {
                return cached
            }

            let loaded = self.loadSpecifiersFromPlistName(
                "Root",
                target: self
            )

            cachedSpecifiers = loaded
            return loaded
        }

        set {
            cachedSpecifiers = newValue
        }
    }
}
