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
          (set fp (Page fetchOrMakePage: "FrontPage"))
          (NSLog "Page created: #{fp}")
          (NSLog "Page contents are: #{(fp filesystemContents)}")
          (NSLog "Now writing a string")
          (fp writeString: "Sixteen motherfuckers.")
          (NSLog "Page contents are now #{(fp filesystemContents)}")
          (fp add)
          ($session commit)))
        
