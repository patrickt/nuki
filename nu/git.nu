(class GitBlob is NSObject
     
     (ivars) (ivar-accessors)
     
     (- (id) filesystemContents is
        (NSString
                 stringWithContentsOfFile: "#{$repository}/#{@path}"
                 encoding: UNICODE
                 error: nil))
     
     (- (id) headRevision is
        ($session command: "show :#{@path}"))
     
     (- (id) revisionsAgo:(int)ago is
        ($session command: "show @{#{ago}}:#{@path}"))
     
     (- (id) writeString:(id)string is
        (string
               writeToFile: "#{$repository}/#{@path}"
               atomically: YES
               encoding: UNICODE
               error: nil))
     
     (- (void) add is
        ($session command: "add #{@path}")))

(class GitSession is NSObject
     (ivars) (ivar-accessors)
     
     (- (id) initInDirectory:(id)loc is
        (super init)
        (unless (NSFileManager directoryContentsAtPath: "#{$repository}/.git")
                (puts "Initializing new git repository.")
                (self command: "init"))
        self)
     
     (- (id) command:(id)text is
        (NSFileManager changeCurrentDirectoryPath: $repository)
        (puts "Nu: git #{text}")
        (set command (shell "git #{text}"))
        (NSFileManager changeCurrentDirectoryPath: $root)
        command)
     
     (- (id) commit is
        (self command: "commit -m 'Automatically generated commit from the Nu/Git interface.'"))
     
     (- (id) fileExists:(id)path is
        (NSFileManager fileExistsAtPath: "#{$repository}/#{path}"))
     
     (- (id) createBlob:(id)path withContents:(id)contents is
        (shell "touch #{$repository}/#{path}")
        (set blob (GitBlob new))
        (blob setPath: path)
        (blob writeString: contents)
        (blob add)
        blob)
     
     (- (id) fetchBlob:(id)path is
        (puts "Fetching blob.")
        (set b (GitBlob new))
        (b setPath: path)
        b)
     
     )
