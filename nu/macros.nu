(global template-named
        (macro __tn
             (NuTemplate codeForFileNamed: "#{$site}/#{(eval (car margs))}.nhtml")))

;; Default header information
(global default-headers
        (macro __dh
             (set HEAD <<-END
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<link href="/nuki.css" media="all" rel="Stylesheet" type="text/css"/>
END)
             (set TITLE (@match string))))