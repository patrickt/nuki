;; @file models.nu
;; @discussion Class definitions for schema entities.

(class Page is GitBlob
     (+ (id) fetchOrMakePage:(id)path is
          (shell "touch #{path}")
          (Page withPath: path)))