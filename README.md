# Kubernetes CRD and Custom Controllers

In Kubernetes, you can think of a "Custom Resource" as a way to create your own special objects to manage things that are unique to your application. These special objects are like the standard things Kubernetes knows how to handle, like Pods and Services, but they are tailored to your specific needs.

Imagine you're running a video game on Kubernetes, and you want to create a custom resource to represent a new type of in-game item. You can define the properties of this item, like its name, power, and special abilities, using something called a "Custom Resource Definition" (CRD).

A Custom Controller is a software component you create to watch and manage Custom Resources. It can automate tasks, like scaling applications or handling custom logic, based on the state of these custom objects.

# Current Environment

- Go (1.19)
- Kubectl (GitCommit : 1b4df30b3, Git Version: v1.27.0)
- KubeBuilder (3.5.0)
- Packages need to Install using apt such as make, build-essential
- Linux/AMD64

# Establish Current Environment
- Open Bash Terminal.
- Copy the setup script command from the git repo main branch and then execute the script.
```
controlplane ~ ➜ vi setup.sh
controlplane ~ ➜ # Copy setup.sh from this git repo.

controlplane ~ ➜ bash setup.sh
```

- Your Environment is Ready. Now we will see the next steps in the "createCRD Branch".
