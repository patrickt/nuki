;; @file site.nu
;; @discussion Handlers for HTTP requests.

(get "/"
     (default-headers)
     (set @page (GitBlob fetchBlobAtPath: "FrontPage"))
     (set @path "FrontPage")
     (set TITLE "Front Page")
     (eval (template-named "page")))

(get "/nuki.css"
     (request setValue: "text/css" forResponseHeader:"Content-Type")
     (file-named "nuki.css"))

(get /\/(\w*)/
     (default-headers)
     (set @path (TITLE lastPathComponent))
     (set @page (GitBlob fetchBlobAtPath: @path))
     (eval (template-named "page")))

(get /\/(\w*)\/edit/
     (default-headers)
     (set @path (TITLE pathComponent: 1))
     (set @page (GitBlob fetchBlobAtPath: @path))
     (eval (template-named "edit")))

(post /\/(\w*)\/edit/
     (default-headers)
     (set post (request post))
     (set @path (TITLE pathComponent: 1))
     (set @page (GitBlob new))
     (@page setPath: @path)
     (puts "Page's path is #{(@page path)}")
     (puts (post "contents"))
     (@page writeString: (post "contents"))
     (@page add)
     ($session commit)
     (self redirectResponse: request toLocation: "/#{@path}"))