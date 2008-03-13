;; @file macros.nu
;; @discussion Utility macros used throughout the Nuki source.

(global template-named
        (macro template-named-macro
             (NuTemplate codeForFileNamed: "#{$site}/#{(eval (car margs))}.nhtml")))

(global file-named
        (macro file-named-macro
             (NSString stringWithContentsOfFile: "#{$site}/#{(eval (car margs))}"
                  encoding: 4 # Unicode
                  error: nil)))

;; Default header information
(global default-headers
        (macro default-headers-macro
             (set HEAD <<-END
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<link href="/nuki.css" media="all" rel="Stylesheet" type="text/css"/>
END)
             (set TITLE (@match string))))