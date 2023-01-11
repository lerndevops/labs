## What is Terraform?

> Terraform is a tool for building, changing, and versioning infrastructure safely and efficiently. it is developed by Hashicorp & written in GoLang

> Terraform is also known as `infrastructure as code solution`

## Infrastructure as code?

> in simple words provisioning / creating infrastructure with code 

> Infrastructure as code, or IaC, has gained a lot of momentum over the years because it helps solve several problems that trobeled infrastructure management in the past. 

## IaC enabels 

* `Reproducible Environments:` 
    * By using code to generate infrastructure, the same environment can be created over and over. 
    * Over a perdiod of time an environment can drift away from its desired state and difficult to diagnose issues can creep into your release pipeline. 
    * With IaC no environment gets special treatment and fresh new environments are easily created and destroyed.

* `Idempotence & Convergence:` 
    * Extending the last point, idempotence is the trait that no matter you apply the configuration described by your IaC, there are no side effects on the environment. 
    * Convergence is the trait that actions are only taken if they need to be. 
    * In IaC, only the actions needed to bring the environment to the desired state are executed. If the environment is already in the desired state, no actions are taken.

* `Easing collaboration:` 
    * Having the code in a version control system like Git allows teams to collaborate on infrastructure. 
    * Team members can get specific versions of the code and create their own environments for testing or other scenarios.

* `Self-service infrastructure:` 
    * A pain point that often existed for developers before moving to cloud infrastructure was the delays required to have operations teams create the infrastructure they needed to build new features and tools. 
    * With the elasticity of the cloud allowing resources to be created on-demand, developers can provision the infrastructure they need when they need it. 
    * IaC further improves the situation by allowing developers to use infrastructure modules to create identical environments at any point in the application development lifecycle. 
    * The infrastructure modules could be created by operations and shared with developers freeing developers from having to learn another skill.




## How Terraform, providers and modules work

Terraform provisions, updates, and destroys infrastructure resources such as physical machines, VMs, network switches, containers, and more.

## Configurations
 code written for Terraform, using the human-readable HashiCorp Configuration Language (HCL) to describe the desired state of infrastructure resources.

## Providers 
The plugins that Terraform uses to manage those resources. Every supported service or infrastructure platform has a provider that defines which resources are available and performs API calls to manage those resources.

## Modules 
Reusable Terraform configurations that can be called and configured by other configurations. Most modules manage a few closely related resources from a single provider.

## The Terraform Registry
makes it easy to use any provider or module. To use a provider or module from this registry, just add it to your configuration; when you run `terraform init`, Terraform will automatically download everything it needs.
