(load "macros")
(load "helpers")
(load "extensions")

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
          (NSString stringWithContentsOfFile: @path encoding: 4 error: nil))
     
     (- (id) revisionsAgo:(int)ago is
          (git "show HEAD~#{ago}:#{@path}")))