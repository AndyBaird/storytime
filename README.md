#Madwire Media / Node-Express-Base
The base image for all of Madwire Media's Node docker containers running Express.js.

This is the general repository for node containers running an express.js server.  

* [Create a New Node Docker Project with Express.js](#CreateProject)
* [Setup and Run](#SetupAndRun)
* [Commiting a Repository](#CommitRepo)
* [Public Folder](#PublicFolder)

Thanks to Austin's setup in [Madshot](https://github.com/madwire-media/madshot)


##Create a New Node Docker Project with Express.js <a name="CreateProject"></a>

Create a new repository in madwire-media. Don't initialize it with a README.md, it will be added by the install.sh script.  Put the name or url of the new repository in between the < >. If you're on Windows, 

1. Clone the node-express-base repo  
		```
		git clone https://github.com/madwire-media/node-express-base.git <new-repo-folder>  
		```

2. Go into the folder you cloned it into  
		```
		cd <new-repo-folder>
		```

3. Run the install script. It will prompt you for the repository name and the port to use.  
		```  
		./install.sh  
		```  

4. Change the following fields in package.json: name, description, repository.url, bugs.url, and homepage to the current repo.
		Don't change the fields: main, private, script.start, and repository.type.
		The request dependency can be removed.  Add your dependencies manually in the package.json.

##Setup and Run <a name="SetupAndRun"></a>

Running the container involes a couple of steps


1. Go to github.com and generate a new OAuth token.  
	A. Login into Github.com  
	B. Go to settings  
	C. Go to Personal access tokens  
	D. Generate a new token  
	E. Give it a name, click the repo box, click Generate token  
 	F. Copy the token and save it (Keepass or some other secure storage), as this is the only time you will see it.  
	G. Copy the token hash into token.txt  

2. Go to project folder  <new-repo-folder>  
		```
		cd  <new-repo-folder>
		```

3. Copy the github OAuth token into docker/config/token.txt.  The docker/token.txt file is in the .gitignore file so your key will not upload to github.  

4. (Optional) If you want to log into mm360v2core, go to index.js and set the mm360Setup username and password.  

5. Go to the docker folder and type ./run.sh to run the container  

		cd docker  
		./run.sh  


##Commiting a Repository <a name="CommitRepo"></a>

Quick note on commiting the repository. The file docker/token.txt is in the .gitignore folder so
you can't upload github tokens to a github repository.

##Public Folder <a name="PublicFolder"></a>

The /public folder is by default setup to server static files and going to the server address in the browser will
render index.html.  This folder can be deleted if the service does not need to serve up static files.  Also delete the
following code in the index.js file.  
    ```javascript  
    app.use(express.static(__dirname + '/public'));    
    ``` 

