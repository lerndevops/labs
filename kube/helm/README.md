# Helm, The Kubernetes package manager

> `Helm` helps you manage Kubernetes applications with `Helm Charts` which helps you define, install, and upgrade even the most complex Kubernetes application.

> The main building block of Helm based deployments are Helm Charts: these charts describe a configurable set of dynamically generated Kubernetes resources. 

> The charts can either be stored locally or fetched from remote chart repositories.

## The Basic Architecture / Helm Version 3

> Helm 3 is a single-service architecture. One executable is responsible for implementing Helm. There is no client/server split, nor is the core processing logic distributed among components.

> Implementation of Helm 3 is a single command-line client with no in-cluster server or controller. This tool exposes command-line operations, and unilaterally handles the package management process.

### ***The implementation has two distinct parts:***

1.    The command line façade, which translates commands, subcommands, flags, and arguments into a Helm operation
2.    The Helm library, which provides the logic for executing all Helm operations.

### **By design, the Helm library must be usable as a standalone library.**

## some key words to understand in helm 

### Chart 
A Chart is a Helm package. It contains all of the resource definitions necessary to run an application, tool, or service inside of a Kubernetes cluster. Think of it like the Kubernetes equivalent of a Homebrew formula, an Apt dpkg, or a Yum RPM file.

### Repository 
A Repository is the place where charts can be collected and shared. It’s like Perl’s CPAN archive or the Fedora Package Database, but for Kubernetes packages.

### Release 
A Release is an instance of a chart running in a Kubernetes cluster. One chart can often be installed many times into the same cluster. And each time it is installed, a new release is created. Consider a MySQL chart. If you want two databases running in your cluster, you can install that chart twice. Each one will have its own release, which will in turn have its own release name.


## Client Only Architecture

> Helm 3 has a client-only architecture with the client still called helm. As seen in the following diagram, it operates similar to the Helm 2 client, but the client interacts directly with the Kubernetes API server. The in-cluster server Tiller is now removed.

![helm3-architecture](https://github.com/lerndevops/static/blob/master/kube/helm3-architecture.PNG)


## Install Helm version3

```
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
```
```
root@kube-master:~# helm version --short
v3.0.2+g19e47ee
```

#### Common actions for Helm:

```
- helm search:    search for charts (helm search hub awx)
- helm pull:      download a chart to your local directory to view
- helm install:   upload the chart to Kubernetes
- helm list:      list releases of charts
```

### other helm commands

```
  completion  Generate autocompletions script for the specified shell (bash or zsh)
  create      create a new chart with the given name
  dependency  manage a chart's dependencies
  env         Helm client environment information
  get         download extended information of a named release
  help        Help about any command
  history     fetch release history
  install     install a chart
  lint        examines a chart for possible issues
  list        list releases
  package     package a chart directory into a chart archive
  plugin      install, list, or uninstall Helm plugins
  pull        download a chart from a repository and (optionally) unpack it in local directory
  repo        add, list, remove, update, and index chart repositories
  rollback    roll back a release to a previous revision
  search      search for a keyword in charts
  show        show information of a chart
  status      displays the status of the named release
  template    locally render templates
  test        run tests for a release
  uninstall   uninstall a release
  upgrade     upgrade a release
  verify      verify that a chart at the given path has been signed and is valid
```
