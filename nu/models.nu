;; @file models.nu
;; @discussion Class definitions for schema entities.

(load "git")
(load "helpers")

(class Page is GitBackedFile

     (+ (id) pageWithName: (id)name is
          (set fn (concat-paths REPOSITORY_LOCATION "pages" "name"))
          (shell "touch #{fn}")
          ((Page alloc) initWithPath: ("pages/#{name}"))))

;; Represents a page in the database.
(class OldPage is NSManagedObject
     
     ;; I may be taking liberties with MVC here.
     ;; But I refuse to repeat myself in the views.
     
     (imethod (id) linkTo is
          "<a href=\"/#{(self title)}\">#{(self title)}</a>")
     
     (imethod (id) descriptiveLinkTo is
          "<a href=\"/#{(self title)}\">Viewing #{(self title)}</a>")
     
     (imethod (id) deleteButton is <<+END
<form action="/#{(self title)}/delete" method="post">
     <input type="submit" value="Delete"> 
</form>END
)

     
     (ivar-accessors))