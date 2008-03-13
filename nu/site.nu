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
     (set @page (Page fetchPage: "FrontPage"))
     (render-template "page"))
     
(get /\/(\w*)/
     (default-parameters)
     (set @page (Page fetchPage: (TITLE lastPathComponent)))
     (render-template "page"))
     