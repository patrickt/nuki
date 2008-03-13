(load "macros")

(global default-parameters
     (macro _
          (set TITLE (@match string))))

(get "/"
     (set frontpage (Page fetchPage: "FrontPage"))
     (frontpage filesystemContents))
     
(get /\/(\w*)/
     (default-parameters)
     "HELLO THERE")
     