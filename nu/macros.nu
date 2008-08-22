(global template-named
        (macro __tn
             (NuTemplate codeForFileNamed: "#{$site}/#{(eval (car margs))}.nhtml")))
