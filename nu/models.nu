;; @file models.nu
;; @discussion Class definitions for schema entities.

(class Page is GitBlob
     
     (+ (id) pageExistsWithName:(id)name is
          (NSFileManager fileExistsAtPath: (concat-paths ($session location) name)))
     
     (+ (id) fetchPage:(id)path is
          (Page withPath: path))
     
     (+ (id) fetchOrMakePage:(id)path is
          (shell "touch #{path}")
          (Page withPath: path)))