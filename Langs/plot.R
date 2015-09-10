library(ggplot2)
library(grid)
library(RColorBrewer)

# Load data
langs <- read.csv("langs.csv", stringsAsFactors=F)
langs$bytes <- langs$bytes/80
langs <- subset(langs,
    !(lang %in% c("Matlab", "CoffeeScript", "Makefile", "VimL", "Mako")) & langs$bytes > 100)
langs <- langs[order(-langs$bytes),]

# Ordering for the plot
langs$lang <- factor(langs$lang, langs$lang)

a <- (0.32 * 11.69)/1.2

# png("lang1.png", width=a, height=2, units="in", res=550)
pdf("lang1.pdf", width=a, height=2)
g <- ggplot(langs, aes(x=lang, y=bytes, fill=lang)) +
    geom_bar(colour="black", stat="identity") +
    guides(fill=F) +
    labs(x="", y="Lines of Code") +
    scale_fill_manual(values = rev(brewer.pal(length(langs$lang),"Blues"))) +
    coord_flip() +
    theme_bw() +
    theme(axis.ticks = element_blank(),
        panel.border = element_blank(),
        # panel.grid.major.y = element_blank(),
        panel.grid.major = element_blank(),
        # panel.grid.major.x = element_line(colour = "grey93"),
        plot.margin=unit(c(0, 0, 0, 0),"mm"))+
    scale_y_continuous(expand=c(0.01, 0))
print(g)
dev.off()
