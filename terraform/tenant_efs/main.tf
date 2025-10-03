locals {
  enabled = module.this.enabled
}

module "efs" {
  source = "cloudposse/efs/aws"
  # Cloud Posse recommends pinning every module to a specific version
  version = "1.2.0"

  context = module.this.context

  name    = "efs-${module.this.context.tenant}"
  vpc_id  = var.vpc_id
  subnets = var.subnets
  #zone_id = [var.aws_route53_dns_zone_id]
  region = var.region

  allowed_security_group_ids = var.allowed_security_group_ids

  #transition_to_archive = ["AFTER_90_DAYS"] N/A with burstable throughput
  transition_to_ia = ["AFTER_30_DAYS"]
  #transition_to_primary_storage_class =
}

# resource "kubernetes_storage_class" "efs_storage_class" {
#   count = local.enabled ? 1 : 0
#   metadata {
#     name        = "efs-${module.this.context.tenant}"
#     annotations = { "Tenant" = "${module.this.context.tenant}" }
#   }
#   storage_provisioner = "efs.csi.aws.com"
#   reclaim_policy      = "Retain"
#   volume_binding_mode = "WaitForFirstConsumer"
#   parameters = {
#     provisioningMode = "efs-ap"
#     fileSystemId     = "${module.efs.id}"
#     directoryPerms   = "700"
#   }
#   allow_volume_expansion = true
#}

resource "helm_release" "efs_storage_class" {
  name       = "efs-storageclass-${module.this.context.tenant}"
  repository = "${path.module}/helm"
  chart      = "storageclass"
  atomic     = true
  set = [
    {
      name  = "tenant"
      value = module.this.context.tenant
    },
    {
      name  = "efsId"
      value = module.efs.id
    }
  ]
}
