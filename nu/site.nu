(load "macros")

(global default-parameters
     (macro _
          (set HEAD <<-END

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
     