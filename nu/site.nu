(load "macros")

(global default-parameters
     (macro _
          (set HEAD <<-END
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<link href="/nuki.css" media="all" rel="Stylesheet" type="text/css"/>
END)
          (set TITLE (@match string))))

(get "/"
     (default-parameters)
     (NSLog "Parameters gotten to")
     (set @page (Page fetchPage: "FrontPage"))
     (NSLog "Page is #{@page}, rendering template")
     (set pc (eval (NuTemplate codeForFileNamed: "#{$site}/page.nhtml")))
     (NSLog "Page contents are #{pc}")
     pc)

(get "/nuki.css"
     (request setValue: "text/css" forResponseHeader:"Content-Type")
     (NSString 
          stringWithContentsOfFile: (concat-paths $site "nuki.css")
          encoding: 4
          error: nil))

(get /\/(\w*)/
     (default-parameters)
     (set @page (Page fetchPage: (TITLE lastPathComponent)))
     (render-template "page"))
     