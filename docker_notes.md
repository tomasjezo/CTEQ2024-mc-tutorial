# `docker` notes

Here we describe our recommended way of using docker.

## First example
- Pull container 
   ```bash
   docker pull hello-world
   ```
- Check it's there
   ```bash
   docker images
   ```
   This should print
   ```
   REPOSITORY                        TAG       IMAGE ID       CREATED         SIZE
   hello-world                       latest    ee301c921b8a   15 months ago   9.14kB
   ```
- Run it
  ```bash
  docker run hello-world --name hello-world
  ```
  This will show the hello world message from Docker.
  ```
   Hello from Docker!
   This message shows that your installation appears to be working correctly.

   To generate this message, Docker took the following steps:
    1. The Docker client contacted the Docker daemon.
    2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
       (arm64v8)
    3. The Docker daemon created a new container from that image which runs the
       executable that produces the output you are currently reading.
    4. The Docker daemon streamed that output to the Docker client, which sent it
       to your terminal.

   To try something more ambitious, you can run an Ubuntu container with:
   $ docker run -it ubuntu bash

   Share images, automate workflows, and more with a free Docker ID:
    https://hub.docker.com/

   For more examples and ideas, visit:
    https://docs.docker.com/get-started/
   ```
- Listing all running docker containers can be done with
   ```bash
   docker ps
   ```
- But it ran and exited. To list also stopped containers, we add `-a` switch
   ```bash
   docker ps -a
   ```
- To start and stop the container we can do
   ```bash
   # start a container
   docker start hello-world
   # stop a container
   docker stop hello-world
   ```
   
## Setting up

1. We first pull the `mc-tutorial` image
   - from the docker hub
   ```
   docker pull tomasjezo/mc-tutorial
   ```
   - from our local container repository
   ```
   docker pull cteqschool.lan:5000/mc-tutorial
   ```

2. Then we enter the directory we want to work in and create a container from the image
   ```
   docker run -it -d -v ./:/home -w /home --name mc-tutorial mc-tutorial
   ``` 
   The `-it` flag runs the container with a terminal attached to it, `-d` in detached state.
   The `-v` flag mounts the current working directory under the `/home` path in the container and the `-w` flag changes the working directory to `/home`. `--name` makes the container available under the name `mc-tutorial`.

   The container now should appear when listing the containers. The command
   ```
   docker ps
   ```
   yields
   ```
   CONTAINER ID   IMAGE          COMMAND   CREATED          STATUS                      PORTS     NAMES
   <id>           <image_id>     "bash"    xy seconds ago   Up xy seconds                         mc-tutorial
   ```

3. Finally, we can execute any command in the container as follows
   ```
   docker exec mc-tutorial <COMMAND>
   ```
   If you want to run an interactive command like `python` make sure to use the `-it` flag
   ```
   docker exec -it mc-tutorial <COMMAND>
   ```

4. Alternatively it may be useful to setup an `alias`, if available in your terminal:
   ```
   alias dexec="docker exec -it mc-tutorial"
   ```
   The command
   ```
   dexec <COMMAND>
   ```
   will then be automatically automatically substituted for
   ```
   docker exec -it mc-tutorial <COMMAND>
   ```

## Running Python with the `mc-tutorial` container 

- run `python` interpreter terminal
   ```
   docker exec -it mc-tutorial python
   ```
   type command and execute them there. The `-it` flag ensures the interactive mode is invoked, otherwise the command just exits.

- save the code to a source file `<fname>.py` and run
   ```
   docker exec mc-tutorial python <fname>.py
   ``` 
   The `-it` flag is not necessary, but won't hurt. 

## Compiling `Pythia8` programs with the `mc-tutorial` container 

Here we assume that the directory you work in is the same as the working directory used during the creation of the container. Otherwise, make use of the `-w` flag to tell docker the current working directory.

1. Get the `Makefile` from the container 
   ```
   docker exec mc-tutorial cat /usr/local/share/Pythia8/examples/Makefile > Makefile
   docker exec mc-tutorial cat /usr/local/share/Pythia8/examples/Makefile.inc > Makefile.inc
   ```
2. a. If you want your progam to be linked against `libpythia8` then you can simply name your source file `mymainNN.cc` where NN is between 01 and 99 and run
   ```
   docker exec mc-tutorial make mymainNN
   ```
   b. If also need linking against `HepMC3` then name your source code as you wish, for example `mysource.cc`. Then you need to modify the `Makefile` by replacing the line 100 
   ```
   main131 main132 main133 main134 main135: $(PYTHIA) $$@.cc
   ```
   by 
   ```
   main131 main132 main133 main134 main135 mysource: $(PYTHIA) $$@.cc
   ```
   and run
   ```
   docker exec mc-tutorial make mysource
   ```
   c. If you also need other libraries, modify one of the other targets in the `Makefile`.
