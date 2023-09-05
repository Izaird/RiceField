return{
  s("im", {
    t({ "<picture>", ""}),
    t("  <source srcset=\""), i(1), t(".avif"),
    t({ "\" type=\"image/avif\">", ""}),
    t("  <source srcset=\""), i(2), t(".webp"),
    t({ "\" type=\"image/webp\">", ""}),
    t("  <img loading=\"lazy\" width=\"200\" height=\"300\" src=\""), i(3), t(".jpg"),
    t("\" alt=\""), i(4), t({"\">"}),
    t({"", "</picture>"})
  })
}
