Redstone is intended to speed up intial creation of an mvc application

Steps to try it out.

Create a new MVC 3 Empty Template project
1. install the Redstone.solution package ( install-package redstone.solution -IncludePrerelease )
2. in the package manager console type ( install-redstone )
3. Profit



It is really that simple.



The source code is this repository cannot be compiled. It is the set of nuget packages and content templates.
To tweak maglev, 

1. change the content files or powershell scripts, 
2. then run build.cmd
3. use the new packages in a new application to test out the changes.
