;; @file application.nu
;;
;; @discussion Creation of the application delegate.
;;
;; @abstract Ideally, all the Core-Data related code in the ApplicationDelegate could be refactored into a CoreDataDelegate object included in the main Nu distribution - there's going to be things that every Core Data application needs. But we'll burn that bridge when we come to it.

(class ApplicationDelegate is NSObject
     
     ;; Callback that builds the menu and initializes the sessions
     (- (void) applicationDidFinishLaunching: (id) sender is
        
        



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
