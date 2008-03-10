(load "NuMarkdown")
(load "helpers")

; Housekeeping to set up the server.
(unless $server
        (set $server ((NuHTTPController alloc) initWithPort:3900))
        ($server setLocal:YES) ;; serves to localhost only, for use behind a proxy server
        ($server setDocumentRoot:"#{$site}/files"))
($server setHandlers:(set handlers (array)))
(unless $sessionCookies (set $sessionCookies (dict)))

; Setting the default values for the HTTP header and title.
(macro defaults
     (set HEAD 
<<+END
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<link href="/nuki.css" media="all" rel="Stylesheet" type="text/css"/>
END)
     (set TITLE ((request "path") pathComponent: 1)))

; The top-level page. Redirects to FrontPage.
(get "/"
     (defaults)
     (self redirectResponse: response toLocation: "/FrontPage"))

; Renders the list of pages.
(get "/list/pages"
     (defaults)
     (set TITLE "Nuki: Page listing")
     (set @pages (Page objects))
     (render-template "listpages"))

; Displays a page to the user.
(get /\/(\w*)/
     (defaults)
     (set @page (Page objectWithProperty: "title" value: TITLE))
     (render-template "page"))

; Rendering the editing of a page.
(get /\/\w*\/edit/
     (defaults)
     (set @page (Page objectWithProperty: "title" value: TITLE))
     (render-template "edit"))
     
;; Destructive (HTTP POST) methods.

; Committing changes to a page.
(post /\/\w*\/edit/
     (defaults)
      (set post (request "post"))
      ;; Retrieving the page from the database.
      (set edited-page (Page objectWithProperty: "title" value: (TITLE)))
      ;; If it doesn't exist, then create it.
      (set? edited-page (Page createWith: (title: TITLE)))
      ;; Either way, set its contents and save it
      (edited-page setContents: (post "contents"))
      (if ($session save)
           ($flash notice: "Page successfully edited.")
           (else
                ($flash alert: "Nuki encountered an error while trying to save the page.")))
      ;; Redirect back to the page itself.
      (self redirectResponse: response toLocation: "/#{(TITLE)}"))

; Deletes a page.
(post /\/\w*\/delete/
     (defaults)
     ((Page objectWithProperty: "title" value: TITLE) delete)
     (if ($session save)
          (set $message "#{TITLE} successfully deleted.")
          (else
               (set $alert "Nuki encountered an error while trying to delete the page.")))
     (self redirectResponse: response toLocation: "/"))