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