(class GitBlob is NSObject
     
     (ivars) (ivar-accessors)
     
     (- (id) initWithPath:(id)p is
        (set @path p)
        (set @contents (self filesystemContents))
        self)
     
     (- (id) filesystemContents is
        (NSString stringWithContentsOfFile: "#{$repository}/#{@path}"
             encoding: UNICODE
             error: nil))
     
     (- (id) revisionHashes is
        (set huge-output (($session command: "rev-list HEAD #{@path}") stripWhitespace))
        (set hashes (/\n/ splitString: huge-output))
        (hashes removeLastObject)
        hashes)
     
     (- (id) contentsForRevisionHash:(id)hash is
        ($session command: "show #{hash}:#{@path}"))
     
     (- (id) headRevision is
        ($session command: "show :#{@path}"))
     
     (- (id) revisionsAgo:(int)ago is
        ($session command: "show @{#{ago}}:#{@path}"))
     
     (- (id) writeString:(id)string is
        (string writeToFile: "#{$repository}/#{@path}"
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
     
     (- (id) commitWithMessage:(id)msg is
        (self command: "commit -m \"#{msg}\""))

     
     (- (id) commit is
        (self commitWithMessage: "Automatically-generated commit from the Nu/Git interface."))
     
     (- (id) fileExists:(id)path is
        (NSFileManager fileExistsAtPath: "#{$repository}/#{path}"))
     
     (- (id) allBlobs is
        ((NSFileManager directoryContentsAtPath:$repository withPattern:/^[^\.]/) map:
                (do (path) ((GitBlob alloc) initWithPath:path))))
     
     (- (id) createBlob:(id)path withContents:(id)contents is
        (shell "touch #{$repository}/#{path}")
        (set blob ((GitBlob alloc) initWithPath: path))
        (blob writeString: contents)
        (blob add)
        blob)
     
     (- (id) fetchBlob:(id)path is
        (if (self fileExists: path)
            ((GitBlob alloc) initWithPath: path))))
