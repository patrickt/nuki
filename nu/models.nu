;; @file models.nu
;; @discussion Class definitions for schema entities.

;; Represents a page in the database.
(class Page is NSManagedObject
     
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