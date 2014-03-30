---
layout: post
title: Blog Post 2 - Barbara
description: this is my second blogpost exploring obesity data from the CDC
tags: blogpost
---
## Inspiration Graphic ##

For this post I initially went on a search for a pie chart that I could improve upon, and during the search, found [this article](http://www.theatlantic.com/magazine/archive/2014/04/why-rich-women-dont-get-fat/358643). Their fourth graph is a pie chart and my plan was to try and improve upon that, but then I spent a little bit of time staring at the third graph, comparing obesity by income, and that one started to bother me more (all were ripe for improvement), and so I decided to tackle that one instead. Here were my main issues:

1. They are comparing obesity by income, but don't define their income scale at all, simply labeling it "richer" and "poorer". 
2. I thought the scales they provided and layout of the graph made it very difficult to compare men vs. women, which was their stated purpose for creating the graph in the first place.
3. Once I took a look at the raw data, I realized that they seemed to remove certain data that didn't quite fit their narrative (given the lack of numbers, it was impossible to tell what they did for sure). This by far was the worst offense, and ended up masking something that I found more interesting.

My goal with this post was to come up with a graphic that would address those concerns and show the pattern that I saw when I explored the raw data.

## New (Hopefully Improved) Graphic ##

[New Obesity Graphic](http://bwelsh.github.io/edav/assets/d3obesity.html)

## Process ##

###Gathering Data###

I started by going to the CDC site as that was where the article indicated the data was obtained from. After poking around a bit, I found the pdf report that the data seemed to come from, located [here](http://www.cdc.gov/nchs/data/databriefs/db50.pdf). 

I realized that I only needed 36 numbers from the pdf (from figures 1 and 2 of the pdf), so I just manually created an array of objects to hold the data. What I noticed when I was gathering this data, was that the initial article seemed to leave out an entire income class (the middle one) in their graph. This is problematic because the overall pattern described, that women become thinner as their income rises and men become heavier, doesn't hold for all sexes and ethnicities. 

###Creating the Graphic

I started by finding a way to visualize this multi-level categorical data. I found [this site](http://www.jasondavies.com/parallel-sets), which offered two interesting ways to view the data. The first is the parallel sets chart displayed on the page, and the other is the [mosaic chart](http://www.theusrus.de/blog/understanding-mosaic-plots) linked to in the "Alternatives" section at the bottom of the page. I decided to go with the mosaic plot, after struggling with the parsets extension for too long, and used this [marimekko chart](http://bl.ocks.org/mbostock/1005090) as my template.

I built the normalized version (on the left) first, found the colors through the [color picker](http://tristen.ca/hcl-picker), and added the legend in the middle. I had to play with the template a little, as I was actually creating six of those charts. I also needed to mess with the axis ticks a bit and add axis labels to get the look I was going for. To me, the most interesting thing about this view of the data is that the pattern described in the initial article is very dependent on ethnicity. It holds much better for the non-hispanic black population then for the non-hispanic white population. Also, for the Mexican-American population, we do see the opposite relationship between income and obseity for men and women, but it only seems to take effect for the highest income levels.

I then wanted to visualize obesity in absolute terms, so created the graph on the right. I struggled a bit with whether this graphic was more helpful or more confusing, and it is difficult to compare the various areas, when the bars have different widths. Hovering over the bars does give the exact values, though, so in the end, I felt like it did still tell us some new things about the data, and decided it was worth keeping. The most interesting thing I found here, which was completely missing from the initial article, is that even among women, who have higher obesity rates at lower incomes, many more obese individuals are mid or high income, and not at the lowest income levels. 

The d3 code could still be refactored to make it cleaner and extensible to other data sets.
