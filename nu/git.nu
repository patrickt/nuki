(class GitBlob is NSObject
     
     (ivars) (ivar-accessors)
     
     (+ (id) fetchBlobAtPath:(id)p is
          (if ($session blobExistsAtPath: p)
               (set x (GitBlob new))
               (x setPath: p)
               x
               (else nil)))
     
     (- (id) filesystemContents is 
          (NSString 
               stringWithContentsOfFile: (concat-paths $site "pages" @path)
               encoding: 4
               error: nil))
     
     (- (id) headRevision is 
          ($session command: "show :#{@path}"))
     
     (- (id) revisionsAgo:(int)ago is 
          ($session command: "show @{#{ago}}:#{@path}"))
     
     (- (id) diffRevisionsAgo:(int)ago is nil)
     
     (- (id) writeString:(id)string is
          (string 
               writeToFile: (concat-paths $site ($session location) @path)
               atomically: YES
               encoding: 4
               error: nil))
     
     (- (void) add is 
          ($session command: "add #{@path}")))

(class GitSession is NSObject
     (ivars) (ivar-accessors)
     
     (- (id) initInDirectory:(id)loc is
          (super init)
          (set @location loc)
          (unless (NSFileManager directoryContentsAtPath: "#{$site}/#{@location}/.git")
               (puts "Initializing new git repository.")
               (self command: "init"))
          self)
     
     (- (id) command:(id)text is
          (puts "Nu: git #{text}")
          (shell "git #{text}"))
          
     (- (id) commit is
          (self command: "commit -m 'Automatically generated commit from Nu.'"))
          
     (- (id) blobExistsAtPath:(id)path is
          (NSFileManager fileExistsAtPath: "#{$site}/#{@location}/#{path}")))
