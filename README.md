
# Kubernetes K3S Terraform Module
This module is inspired by [cicdteam/terraform-hcloud-k3s](https://github.com/cicdteam/terraform-hcloud-k3s) with extra applications ready to be installed with ``` make apply```. All Applications are using HELM charts, and highly customizable.

Use [Hetzner Cloud link](https://hetzner.cloud/?ref=6PAAEo0epOOA) to get €20  

## List of Applications:
 - [cert-manager](https://cert-manager.io/): 3 ways to choice for issuing certificates [HTTP01, DNS01_CLOUDFLARE, [DNS01_HETZNER](https://github.com/deyaeddin/cert-manager-webhook-hetzner)]
 - [default-backend](https://github.com/bitnami/charts/tree/master/bitnami/nginx): default bitnami-nginx chart
 - [external-dns](https://github.com/bitnami/charts/tree/master/bitnami/external-dns):  external-dns chart with ability to chose between "hetzner or cloudflare"
 - [nginx-ingress-controller](https://github.com/bitnami/charts/tree/master/bitnami/nginx-ingress-controller): default bitnami-nginx-ingress-controller chart, with annotations:
   - load-balancer.hetzner.cloud/name: ${lb_name}
   - load-balancer.hetzner.cloud/location: ${lb_location}
   - load-balancer.hetzner.cloud/use-private-ip: "true"
   - load-balancer.hetzner.cloud/disable-private-ingress: "true"
   - load-balancer.hetzner.cloud/ipv6-disabled: "true"
   - load-balancer.hetzner.cloud/protocol: ${lb_protocol}


***refer to [Inputs](#Inputs) for more options***


## Example
```terraform
module "k3s-ext" {
   source                       = "deyaeddin/k3s-ext/hcloud"
   version                      = "0.0.1"
   cloud_flare_api_email        = "<Cloudflare primary email :: leave empty if you are using Hetzner>"
   cloud_flare_api_key          = "<Cloudflare api key :: leave empty if you are using Hetzner>"
   cloud_flare_api_token        = "<Cloudflare api token :: leave empty if you are using Hetzner>"
   default_domain               = "example.com"
   hcloud_dns_api_token         = "<hetzner DNS api token :: leave empty if you are using Cloudflare>"
   hcloud_masters_extra_scripts = []
   hcloud_node_extra_scripts    = []
   hcloud_token                 = "<Hetzner Cloud api token>"
   issuer_email                 = "deya@yanax.com"
   enable_apps                  = true

   //optional
   k3s_version                  = "v1.21.1+k3s1" //"v1.19.11+k3s1" "v1.20.7+k3s1" "v1.21.1+k3s1"
   master_groups_type           = "cx21"         # 2 vCPU, 4 GB RAM, 40 GB Disk space
   master_groups_count          = 3              // Odd number for HA enabled
   node_groups = {                               // NOTE: pass emtpy map to use a single master
      "cx21" = 4
      "cpx11" = 2
   }
}
```

## Requirements to init/plan/apply
Required libraries to be installed before running the module:
 - [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
 - [helm](https://helm.sh/docs/intro/install/)
 - [terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
 - [jq](https://stedolan.github.io/jq/download/) 
 - [graphviz](https://graphviz.org/download/) (optional)
 - [terraform-docs](https://github.com/terraform-docs/terraform-docs) (optional)
 - [shellspec](https://shellspec.info/) (optional)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |
| <a name="requirement_hcloud"></a> [hcloud](#requirement\_hcloud) | >= 1.47.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.14.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.2.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 2.5.1 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 3.2.2 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.6.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_hcloud"></a> [hcloud](#provider\_hcloud) | >= 1.47.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_apps"></a> [apps](#module\_apps) | ./modules/apps | n/a |
| <a name="module_hcloud"></a> [hcloud](#module\_hcloud) | ./modules/hcloud | n/a |

## Resources

| Name | Type |
|------|------|
| [hcloud_ssh_key.default](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/ssh_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cert_manager_solver_type"></a> [cert\_manager\_solver\_type](#input\_cert\_manager\_solver\_type) | which solver cert-manger will use, values : HTTP01, DNS01\_CLOUDFLARE, DNS01\_HETZNER | `string` | `"HTTP01"` | no |
| <a name="input_cloud_flare_api_email"></a> [cloud\_flare\_api\_email](#input\_cloud\_flare\_api\_email) | Cloudflare primary email (login email) | `any` | n/a | yes |
| <a name="input_cloud_flare_api_key"></a> [cloud\_flare\_api\_key](#input\_cloud\_flare\_api\_key) | Cloudflare api key.  Ref: https://dash.cloudflare.com/profile/api-tokens | `any` | n/a | yes |
| <a name="input_cloud_flare_api_proxied"></a> [cloud\_flare\_api\_proxied](#input\_cloud\_flare\_api\_proxied) | wither the zone will be proxied on cloudflare | `bool` | `false` | no |
| <a name="input_cloud_flare_api_token"></a> [cloud\_flare\_api\_token](#input\_cloud\_flare\_api\_token) | Cloudflare api token. Ref: https://dash.cloudflare.com/profile/api-tokens | `any` | n/a | yes |
| <a name="input_cluster_issuer_name"></a> [cluster\_issuer\_name](#input\_cluster\_issuer\_name) | name for cert-manager cluster issuer | `string` | `"letsencrypt"` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Cluster name (prefix for all resource names) | `string` | `"my-cluster"` | no |
| <a name="input_default_backend_image_digest"></a> [default\_backend\_image\_digest](#input\_default\_backend\_image\_digest) | default backend image digest | `string` | `""` | no |
| <a name="input_default_backend_image_registry"></a> [default\_backend\_image\_registry](#input\_default\_backend\_image\_registry) | default backend image registry | `string` | `"docker.io"` | no |
| <a name="input_default_backend_image_repository"></a> [default\_backend\_image\_repository](#input\_default\_backend\_image\_repository) | default backend image repository e.g. bitnami/nginx | `string` | `"bitnami/nginx"` | no |
| <a name="input_default_backend_image_tag"></a> [default\_backend\_image\_tag](#input\_default\_backend\_image\_tag) | default backend image tag e.g. 1.27.0-debian-12-r1 | `string` | `"1.27.0-debian-12-r1"` | no |
| <a name="input_default_domain"></a> [default\_domain](#input\_default\_domain) | root domain for ingress default service | `any` | n/a | yes |
| <a name="input_default_namespace"></a> [default\_namespace](#input\_default\_namespace) | default applications namespace | `string` | `"apps"` | no |
| <a name="input_dns_provider"></a> [dns\_provider](#input\_dns\_provider) | DNS provider to use. Values can be hetzner or cloudflare | `string` | `"hetzner"` | no |
| <a name="input_enable_apps"></a> [enable\_apps](#input\_enable\_apps) | wither to enable deploying cert-manager, nginx-ingress-controller ...etc | `bool` | `false` | no |
| <a name="input_hcloud_datacenter"></a> [hcloud\_datacenter](#input\_hcloud\_datacenter) | Hetzner datacenter where resources resides, hel1-dc2 (Helsinki 1 DC 2) or fsn1-dc14 (Falkenstein 1 DC14) | `string` | `"hel1-dc2"` | no |
| <a name="input_hcloud_dns_api_token"></a> [hcloud\_dns\_api\_token](#input\_hcloud\_dns\_api\_token) | hashed Hetzner DNS access token | `any` | n/a | yes |
| <a name="input_hcloud_masters_extra_scripts"></a> [hcloud\_masters\_extra\_scripts](#input\_hcloud\_masters\_extra\_scripts) | Additional list of commands to be added to initial master server creation | `list(string)` | n/a | yes |
| <a name="input_hcloud_network_ip_range"></a> [hcloud\_network\_ip\_range](#input\_hcloud\_network\_ip\_range) | ip\_range of the main network | `string` | `"10.0.0.0/8"` | no |
| <a name="input_hcloud_network_subnet_ip_range"></a> [hcloud\_network\_subnet\_ip\_range](#input\_hcloud\_network\_subnet\_ip\_range) | ip\_range of the subnetwork | `string` | `"10.0.0.0/16"` | no |
| <a name="input_hcloud_network_subnet_type"></a> [hcloud\_network\_subnet\_type](#input\_hcloud\_network\_subnet\_type) | subnet type | `string` | `"cloud"` | no |
| <a name="input_hcloud_network_subnet_zone"></a> [hcloud\_network\_subnet\_zone](#input\_hcloud\_network\_subnet\_zone) | Subnet Zon | `string` | `"eu-central"` | no |
| <a name="input_hcloud_node_extra_scripts"></a> [hcloud\_node\_extra\_scripts](#input\_hcloud\_node\_extra\_scripts) | Additional list of commands to be added to initial node server creation | `list(string)` | n/a | yes |
| <a name="input_hcloud_token"></a> [hcloud\_token](#input\_hcloud\_token) | Hetzner cloud auth token | `any` | n/a | yes |
| <a name="input_image"></a> [image](#input\_image) | Node boot image | `string` | `"ubuntu-24.04"` | no |
| <a name="input_issuer_email"></a> [issuer\_email](#input\_issuer\_email) | email for issuing certificates with LetsEncrypt | `any` | n/a | yes |
| <a name="input_k3s_channel"></a> [k3s\_channel](#input\_k3s\_channel) | k3s channel (stable, latest, v1.19 and so on) | `string` | `"latest"` | no |
| <a name="input_k3s_config_file"></a> [k3s\_config\_file](#input\_k3s\_config\_file) | String path to config file | `string` | `"~/.kubeconfig/hetzner.config"` | no |
| <a name="input_k3s_version"></a> [k3s\_version](#input\_k3s\_version) | k3s version (v1.21.0+k3s1, v1.19.10+k3s1 and so on) | `string` | `"v1.30.1+k3s1"` | no |
| <a name="input_lb_hcloud_location"></a> [lb\_hcloud\_location](#input\_lb\_hcloud\_location) | location of the loadbalancer | `string` | `"hel1"` | no |
| <a name="input_lb_hcloud_name"></a> [lb\_hcloud\_name](#input\_lb\_hcloud\_name) | name of the loadbalancer | `string` | `"name_cluster_lb"` | no |
| <a name="input_lb_hcloud_protocol"></a> [lb\_hcloud\_protocol](#input\_lb\_hcloud\_protocol) | protocol for the loadbalancer | `string` | `"tcp"` | no |
| <a name="input_letsencrypt_is_prod"></a> [letsencrypt\_is\_prod](#input\_letsencrypt\_is\_prod) | wither to utilize the staging or production for Letsencrypt certificates issuing | `bool` | `false` | no |
| <a name="input_master_groups_count"></a> [master\_groups\_count](#input\_master\_groups\_count) | Number of control plane nodes. | `number` | `1` | no |
| <a name="input_master_groups_type"></a> [master\_groups\_type](#input\_master\_groups\_type) | Node type (size) | `string` | `"cx22"` | no |
| <a name="input_nginx_default_backend"></a> [nginx\_default\_backend](#input\_nginx\_default\_backend) | nginx ingress controller default backend service name | `string` | `"default-backend"` | no |
| <a name="input_node_groups"></a> [node\_groups](#input\_node\_groups) | Map of worker node groups, key is server\_type, value is count of nodes in group. NOTE: pass emtpy map to use a single master | `map(string)` | <pre>{<br>  "cx22": 2,<br>  "cx32": 1<br>}</pre> | no |
| <a name="input_private_key_path"></a> [private\_key\_path](#input\_private\_key\_path) | string path to private key which will be used to access all the servers including the nodes | `string` | `"~/.ssh/id_rsa"` | no |
| <a name="input_public_key_path"></a> [public\_key\_path](#input\_public\_key\_path) | string path to public key which will be used to access all the servers including the nodes | `string` | `"~/.ssh/id_rsa.pub"` | no |
| <a name="input_storage_class"></a> [storage\_class](#input\_storage\_class) | storage class to use with minio drivers | `string` | `"hcloud-volumes"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_master_internal_ipv4"></a> [master\_internal\_ipv4](#output\_master\_internal\_ipv4) | Private IP Address of the master node |
| <a name="output_master_ipv4"></a> [master\_ipv4](#output\_master\_ipv4) | Public IP Address of the master node |
| <a name="output_master_nodes_internal_ipv4"></a> [master\_nodes\_internal\_ipv4](#output\_master\_nodes\_internal\_ipv4) | Public IP Address of the master nodes in groups |
| <a name="output_master_nodes_ipv4"></a> [master\_nodes\_ipv4](#output\_master\_nodes\_ipv4) | Public IP Address of the master nodes in groups |
| <a name="output_nodes_ipv4"></a> [nodes\_ipv4](#output\_nodes\_ipv4) | Public IP Address of the worker nodes in groups |