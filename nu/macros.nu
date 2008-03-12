;; @file macros.nu
;; @discussion Utility macros used throughout the Nuki source.

;; A conditional assignment operator, like Ruby's ||=. Takes two arguments: the variable name to check and its prospective value.
(macro set?
     (unless ((context) (car margs))
             ((context) setObject: (eval (car (cdr margs))) forKey: (car margs))))

;; A macro that grabs the current request's last path component. Takes no arguments.
(macro page-title ((request "path") lastPathComponent))

;; Renders a template. Takes one argument: the name of the file to render, without the .nhtml extension.
(macro render-template
     (eval (NuTemplate codeForFileNamed:
                ((NSBundle bundleWithIdentifier:"nu.programming.nuki")
                 pathForResource:(eval (car margs))
                 ofType:"nhtml"))))

;; Used internally to make setFoo: method names.
(function make-setter-name (oldName)
     (set newName "set")
     (newName appendString:((oldName substringToIndex:1) capitalizedString))
     (newName appendString:((oldName substringFromIndex:1)))
     (newName appendString:":")
     newName)

;; Creates an accessor method.
(macro reader
     (set __name ((car margs) stringValue))
     (_class addInstanceVariable:__name
             signature:"@")
     (_class addInstanceMethod:__name
             signature:"@"
             body:(do () (self valueForIvar:__name))))

;; Creates a mutator method.
(macro writer
     (set __name ((car margs) stringValue))
     (_class addInstanceVariable:__name
             signature:"@")
     (_class addInstanceMethod:(make-setter-name __name)
             signature:"v"
             body:(do (new) (self setValue:new forIvar:__name))))

;; Creates accessor/mutator methods.
(macro accessor
     (set __name ((car margs) stringValue))
     (_class addInstanceVariable:__name
             signature:"@")
     (_class addInstanceMethod:__name
             signature:"@"
             body:(do () (self valueForIvar:__name)))
     (_class addInstanceMethod:(make-setter-name __name)
             signature:"v"
             body:(do (new) (self setValue:new forIvar:__name))))