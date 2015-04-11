library(ggplot2)

langs = read.csv("langs.csv")

langs$bytes <- langs$bytes/80
langs <- transform(langs, lang = reorder(lang, bytes))
langs <- subset(langs, langs$bytes > 100)


png("lang.png", res=100)
g <- ggplot(langs, aes(x=lang, y=bytes, fill=lang)) +
    geom_bar(colour="black", stat="identity") +
    guides(fill=F) +
    labs(x="", y="Lines of Code") +
    scale_fill_brewer() +
    coord_flip()
print(g)
dev.off()
