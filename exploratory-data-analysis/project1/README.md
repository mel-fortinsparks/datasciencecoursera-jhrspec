# Exploratory Data Analysis Project #1

This project asks us to create four plots mimicking those provided. I didn't fork the existing repository because it messes with how I manage my repositories. I haven't the wherewithal to deal with nesting it as desired.

## Creating the Plots

Our overall goal here is simply to examine how household energy usage varies over a 2-day period in February, 2007. Your task is to reconstruct the following plots below, all of which were constructed using the base plotting system.

~~First you will need to fork and clone the following GitHub repository: https://github.com/rdpeng/ExData_Plotting1~~

For each plot you should:

- Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
- Name each of the plot files as plot1.png, plot2.png, etc.
- Create a separate R code file (plot1.R, plot2.R, etc.) that constructs the corresponding plot, i.e. code in plot1.R constructs the plot1.png plot. Your code file should include code for reading the data so that the plot can be fully reproduced. You must also include the code that creates the PNG file.
- Add the PNG file and R code file to the top-level folder of your git repository (no need for separate sub-folders)
- When you are finished with the assignment, push your git repository to GitHub so that the GitHub version of your repository is up to date. There should be four PNG files and four R code files, a total of eight files in the top-level folder of the repo.

The four plots that you will need to construct are shown below.
```
Plot 1: ["Global Active Power" bar plot; global active power (in kilowatts) vs frequency]
Plot 2: [line plot; global active power over two days (thursday through friday)]
Plot 3: [line plot?; sub metering plot over two days (thursday through friday)]
Plot 4: [2x2 par Plot 2, voltage over 2 days, Plot 3, global reactive power over two days]
```

## Loading the data:
- The dataset has 2,075,259 rows and 9 columns. First calculate a rough estimate of how much memory the dataset will require in memory before reading into R. Make sure your computer has enough memory (most modern computers should be fine).
- We will only be using data from the dates 2007-02-01 and 2007-02-02. One alternative is to read the data from just those dates rather than reading in the entire dataset and subsetting to those dates.
- You may find it useful to convert the Date and Time variables to Date/Time classes in R using the strptime() and as.Date() functions.
- Note that in this dataset missing values are coded as ?.



## As a grader:

#### Criteria
1. Was a valid GitHub URL containing a git repository submitted?
2. Does the GitHub repository contain at least one commit beyond the original fork?
3. Please examine the plot files in the GitHub repository. Do the plot files appear to be of the correct graphics file format?
4. Does each plot appear correct?
5. Does each set of R code appear to create the reference plot?
6. Reviewing the Assignments

Keep in mind this course is about exploratory graphs, understanding the data, and developing strategies. Here's a good quote from a swirl lesson about exploratory graphs: "They help us find patterns in data and understand its properties. They suggest modeling strategies and help to debug analyses. We DON'T use exploratory graphs to communicate results."

The rubrics should always be interpreted in that context.

As you do your evaluation, please keep an open mind and focus on the positive. The goal is not to deduct points over small deviations from the requirements or for legitimate differences in implementation styles, etc. Look for ways to give points when it's clear that the submitter has given a good faith effort to do the project, and when it's likely that they've succeeded. Most importantly, it's okay if a person did something differently from the way that you did it. The point is not to see if someone managed to match your way of doing things, but to see if someone objectively accomplished the task at hand.

To that end, keep the following things in mind:

## DO: 
- Review the source code.
- Keep an open mind and focus on the positive.
- When in doubt, err on the side of giving too many points, rather than giving too few.
- Ask yourself if a plot might answer a question for the person who created it.
- Remember that not everyone has the same statistical background and knowledge.

## DON'T:
- Deduct just because you disagree with someone's statistical methods.
- Deduct just because you disagree with someone's plotting methods.
- Deduct based on aesthetics.
