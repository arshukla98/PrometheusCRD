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
```

## Initializing Kubernetes Project
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
- Check If there are any changes. I hope not.
```
controlplane PrometheusCRD on  main via 🐹 v1.19➜  git status
On branch main
Your branch is up to date with 'origin/main'.
nothing to commit, working tree clean
```
- Change branch to createCRD.
```
controlplane PrometheusCRD on  main via 🐹 v1.19➜  git checkout createCRD
Switched to branch 'createCRD'
Your branch is up to date with 'origin/createCRD'.
```
- Note the KubeBuilder Version.
```
controlplane PrometheusCRD on  createCRD via 🐹 v1.19 ➜  kubebuilder version
Version: main.version{KubeBuilderVersion:"3.5.0", KubernetesVendor:"1.24.1", GitCommit:"26d12ab1134964dbbc3f68877ebe9cf6314e926a", BuildDate:"2022-06-24T12:17:52Z", GoOs:"linux", GoArch:"amd64"}
```
- Remove setup.sh file if present. 
```
controlplane PrometheusCRD on  createCRD via 🐹 v1.19 ➜ rm setup.sh
```
-  Initializes a Kubernetes project using the Kubebuilder framework and sets the domain for your project to "core.example.com." This domain typically represents the root domain for your Kubernetes Custom Resource Definitions (CRDs) and can help identify your custom resources in a cluster.
```
controlplane PrometheusCRD on  createCRD via 🐹 v1.19 ➜  kubebuilder init --domain core.example.com
Writing kustomize manifests for you to edit...
Writing scaffold for you to edit...
Get controller runtime:
$ go get sigs.k8s.io/controller-runtime@v0.12.1
......
go: downloading github.com/nxadm/tail v1.4.8
go: downloading gopkg.in/tomb.v1 v1.0.0-20141024135613-dd632973f1e7
Next: define a resource with:
$ kubebuilder create api
```
- Restore setup.sh via git restore.
```
controlplane PrometheusCRD on  createCRD [✘!?] via 🐹 v1.19 ➜  git restore setup.sh
```
- You will notice the changes after applying 'git status'. Move these changes to staging area using 'git add .' and then commit. Later Push the committed changes.

## Creating CRD, Custom Resource and Custom Controller

- I faced certain issues while running "kubebuilder create api" so I would suggest to clone this repo in GOPATH/src. Here are the
next steps.
- Check your GOPATH. If is not set, set it to ~/go.
```
controlplane ~ ➜  echo $GOPATH

controlplane ~ ➜  export GOPATH=~/go
controlplane ~ ➜  echo $GOPATH
/root/go
```
- Create 3 dirs under GOPATH namely bin, pkg and src. Change directory to src.
```
controlplane ~ ➜  mkdir -p go/bin go/pkg go/src
controlplane ~ ➜  cd ~/go/src
```
- Create directory github.com/Github_Username under src.
```
controlplane ~/go/src ➜  mkdir -p github.com/arshukla98
controlplane ~/go/src ➜  cd github.com/arshukla98
```
- Now clone the CRD repo in this dir. Switch to createCRD branch.
```
controlplane src/github.com/arshukla98 ➜  git clone https://github.com/arshukla98/PrometheusCRD.git
Cloning into 'PrometheusCRD'...
remote: Enumerating objects: 43, done.
remote: Counting objects: 100% (43/43), done.
remote: Compressing objects: 100% (37/37), done.
remote: Total 43 (delta 4), reused 42 (delta 3), pack-reused 0
Unpacking objects: 100% (43/43), 49.58 KiB | 1.38 MiB/s, done.

controlplane src/github.com/arshukla98 ➜  cd PrometheusCRD

controlplane PrometheusCRD on  main ➜  git checkout createCRD
Branch 'createCRD' set up to track remote branch 'createCRD' from 'origin'.
Switched to a new branch 'createCRD'

