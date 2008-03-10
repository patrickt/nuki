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
