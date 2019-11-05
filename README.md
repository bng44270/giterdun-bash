# giterdun
Manage git instaweb instances

###Installation:###
1. Run ```git clone https://github.com/bng44270/giterdun-bash.git```
2. Run ```make```
3. Run ```sudo make install```
  
  
###Misc Commands:###
* To start your repository, run ```giterdun.sh start REPONAME```.  
* To stop your repository, run ```giterdun.sh stop REPONAME```.  
* To remove your repository from giterdun, run ```giterdun.sh del REPONAME```.  
* To view all repositories in giterdun, run ```giterdun.sh list```.  
* To update repository status', run ```giterdun.sh update```.  
* To start all non-running repositories, run ```giterdun.sh start-all```.  
* To stop all running repositories, run ```giterdun.sh stop-all```.  

  
###Apache Integration:###
Uset [this](https://gist.github.com/bng44270/cff67619db3e3f915957) Apache macro to add multiple Instaweb instances into Apache.  This will reverse proxy all traffic through your Apache instance to the specified Instaweb isntance.
