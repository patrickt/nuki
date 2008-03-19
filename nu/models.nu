;; @file models.nu
;; @discussion Class definitions for schema entities.

(class Page is GitBlob
     
     (- (id) link is
          "LINKY LINKY")

     (- (id) descriptiveLinkTo is
          "<a href=\"/#{@path}\">Viewing #{@path}</a>")
     
     (+ (id) pageExistsWithName:(id)name is
          (NSFileManager fileExistsAtPath: "./#{name}"))
     
     (+ (id) fetchPage:(id)name is
          (Page withPath: name))
     
     (+ (id) fetchOrMakePage:(id)name is
          (shell "touch ./#{name}")
          (Page fetchPage: name)))