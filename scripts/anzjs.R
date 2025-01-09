flights <- read.csv("data/auckland-flights.csv")
flights$date <- as.Date(flights$date)

borderClosed <- as.Date("2020-03-20")
borderOpen <- as.Date("2022-07-31")
maxFlights <- max(flights$total)

title <- "Auckland Airport Traffic Statistics"

closedLabel <- format(borderClosed, "%b %Y")

openLabel <- format(borderOpen, "%b %Y")
maxLabel <- format(maxFlights, big.mark=",")

library(ggplot2)
library(gggrid)
gg <- ggplot(flights) +
    geom_line(aes(date, total)) +
    labs(title=title)

bubbleLabel <- "travel\nbubble"
bubbleX <- mean(c(borderClosed, borderOpen))
bubbleY <- 400000
t <- seq(0, 2*pi, length.out=100)

bubble <- function(data, coords) {
    line <- segmentsGrob(coords$x, coords$y, coords$x,
                         unit(.15, "npc"),
                         gp=gpar(col="white", lwd=2))
    label <- textGrob("travel\nbubble", 
                      x=coords$x, y=coords$y,
                      gp=gpar(col="grey"))
    oval <- polygonGrob(unit(coords$x, "npc") + 
                        .8*grobWidth(label)*cos(t),
                        unit(coords$y, "npc") +
                        .8*grobHeight(label)*sin(t),
                        gp=gpar(col=NA, fill="white"))
    grobTree(line, oval, label, vp=viewport(gp=gpar(lineheight=1)))
}

ggPlot <- gg + 
    coord_cartesian(clip="off") +
    scale_x_continuous(expand=expansion(0)) +
    scale_y_continuous(expand=expansion(0)) +
    theme(plot.margin=unit(c(4, 0, 4, 0), "mm"),
          plot.title=element_text(family="Impact", size=18),
          panel.background=element_blank(),
          axis.text=element_blank(),
          axis.title=element_blank(),
          axis.ticks=element_blank()) +
    annotate("rect", 
             xmin=borderClosed, xmax=borderOpen,
             ymin=0, ymax=maxFlights,
             colour=NA, fill="grey90") +
    annotate("segment", 
             x=borderClosed, xend=borderOpen,
             y=maxFlights, yend=maxFlights,
             linewidth=.05) +
    annotate("segment", 
             x=borderClosed, xend=borderOpen,
             y=0, yend=0,
             linewidth=.05) +
    annotate("text",
             label=closedLabel,
             x=borderClosed, y=0,
             hjust=0, vjust=1.1,
             colour="grey") +
    annotate("text",
             label=openLabel,
             x=borderOpen, y=0,
             hjust=1, vjust=1.1,
             colour="grey") +
    annotate("text",
             label=0,
             x=borderOpen, y=0,
             hjust=-.2, vjust=0,
             colour="grey") +
    annotate("text",
             label=maxLabel,
             x=borderOpen, y=maxFlights,
             hjust=-.02, vjust=1,
             colour="grey") +
    grid_panel(bubble, aes(x=bubbleX, y=bubbleY), data=flights[1,]) +
    geom_line(aes(date, total), linewidth=1)

label1 <- function(data, coords) {
    x1 <- coords$x[1]
    x2 <- coords$x[2]
    w <- convertWidth(unit(1 - x2, "npc") - unit(1, "mm"), "in")
    gap <- 15
    closeTeX <- r"(%
\fontsize{10}{12}
\selectfont
\begin{enumerate}
\item New Zealand closes its borders to {\it almost} all travellers at
{\bf 23:59, 19 March 2020 (NZDT)}.
\end{enumerate})"
    latex1 <- latexGrob(closeTeX,
                        x=unit(x1, "npc") - unit(2, "mm"), 
                        y=unit(0, "npc") - unit(gap, "mm") - unit(2, "mm"),
                        hjust=1, vjust=1,
                        width=w)
    openTeX <- r"(%
\fontsize{10}{12}
\selectfont
\begin{enumerate}\addtocounter{enumi}{1}
\item New Zealand's international border opens to all visitors from
{\bf 11:59PM, 31 July 2022 (NZDT)}.
\end{enumerate})"
    latex2 <- latexGrob(openTeX,
                        x=unit(x2, "npc") + unit(2, "mm"),
                        y=unit(0, "npc") - unit(gap, "mm") - unit(2, "mm"), 
                        hjust=0, vjust=1,
                        width=w)
    b1l <- unit(x1, "npc") - unit(w, "in")
    b1r <- unit(x1, "npc") + unit(0, "in")
    b1t <- unit(0, "npc") - unit(gap, "mm")
    b1b <- unit(0, "npc") - unit(gap, "mm") - unit(.85, "in")
    bracket1 <- grobTree(segmentsGrob(x1, unit(0, "npc") - unit(5, "mm"),
                                      x1, b1t),
                         segmentsGrob(b1l, b1t, b1r, b1t),
                         segmentsGrob(b1r, b1t, b1r, b1b),
                         segmentsGrob(b1l, b1t, b1l, b1t - unit(2, "mm")),
                         segmentsGrob(b1r, b1b, b1r - unit(2, "mm"), b1b))
    b2l <- unit(x2, "npc") + unit(0, "mm")
    b2r <- unit(x2, "npc") + unit(w, "in")
    b2t <- unit(0, "npc") - unit(gap, "mm")
    b2b <- unit(0, "npc") - unit(gap, "mm") - unit(.85, "in")
    bracket2 <- grobTree(segmentsGrob(x2, unit(0, "npc") - unit(5, "mm"), 
                                      x2, b2t),
                         segmentsGrob(b2l, b2t, b2r, b2t),
                         segmentsGrob(b2l, b2t, b2l, b2b),
                         segmentsGrob(b2r, b2t, b2r, b2t - unit(2, "mm")),
                         segmentsGrob(b2l, b2b, b2l + unit(2, "mm"), b2b))
    grobTree(bracket1, bracket2, latex1, latex2)
}

ggFinal <- ggPlot +
    grid_panel(label1,
               aes(x=borders),
               data=data.frame(borders=c(borderClosed, borderOpen)))

grid.newpage()
pushViewport(viewport(y=1, height=unit(3, "in"), just="top"))
print(ggFinal, newpage=FALSE)
popViewport()

