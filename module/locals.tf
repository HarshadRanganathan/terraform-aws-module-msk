locals {
  msk_tags = merge(
  var.tags, var.msk_tags,
  {
    Name = module.label.id
  }
  )
}