controlplane PrometheusCRD on  createCRD via 🐹  v1.19 ➜
```
- Download the dependencies in GOPATH/pkg/mod folder shown below.
```
controlplane PrometheusCRD on  createCRD via 🐹  v1.19 ➜  go get ./...
go: downloading sigs.k8s.io/controller-runtime v0.12.1
go: downloading k8s.io/client-go v0.24.0
go: downloading k8s.io/apimachinery v0.24.0
....
....
go: warning: github.com/Azure/go-autorest/autorest/adal@v0.9.13: retracted by module author: retracted due to token refresh errors
go: to switch to the latest unretracted version, run:
        go get github.com/Azure/go-autorest/autorest/adal@latest
```
- Run one more command as said above.
```
controlplane PrometheusCRD on  createCRD via 🐹 v1.19 ➜  go get github.com/Azure/go-autorest/autorest/adal@latest
go: downloading github.com/Azure/go-autorest/autorest v0.11.29
go: downloading github.com/Azure/go-autorest/autorest/adal v0.9.23
...
...
go: upgraded golang.org/x/text v0.3.7 => v0.7.0
go: upgraded gopkg.in/yaml.v3 v3.0.0-20210107192922-496545a6307b => v3.0.1
```
- Make sure GO111MODULE is unset.
```
controlplane ~ ➜  echo $GO111MODULE
```
- In this step, create a golang schema for the custom resource. We'll create an API named PromCR in the monitoring group and version v1.
```
controlplane PrometheusCRD on  createCRD [!] via 🐹 v1.19 ➜  kubebuilder create api --group monitoring --version v1 --kind PromCR

Create Resource [y/n]
y
Create Controller [y/n]
y
Writing kustomize manifests for you to edit...
Writing scaffold for you to edit...
api/v1/promcr_types.go
controllers/promcr_controller.go
Update dependencies:
$ go mod tidy
go: downloading github.com/onsi/gomega v1.18.1
go: downloading github.com/onsi/ginkgo v1.16.5
.....
.....
go: downloading golang.org/x/mod v0.6.0-dev.0.20220106191415-9b9b3d81d5e3
/root/go/src/github.com/arshukla98/PrometheusCRD/bin/controller-gen object:headerFile="hack/boilerplate.go.txt" paths="./..."
Next: implement your new API and generate the manifests (e.g. CRDs,CRs) with:
$ make manifests
```
- The Above command generates various files, including the CRD definition, controller, and API type definition.
- Now change the golang schema as shown in folder 'api/v1/promcr_types.go'. Change as per your wish and commit the changes.
- Generate the manifests (e.g. CRDs,CRs)
```
controlplane PrometheusCRD on  createCRD [?⇡] via 🐹 v1.19 ➜  make manifests
/root/go/src/github.com/arshukla98/PrometheusCRD/bin/controller-gen rbac:roleName=manager-role crd webhook paths="./..." output:crd:artifacts:config=config/crd/bases

controlplane PrometheusCRD on  createCRD [?⇡] via 🐹 v1.19 ➜ 
```
- You will notice that a CRD YAML is created at the location 'config/crd/bases' and its name is 'monitoring.core.example.com_promcrs.yaml'.
```
controlplane PrometheusCRD on  createCRD [!?] via 🐹 v1.19 ➜  ls config/crd/bases/
monitoring.core.example.com_promcrs.yaml
```
## Apply The CRDs and Create a Custom Resource.

- Verify the CRD is present or not.
```
controlplane PrometheusCRD on  createCRD [!] via 🐹  v1.19 ➜  kubectl api-resources | grep Prom

```
- Apply the CRD as shown below.
```
controlplane PrometheusCRD on  createCRD [!] via 🐹  v1.19 ✖ kubectl apply -f config/crd/bases/monitoring.core.example.com_promcrs.yaml
customresourcedefinition.apiextensions.k8s.io/promcrs.monitoring.core.example.com created
```
- Now verify the CRD is present or not.
```
controlplane PrometheusCRD on  createCRD [!] via 🐹  v1.19 ➜  kubectl api-resources | grep Prom
promcrs                                        monitoring.core.example.com/v1         true         PromCR
```
- Get the Persona Objects
```
controlplane PrometheusCRD on  createCRD [!] via 🐹  v1.19 ➜  kubectl get promcr
No resources found in default namespace.

controlplane PrometheusCRD on  createCRD [!] via 🐹  v1.19 ➜ 
```

