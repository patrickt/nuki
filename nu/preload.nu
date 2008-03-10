;; These preload data into the database, in case you delete yours.

(function preload ()
     (Page createWith: (title: "FrontPage" contents: <<-END
Welcome to Nuki!

This is a sample front page. You can edit it with the 'Edit' link in the above menu bar.

Nuki uses the NuMarkdown package for text formatting: *Hello there*.

(That was Markdown. You'll have to trust me.)

Links are done with Markdown syntax: [AboutNuki](/AboutNuki)

Normal HTML is escaped: <b> </b>
END))
     (Page createWith: (title: "AboutNuki" contents: <<-END
Nuki is made with Cocoa, Nu, NuMarkdown, NuHTTP and a little work.

A debt of thanks goes to Tim Burks for creating such a great language and toolset.
END))
     ($session save))