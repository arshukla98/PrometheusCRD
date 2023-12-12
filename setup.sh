echo 'Updating Package Index and Installing make, build-essential'

sudo apt update && sudo apt install -y make build-essential

echo 'Installing Go 1.19'

sleep 2

export VERSION=1.19

curl  -L https://golang.org/dl/go${VERSION}.linux-amd64.tar.gz -o go${VERSION}.linux-amd64.tar.gz
  
tar -xzf go${VERSION}.linux-amd64.tar.gz -C /usr/local

export PATH=$PATH:/usr/local/go/bin
      
go version

echo 'Git Version:' $(git version | awk '{print $3}')
    
echo 'Enter Git Username:'
    
read GH_USERNAME
    
echo 'Enter Email ID associated to Github.'

read GH_EMAIL

git config --global user.name ${GH_USERNAME}

git config --global user.email ${GH_EMAIL}

git config --list

git config --global credential.helper cache

echo 'Installing kubebuilder 3.5.0'

sleep 3

curl -L https://github.com/kubernetes-sigs/kubebuilder/releases/download/v3.5.0/kubebuilder_linux_amd64 -o kubebuilder_3.5.0_linux_amd64

chmod +x  kubebuilder_3.5.0_linux_amd64

sudo mv  kubebuilder_3.5.0_linux_amd64 /usr/local/bin/kubebuilder

kubebuilder version

echo 'Installed All.'

echo 'Add Go bin to Path -> export PATH=$PATH:/usr/local/go/bin'
