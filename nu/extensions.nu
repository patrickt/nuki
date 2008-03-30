(class NSFileManager
     ;; Forwards unknown methods to the singleton instance of NSFileManager.
     (+ handleUnknownMessage:(id)message withContext:(id)ctx is
        ((NSFileManager defaultManager) sendMessage:message withContext:ctx)))

(class NSString
     
     ;; Whitespace removal. Self-explanaory.
     (- (id) stripWhitespace is
          (self stringByTrimmingCharactersInSet:(NSCharacterSet whitespaceCharacterSet)))
     
     ;; Grabs the nth path component. There is no error checking on this. Be careful.
     (- (id) pathComponent:(int)index is
          ((self pathComponents) index))
     
     ;; This makes string substitution much more concise and Rubyesque.
     ;; Merely an alias for replaceWithString:inString:
     (- (id) sub:(id)re with:(id)string is
          (re replaceWithString:string inString:self))
     
     ;; This escapes all HTML characters. Perhaps this should be included in NuTemplate?
     (- (id) escapeHTML is
          ((((self sub: /&/  with: "&amp;")
             sub: /\"/ with: "&quot;")
            sub: />/  with: "&gt;")
           sub: /</  with: "&lt;")))

(class NSNull
     ;; Overriding stringValue prevents parentheses from appearing everywhere in my templates.
     ;; Kids, don't try this at home. I feel very dirty writing this.
     (- (id) stringValue is "")) 