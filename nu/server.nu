(set $sessionCookies (dict))

(get "/"
     (set TITLE "FRONT PAAAAAGE.")
     (set frontpage (Page fetchOrMakePage: "FrontPage"))
     (frontpage filesystemContents))