;; @file site.nu
;; @discussion Handlers for HTTP REQUESTs.

(get "/"
    ; Bug occurs if the first parameter to this method is not defined?
    (Nunja redirectResponse:REQUEST toLocation:"/FrontPage"))
     
(get /\/pages/
     (set %pages ($session allBlobs))
     (eval (template-named "listpages")))

(get /\/(\w*)/
     (set %path ((MATCH string) lastPathComponent))
     (set %page ($session fetchBlob: %path))
     (eval (template-named "page")))

(get /\/(\w*)\/edit/
     
     (set %path ((MATCH string) pathComponent: 1))
     (set %page ($session fetchBlob: %path))
     (eval (template-named "edit")))

(post /\/(\w*)\/edit/
      
      (set %path ((MATCH string) pathComponent: 1))
      (set %page ($session createBlob:%path withContents:((REQUEST post) "contents")))
      (set %message ((REQUEST post) "description"))
      (unless %message (set %message "Automatically-generated commit from Nuki."))
      ($session commitWithMessage: %message)
      (Nunja redirectResponse: REQUEST toLocation: "/#{%path}"))

(get /\/(\w*)\/history/
     
     (set %path ((MATCH string) pathComponent: 1))
     (set %page ($session fetchBlob: %path))
     (set %allRevisions (%page revisionHashes))
     (eval (template-named "history")))

(get /\/(\w*)\/history\/(\w*)/
     
     (set %path ((MATCH string) pathComponent: 1))
     (set %revision ((MATCH string) pathComponent: 3))
     (set %page ($session fetchBlob: %path))
     (%page setContents: (%page contentsForRevisionHash: %revision))
     (eval (template-named "page")))

(get /\/(\w*)\/history\/(\w*)\/edit/
     
     (set %path ((MATCH string) pathComponent: 1))
     (set %revision ((MATCH string) pathComponent: 3))
     (set %page ($session fetchBlob: %path))
     (%page setContents: (%page contentsForRevisionHash: %revision))
     (eval (template-named "edit")))