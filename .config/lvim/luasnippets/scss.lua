return{
  s("mq",{
    t("@include m."), i(1), t("{"),
    t({ "", " " }), i(2),
    t({"","}"})
  }),

  s("imv", {
    t("@use 'base/variables' as v;")
  }),

  s("imm", {
    t("@use 'base/mixins' as m;")
  })
}
