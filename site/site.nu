;; @file site.nu
;; @discussion Handlers for HTTP requests.

(get "/"
     (default-headers)
     (self redirectResponse: request toLocation: "/FrontPage"))

(get "/nuki.css"
     (request setValue: "text/css" forResponseHeader:"Content-Type")
     ;; This has to be served with NSData in order to prevent HTML characters being inserted.
     (NSData dataWithContentsOfFile: "#{$site}/nuki.css"))

(get "/nunja.gif"
     (request setValue: "image/gif" forResponseHeader: "Content-Type")
     (NSData dataWithContentsOfFile: "#{$site}/nunja.gif"))

(get "/pages"
     (default-headers)
     (set @pages ($session allBlobs))
     (eval (template-named "listpages")))

(get /\/(\w*)/
     (default-headers)
     (set @path (TITLE lastPathComponent))
     (set @page ($session fetchBlob: @path))
     (eval (template-named "page")))

(get /\/(\w*)\/edit/
     (default-headers)
     (set @path (TITLE pathComponent: 1))
     (set @page ($session fetchBlob: @path))
     (eval (template-named "edit")))

(post /\/(\w*)\/edit/
      (default-headers)
      (set @path (TITLE pathComponent: 1))
      (set @page ($session createBlob:@path withContents:((request post) "contents")))
      ($session commit)
      (self redirectResponse: request toLocation: "/#{@path}"))

(get /\/(\w*)\/history/
     (default-headers)
     (set @path (TITLE pathComponent: 1))
     (set @page ($session fetchBlob: @path))
     (set @allRevisions (@page revisionHashes))
     (eval (template-named "history")))

(get /\/(\w*)\/history\/(\w*)/
     (default-headers)
     (set @path (TITLE pathComponent: 1))
     (set @revision (TITLE pathComponent: 3))
     (set @page ($session fetchBlob: @path))
     (@page setContents: (@page contentsForRevisionHash: @revision))
     (eval (template-named "page")))

(get /\/(\w*)\/history\/(\w*)\/edit/
     (default-headers)
     (set @path (TITLE pathComponent: 1))
     (set @revision (TITLE pathComponent: 3))
     (set @page ($session fetchBlob: @path))
     (@page setContents: (@page contentsForRevisionHash: @revision))
     (eval (template-named "edit")))