
import Foundation


public struct SwiftRuntime {
    
    public static func swizzing(sel: Selector,
                         rSel: Selector,
                         class classType: AnyClass) {
        let select1 = sel
        let select2 = rSel
        
        guard let select1Method = class_getInstanceMethod(classType, select1) else {
            return
        }
        
        guard let select2Method = class_getInstanceMethod(classType, select2) else {
            return
        }
        
        let didAddMethod = class_addMethod(classType,
                                           select1,
                                           method_getImplementation(select2Method),
                                           method_getTypeEncoding(select2Method))
        if didAddMethod {
            class_replaceMethod(classType,
                                select2,
                                method_getImplementation(select1Method),
                                method_getTypeEncoding(select1Method))
        } else {
            method_exchangeImplementations(select1Method, select2Method)
        }
    }
}


