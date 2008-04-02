 ===============
 = Description =
 ===============

This version of Nuki will depend on Nunja and Git for its web server and version control.

 ================
 = Requirements =
 ================

Nuki depends on:
* Nu
* Nunja, which in turn depends on libevent
* NuMarkdown
* NuSmartyPants

 ================
 = Installation =
 ================


Run:
	nuke
to build the Nuki framework.
When that's built, run:
	./nukid
to launch Nukid, the Nuki daemon.

 ==========================================
 = THE NUKI SERVER WILL RUN ON PORT 3900. =
 ==========================================

 ===========
 = Credits =
 ===========

I owe an enormous debt of thanks to Tim Burks for building such an excellent language as Nu and as powerful of a web server as Nunja.

A big thanks to Grayson Hansard for pointing out bugs and writing the NuMarkdown and NuSmartyPants frameworks, without which Nuki would look much uglier.
