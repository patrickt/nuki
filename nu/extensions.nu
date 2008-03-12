;; @file extensions.nu
;; @discussion Extensions to preexisting classes.

;; @copyright  Copyright (c) 2008 Patrick Thomson. Released to the public under the Apache

;; Forwards unknown methods to the singleton instance of NSFileManager.
(class NSFileManager
     (+ handleUnknownMessage:message withContext:context is
        ((NSFileManager defaultManager) sendMessage:message withContext:context)))

(class NSManagedObject
     ;; Syntactic sugar for creation of an NSManagedObject.
     ;; Takes a property list consisting of all of the values to insert into the object.
     (cmethod (id) createWith:(id)plist is
          (((self class) createObject) set: plist)))

(class NSSet
     ;; Determines whether this set is empty.
     ;; This should probably be generalized to NuEnumerable classes - but right now it does what I need.
     (imethod (id) empty? is
          (== (self count) 0)))

(class NSString
     
     ;; Grabs the nth path component. There is no error checking on this. Be careful.
     (imethod (id) pathComponent:(int)index is
          ((self pathComponents) index))
     
     ;; This makes string substitution much more concise and Rubyesque.
     ;; Merely an alias for replaceWithString:inString:
     (imethod (id) sub:(id)re with:(id)string is
          (re replaceWithString:string inString: self))
     
     ;; This escapes all HTML characters. Perhaps this should be included in NuTemplate?
     (imethod (id) escapeHTML is
          ((((self sub: /&/  with: "&amp;")
             sub: /\"/ with: "&quot;")
            sub: />/  with: "&gt;")
           sub: /</  with: "&lt;")))

(class NSMutableDictionary
     (- (id) handleUnknownMessage:(id)message withContext:(id)ctx is
          (case  (message length)
                (1 (self objectForKey: ((first message) stringValue)))
                (2 (self setObject: (second message) forKey: (((first message) labelName) stringValue)))
                (else (super handleUnknownMessage: message withContext: ctx)))))
