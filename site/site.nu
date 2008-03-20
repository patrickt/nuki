;; @file site.nu
;; @discussion Handlers for HTTP requests.

(get "/"
     (default-headers)
     (puts "Handling request for the front page.")
     (self redirectResponse: request toLocation: "/FrontPage"))

(get "/nuki.css"
     (request setValue: "text/css" forResponseHeader:"Content-Type")
     (file-named "nuki.css"))

(get /\/(\w*)/
     (default-headers)
     (set @path (TITLE lastPathComponent))
     (set @page nil)
     (if ($session fileExists: @path)
          (set @page ($session fetchBlob: @path)))
     (eval (template-named "page")))

(get /\/(\w*)\/edit/
     (default-headers)
     (set @path (TITLE pathComponent: 1))
     (set @page nil)
     (if ($session fileExists: @path)
          (set @page ($session fetchBlob: @path)))
     (eval (template-named "edit")))

(post /\/(\w*)\/edit/
     (default-headers)
     (set post (request post))
     (set @path (TITLE pathComponent: 1))
     (set @page ($session fetchBlob: @path))
     (puts "Page's path is #{(@page path)}")
     (puts (post "contents"))
     (@page writeString: (post "contents"))
     (@page add)
     ($session commit)
     (self redirectResponse: request toLocation: "/#{@path}"))