(global UNICODE 4)

(global shell
        (do (cmd)
            (NSString stringWithShellCommand: cmd)))

(global p
    (do (obj)
        (puts (obj description))))
        
(global link-to-page
    (do (page)
        "<a href=\"#{(page path)}\">#{(page path)}</a>"))

(global display-page
    (do (page)
        (if page
            (NuMarkdown convert: (page contents))
            (else
                "This page doesn't exist yet. Click on the 'Edit' link above to create it."))))