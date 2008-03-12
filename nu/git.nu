(load "macros")
(load "helpers")
(load "extensions")

(class GitSession is NSObject
     (accessor location)
     
     (+ (id) sessionWithLocation:(id)loc is
          (set s (GitSession new))
          (s setLocation: loc)
          s)
     
     (- (id) command:(id)text
          (puts "Nu: git #{text}")
          (shell "git #{text}"))
          
     (- (id) addFile:(id)file
          )
     
     )

(function git (command)
     (puts "Nu: git #{command}")
     (shell "git #{command}"))

(function add (path)
     (git "add #{path}"))
     
(function commit
     (git "commit -m Automatically generated commit from the Nu-Git interface."))
     
;; High-level interface to a Git-backed file.
(class GitBackedFile is NSObject
     (accessor path)

     (- (id) initWithPath:(id)path is
          (super init)
          (set @path path)
          self)
     
     (- (id) currentContents is
          (NSString stringWithContentsOfFile: (concat-paths REPOSITORY_LOCATION @path) encoding: 4 error: nil))
     
     (- (id) revisionsAgo:(int)ago is
          (git "show HEAD~#{ago}:#{@path}"))
          
     (- (void) writeText:(id)text is
          (text writeToFile: (concat-paths REPOSITORY_LOCATION @path)
               atomically: YES
               encoding: 4
               error: nil))
     
     (- (void) save is
          (add (@path lastPathComponent))
          (commit)))