(function preload ()
     (unless ($session blobExistsAtPath: "FrontPage")
          (puts "Loading pages into database.")
          (set fp (GitBlob fetchBlobAtPath: "FrontPage"))
          (fp writeString: "This is the Front Page.")
          (fp add)

          (set ab (GitBlob fetchBlobAtPath: "About"))
          (ab writeString: "Nuki was made with an absurd amount of effort.")
          (ab add)

          ($session commit)))

