;; @file site.nu
;; @discussion Handlers for HTTP requests.

(get "/"
    ; Bug occurs if the first parameter to this method is not defined?
    (Nunja redirectResponse:REQUEST toLocation:"/FrontPage"))
     
(get /\/pages/
    (set %silly (MATCH groupAtIndex: 0))
     (set %pages ($session allBlobs))
     (eval (template-named "listpages")))

(get /\/(\w*)/
     (set %path ((MATCH string) lastPathComponent))
     (set %page ($session fetchBlob: %path))
     (eval (template-named "page")))

(get /\/(\w*)\/edit/
     
     (set %path (TITLE pathComponent: 1))
     (set %page ($session fetchBlob: %path))
     (eval (template-named "edit")))

(post /\/(\w*)\/edit/
      
      (set %path (TITLE pathComponent: 1))
      (set %page ($session createBlob:%path withContents:((request post) "contents")))
      (set %message ((request post) "description"))
      (unless %message (set %message "Automatically-generated commit from Nuki."))
      ($session commitWithMessage: %message)
      (Nunja redirectResponse: request toLocation: "/#{%path}"))

(get /\/(\w*)\/history/
     
     (set %path (TITLE pathComponent: 1))
     (set %page ($session fetchBlob: %path))
     (set %allRevisions (%page revisionHashes))
     (eval (template-named "history")))

(get /\/(\w*)\/history\/(\w*)/
     
     (set %path (TITLE pathComponent: 1))
     (set %revision (TITLE pathComponent: 3))
     (set %page ($session fetchBlob: %path))
     (%page setContents: (%page contentsForRevisionHash: %revision))
     (eval (template-named "page")))

(get /\/(\w*)\/history\/(\w*)\/edit/
     
     (set %path (TITLE pathComponent: 1))
     (set %revision (TITLE pathComponent: 3))
     (set %page ($session fetchBlob: %path))
     (%page setContents: (%page contentsForRevisionHash: %revision))
     (eval (template-named "edit")))