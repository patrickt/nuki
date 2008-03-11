(load "macros")

(function command (cmd)
   (system "git #{cmd}"))
   
(class GitBackedFile is NSObject
     )