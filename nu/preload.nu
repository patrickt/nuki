(function preload ()
     (unless (Page pageExistsWithName: "FrontPage")
          (NSLog "Loading pages into database.")
          (set fp (Page fetchOrMakePage: "FrontPage"))
          (fp writeString: "This is the Front Page..")
          (fp add)

          (set ab (Page fetchOrMakePage: "About"))
          (ab writeString: "Nuki was made with an absurd amount of effort.")
          (ab add)

          ($session commit)))

