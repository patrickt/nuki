;; @file main.nu
;; @discussion Entry point for Nuki.
;;

(load "Nu:nu")      	;; essentials
(load "Nu:cocoa")	     ;; wrapped frameworks
(load "Nu:menu")	     ;; menu generation
(load "Nu:console")	     ;; interactive console
(load "Nu:template")	;; nu templates
(load "Nu:coredata")
(load "nunja")
(load "NuMarkdown")

(macro reload
     (load "macros")
     (load "helpers")
     (load "git")
     (load "models")
     (load "preload")
     (load "application"))

(reload)

;; install the delegate and keep a reference to it since the application won't retain it.
((NSApplication sharedApplication) setDelegate:(set delegate ((ApplicationDelegate alloc) init)))

;; this makes the application window take focus when we've started it from the terminal
((NSApplication sharedApplication) activateIgnoringOtherApps:YES)

;; run the main Cocoa event loop
(NSApplicationMain 0 nil)
