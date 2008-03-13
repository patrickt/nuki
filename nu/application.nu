;; @file application.nu
;;
;; @discussion Creation of the application delegate.


(class ApplicationDelegate is NSObject
     
     ;; Callback that initializes the sessions.
     (- (void) applicationDidFinishLaunching: (id) sender is
          (NSLog "Nuki: launching.")
          (set $session ((GitSession alloc) initInDirectory: "pages"))
          (set server (Nunja new))
          (server bindToAddress: "0.0.0.0" port: "3900")
          (server setDelegate: ((NunjaDelegate alloc) initWithSite: ((NSBundle mainBundle) resourcePath)))
          ($nunja setRoot: $site) ; $nunja is set to server's delegate.
          (preload)
          (server run)))
        
