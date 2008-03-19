;; @file site.nu
;; @discussion Handlers for HTTP requests.

(get "/"
     (default-headers)
     (set @page (Page fetchPage: "FrontPage"))
     (set TITLE ("Front Page"))
     (eval (template-named "page")))

(get "/nuki.css"
     (request setValue: "text/css" forResponseHeader:"Content-Type")
     (file-named "nuki.css"))

(get /\/(\w*)/
     (default-headers)
     (puts "Nuki: asked for #{((TITLE pathComponents) description)}")
     (set @page (Page fetchPage: (TITLE lastPathComponent)))
     (eval (template-named "page")))