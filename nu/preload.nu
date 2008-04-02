(function preload ()
     (unless ($session fileExists: "FrontPage")
          (puts "Loading pages into database.")
          ($session createBlob: "FrontPage" withContents:
<<-END
Welcome to Nuki!

Nuki is a simple Wiki engine powered by the Nunja web server, the Git version control system, and NuMarkdown.
As you can _see_, Markdown works.
END)
        ($session commit))
          (unless ($session fileExists: "About") 
               ($session createBlob: "About" withContents: "Nuki was made by Patrick Thomson.")
               ($session commit)))

