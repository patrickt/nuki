;; @file application.nu
;;
;; @discussion Creation of the application delegate.
;;
;; @abstract Ideally, all the Core-Data related code in the ApplicationDelegate could be refactored into a CoreDataDelegate object included in the main Nu distribution - there's going to be things that every Core Data application needs. But we'll burn that bridge when we come to it.

(class ApplicationDelegate is NSObject
     
     (- (void) moveIntoPageDirectory is
          (NSFileManager changeCurrentDirectoryPath: (concat-paths ((NSBundle mainBundle) resourcePath)))
          (shell "mkdir pages")
          (NSFileManager changeCurrentDirectoryPath: "./pages"))
     
     ;; Callback that builds the menu and initializes the sessions
     (- (void) applicationDidFinishLaunching: (id) sender is
          (NSLog "Nuki: launching.")
          (self moveIntoPageDirectory)
          (set $session ((GitSession alloc) initInDirectory: (NSFileManager currentDirectoryPath)))
          (preload)
          
          (set n (Nunja new))
          (n bindToAddress: "0.0.0.0" port: "3900")
          (n setDelegate: ((NunjaDelegate alloc) initWithSite: ((NSBundle mainBundle) resourcePath)))
          (n run)))
        
