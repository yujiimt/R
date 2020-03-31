library(tidyverse)

g <- ggplot()

g + geom_histogram(data = mpg, mapping = aes(x = displ))
g + geom_density(data = mpg, mapping = aes(x = displ))


g + geom_point(data = mpg, mapping = aes(x = displ, y = cty))


g + geom_point(data = mpg, mapping = aes(x = displ, y = cty)) + geom_smooth(data = mpg, mapping = aes(x = displ, y = cty), method = 'lm')

ggplot(data = mpg, mapping = aes(x = displ, y = cty)) + geom_point() + geom_smooth(method = 'lm')

mpg1999 <- filter(mpg, year == 1999)
mpg2008 <- filter(mpg, year == 2008)

ggplot(mapping = aes(x = displ, y = cty)) + geom_point(data = mpg1999) + geom_point(data = mpg2008)


ggplot(data = mpg, mapping = aes(x = displ, y = cty, group = cyl, colour = cyl)) + geom_point()
ggplot(data = mpg, mapping = aes(x = displ, y = cty, group = factor(cyl), colour = factor(cyl))) + geom_point()



ggplot(data = mpg, mapping = aes(x = displ, y = cty)) + geom_point() + geom_smooth(mapping = aes(group = factor(cyl), colour = factor(cyl)), method = 'lm')
ggplot(data = mpg, mapping = aes(x = displ, y = cty)) + geom_point() + geom_smooth(mapping = aes(group = factor(cyl)), method = 'lm')                                                                                  


ggplot(data = mpg, mapping = aes(x = displ, y = cty)) + geom_point(mapping = aes(colour = factor(cyl), shape = factor(cyl)))
ggplot(data = mpg, mapping = aes(x = displ, y = cty)) + geom_point() + geom_smooth(mapping = aes(colour = factor(year), linetype = factor(year)), method = 'lm')

# 色(colour), 形状(shape), 大きさ(size), 透過度(alpha)
ggplot(data = mpg, mapping = aes(x = displ, y = cty, colour = factor(cyl))) + geom_point(shape = 17, size = 4, alpha = 0.4)
ggplot(data = mpg, mapping = aes(x = displ, y = cty)) + geom_point(colour = 'chocolate', shape = 35, size = 10) + geom_smooth(method = 'lm', linetype = 'dashed', se = FALSE)


add_x <- c(2.5, 3, 3.5)
add_y <- c(25, 27.5, 30)

ggplot(data = mpg, mapping = aes(x = displ, y = cty)) + geom_point() + 
  annotate(geom = 'point', x = add_x, y = add_y, colour = 'red') + 
  annotate(geom = 'text', x = c(5,5), y = c(30, 25), label = c('要チェック!', '赤色のデータを追加'))


#facetで画面を分割
#左図 : facet_wrap()

ggplot(data = mpg, mapping = aes(x =displ, y = cty)) + 
  geom_point() +
  facet_wrap(~ cyl)

# 中央
ggplot(data = mpg, mapping = aes(x =displ, y = cty)) + 
  geom_point() +
  facet_grid(. ~ cyl)

# 右図 縦並び
ggplot(data = mpg, mapping = aes(x = displ, y = cty)) +
  geom_point() +
  facet_grid(cyl ~ .)


ggplot(data = mpg, mapping = aes(x = displ, y = cty)) +
  geom_point() +
  facet_wrap(year ~ cyl)

ggplot(data = mpg, mapping = aes(x = displ, y = cty)) +
  geom_point() + 
  facet_grid(year ~ cyl)


mean_cty <- mpg %>% 
  group_by(class) %>% 
  summarise(cty = mean(cty))

ggplot(data = mean_cty, mapping = aes(x = class, y = cty)) +
  geom_bar(stat = 'identity')

ggplot(data = mpg, mapping = aes(x = class, y = cty)) +
  geom_bar(stat = 'summary', fun.y = 'mean')

ggplot(data = mpg, mapping = aes(x = class, y = cty)) +
  stat_summary(geom = 'bar', fun.y = 'mean')

ggplot(data = mpg, mapping = aes(x = class, y = cty)) +
  stat_summary(geom = 'pointrange', fun.y = 'mean',
               fun.ymax = 'max', fun.ymin = 'min')

mean_se(mpg$cty)



ggplot(data = mpg, mapping = aes(x = class, y = cty)) +
  stat_summary(geom = 'bar', fun.y = 'mean',
               fill = 'grey') +
  stat_summary(geom = 'pointrange', fun.data = 'mean_se')


ggplot(data = mpg, mapping = aes(x = factor(year), y = displ)) + 
  stat_summary(fun.y = 'mean', geom = 'line', group = 1)
