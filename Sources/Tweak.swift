import Jinx
import UIKit

@_cdecl("jinx_entry")
func jinxEntry() {
    NSLog("[JinxSwiftTweak] Tweak loaded successfully!")
    
    // Kendi hook tanımlamalarını buraya ekleyebilirsin
    // Örnek: MyCustomHook().hook()
}
