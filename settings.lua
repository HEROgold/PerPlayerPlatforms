str_to_bool={ ["true"]=true, ["false"]=false }


data:extend({
  {
    name = "spawn-on-platform",
    type = "bool-setting",
    setting_type = "runtime-per-user",
    default_value = true,
  },
  {
    name = "lock-platforms",
    type = "bool-setting",
    setting_type = "runtime-global",
    default_value = true,
  }
})
