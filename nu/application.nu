;; @file application.nu
;;
;; @discussion Creation of the application delegate.
;;
;; @abstract Ideally, all the Core-Data related code in the ApplicationDelegate could be refactored into a CoreDataDelegate object included in the main Nu distribution - there's going to be things that every Core Data application needs. But we'll burn that bridge when we come to it.

(class ApplicationDelegate is NSObject
     ;; Accessor for the session global.
     (- (id) session is 
          $session)
     
     ;; Accessor for the Core Data object model.
     (- (id) managedObjectModel is 
          ($session managedObjectModel))
     
     ;; Accessor for the Core Data object context.
     (- (id) managedObjectContext is 
          ($session managedObjectContext))
          
     ;; Accessor for the Core Data persistent store coordinator.
     (- (id) persistentStoreCoordinator is 
          ($session persistentStoreCoordinator))
     
     ;; Reloads the auxiliary files.
     (- (void) reload:(id)sender is
        (reload))
       
     ;; Loads the front page in a browser. Accessed through the menu.
     (- (void) openBrowser:(id) sender is
          ((NSWorkspace sharedWorkspace) openURL: (NSURL URLWithString: @"http://localhost:3900")))
     
     ;; Pops up a Nu console where one can run commands.
     (- (void) toggleConsole:(id)sender is
        (set? $console (NuConsoleWindowController new))
        ($console toggleConsole: self))
     
     ;; Callback that builds the menu and initializes the sessions
     (- (void) applicationDidFinishLaunching: (id) sender is
        (build-menu nuki-application-menu "Nuki")
        (set nuki-mom ((NSBundle mainBundle) pathForResource:"Nuki" ofType:"mom"))
        (set $session ((NuCoreDataSession alloc) initWithName:"Nuki" mom:nuki-mom sqliteStore:"#{$site}/data/Nuki.data"))
        ; During development, sometimes the persistent store coordinator would be unable to save.
        ; This catches that contingency.
        (if (eq ((($session persistentStoreCoordinator) persistentStores) count) 0)
            (set alert (NSAlert new))
            (alert set: (messageText: "Nuki encountered a data storage error."
                         informativeText: "Nuki was unable to obtain a persistent store coordinator. Saving will be disabled. Try restarting/recompiling Nuki, and make sure that the site/data directory is writable."
                         alertStyle: NSWarningAlertStyle))
            (alert addButtonWithTitle: "OK")
            (alert runModal)
            (else
                 (puts "Session has #{((($session persistentStoreCoordinator) persistentStores) count)} store(s).")))
        
        ;; Making sure that some objects are included if this is the first run.
        (if (($session objects) empty?)
            (preload))))



;; Nuki's menu description
(set nuki-application-menu
     '(menu "Main"
            (menu "Application"
                  ("About #{appname}" action:"orderFrontStandardAboutPanel:")
                  (separator)
                  (menu "Services")
                  (separator)
                  ("Hide #{appname}" action:"hide:" key:"h")
                  ("Hide Others" action:"hideOtherApplications:" key:"h" modifier:(+ NSAlternateKeyMask NSCommandKeyMask))
                  ("Show All" action:"unhideAllApplications:")
                  (separator)
                  ("Quit #{appname}" action:"terminate:" key:"q"))
            (menu "File"
                  ("Reload" action:"reload:" key:"r"))
            (menu "Edit"
                  ("Undo" action:"undo:" key:"z")
                  ("Redo" action:"redo:" key:"Z")
                  (separator)
                  ("Cut" action:"cut:" key:"x")
                  ("Copy" action:"copy:" key:"c")
                  ("Paste" action:"paste:" key:"v")
                  ("Delete" action:"delete:")
                  ("Select All" action:"selectAll:" key:"a")
                  (separator)
                  (menu "Find"
                        ("Find..." key:"f")
                        ("Find Next" key:"g")
                        ("Find Previous" key:"d")
                        ("Use Selection for Find" key:"e")
                        ("Scroll to Selection" key:"j"))
                  (menu "Spelling"
                        ("Spelling..." action:"showGuessPanel:")
                        ("Check Spelling" action:"checkSpelling:")
                        ("Check Spelling as You Type" action:"toggleContinuousSpellChecking:")))
            (menu "Window"
                  ("Open browser" action: "openBrowser:" key: "b")
                  ("Show console" action: "toggleConsole:" key: "c")
                  ("Minimize" action:"performMiniaturize:" key:"m")
                  (separator)
                  ("Bring All to Front" action:"arrangeInFront:"))
            (menu "Help"
                  ("#{appname} Help" action:"showHelp:" key:"?"))))
