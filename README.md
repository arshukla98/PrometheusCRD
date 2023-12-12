# Kubernetes CRD and Custom Controllers

In Kubernetes, you can think of a "Custom Resource" as a way to create your own special objects to manage things that are unique to your application. These special objects are like the standard things Kubernetes knows how to handle, like Pods and Services, but they are tailored to your specific needs.

Imagine you're running a video game on Kubernetes, and you want to create a custom resource to represent a new type of in-game item. You can define the properties of this item, like its name, power, and special abilities, using something called a "Custom Resource Definition" (CRD).

A Custom Controller is a software component you create to watch and manage Custom Resources. It can automate tasks, like scaling applications or handling custom logic, based on the state of these custom objects.

Your Current Environment is Ready as we executed certain steps in main branch. Now Execute the following steps.

# Current Environment

- Go (1.19)
- Kubectl (GitCommit : 1b4df30b3, Git Version: v1.27.0)
- KubeBuilder (3.5.0)
- Packages need to Install using apt such as make, build-essential
- Linux/AMD64

# Create an Empty Go Module

- Clone the Repository
```
controlplane ~ ✦ ➜  git clone https://github.com/arshukla98/PrometheusCRD.git
Cloning into 'PrometheusCRD'...
remote: Enumerating objects: 4, done.
remote: Counting objects: 100% (4/4), done.
remote: Compressing objects: 100% (4/4), done.
remote: Total 4 (delta 0), reused 4 (delta 0), pack-reused 0
Unpacking objects: 100% (4/4), 1.45 KiB | 1.45 MiB/s, done.
controlplane ~ ✦ ➜  cd PrometheusCRD
```
- Create a new branch 'createCRD'
```
controlplane PrometheusCRD on  main ➜  git checkout -b createCRD
Switched to a new branch 'createCRD'
```
- Create CRD Directory
```
controlplane ~ ➜  mkdir Persona
controlplane ~ ➜  cd Persona
```
- Specify the location of all the project dependencies in GOMODCACHE.
```
controlplane PrometheusCRD on  createCRD ➜  go env -w GOMODCACHE=$PWD/.deps/pkg/mod
controlplane PrometheusCRD on  createCRD ➜  go env | grep GOMODCACHE
GOMODCACHE="/root/PrometheusCRD/.deps/pkg/mod"
```
- Initialize this whole directory as Go Module and check the contents.
```
controlplane PrometheusCRD on  createCRD ➜  go mod init github.com/USERNAME/PrometheusCRD
go: creating new go.mod: module github.com/USERNAME/PrometheusCRD
controlplane PrometheusCRD on  createCRD [?] via 🐹 v1.19 ➜  ls -la
total 32
drwxr-xr-x 4 root root 4096 Dec 12 05:39 .
drwx------ 1 root root 4096 Dec 12 05:37 ..
drwxr-xr-x 3 root root 4096 Dec 12 05:39 .deps
drwxr-xr-x 8 root root 4096 Dec 12 05:37 .git
-rw-r--r-- 1 root root   52 Dec 12 05:39 go.mod
-rw-r--r-- 1 root root 1398 Dec 12 05:37 README.md
-rw-r--r-- 1 root root 1126 Dec 12 05:37 setup.sh
```
# Push This change to the Github Repo.
- Mention '.deps' in .gitignore. Whatever you mention in .gitignore, it will not be pushed to repository.
```
controlplane PrometheusCRD on  createCRD [?] via 🐹 v1.19 ➜  cat > .gitignore
.deps
^C
```
- View the Content  
```
controlplane PrometheusCRD on  createCRD [?] via 🐹 v1.19 ➜  git status
```
- Push the Content to Staging Area.
```
controlplane PrometheusCRD on  createCRD [?] via 🐹 v1.19 ➜  git add .
```
- View the Staged Changes.
```
controlplane PrometheusCRD on  createCRD [?] via 🐹 v1.19 ➜  git status
```
- Now Commit so that later it can be pushed to Github. The Output will be similar to what is shown below.
```
controlplane PrometheusCRD on  createCRD [?] via 🐹 v1.19 ➜  git commit -m "first commit in the createCRD branch"
[createCRD (root-commit) 155261f] first commit in the createCRD branch
 2 files changed, 4 insertions(+)
 create mode 100644 .gitignore
 create mode 100644 go.mod
```
- Push the branch to Remote Repo. Make Sure you have mention Gihub USERNAME and Personal Access Token as Password.
```
controlplane PrometheusCRD on  createCRD [?] via 🐹 v1.19 ➜  git push -u origin createCRD
