df=read.csv("C:\\Users\\Lenovo\\Desktop\\INT\\RDD project\\simulated_rdd_qrisk.csv")
df

summary(df)
table(df$Sex)
table(df$Assigned_Treatment)
table(df$MI_Event)

table(df$Assigned_Treatment, df$MI_Event)
prop.table(table(df$Assigned_Treatment, df$MI_Event), 1)  # row proportions

hist(df$QRISK_Score, main="Distribution of QRISK Scores", col="skyblue", xlab="QRISK Score")
abline(v = 10, col = "red", lwd = 2, lty = 2)


boxplot(QRISK_Score ~ Assigned_Treatment, data = df,
        names = c("No Statin", "Statin"),
        main = "QRISK by Treatment Group", col = c("orange", "green"))

barplot(prop.table(table(df$Assigned_Treatment, df$MI_Event), 1),
        beside = TRUE, col = c("lightpink", "lightblue"),
        legend = c("No MI", "MI"),
        names.arg = c("No Statin", "Statin"),
        main = "MI Proportions by Treatment")


library(rdrobust)
head(df)

# Basic model: MI_Event as outcome, QRISK as forcing variable, cutoff at 10
rd_result <- rdrobust(y = df$MI_Event, x = df$QRISK, c = 10)

# View results
summary(rd_result)

library(ggplot2)
rdplot(y = df$MI_Event, x = df$QRISK, c = 10,
       x.label = "QRISK Score", y.label = "MI Event Rate",
       title = "RDD Plot: MI vs QRISK at Threshold")

dev.off()

#____________________________________________________1. Bandwidth Sensitivity Analysis
# Narrower bandwidth (1)
a5=rdrobust(y = df$MI_Event, x = df$QRISK, c = 10, h = 1)
summary(a5)

# Wider bandwidth (3)
a6=rdrobust(y = df$MI_Event, x = df$QRISK, c = 10, h = 3)
summary(a6)


#___________________________________________________2. Polynomial Order Sensitivity : Robustness Check

# Define cutoff (same as in main RDD analysis)
cutoff <- 10

# Linear polynomial fit (p = 1)
rd_linear <- rdrobust(y = df$MI_Event, x = df$QRISK_Score, c = cutoff, p = 1)
summary(rd_linear)

# Quadratic polynomial fit (p = 2)
rd_quadratic <- rdrobust(y = df$MI_Event, x = df$QRISK_Score, c = cutoff, p = 2)
summary(rd_quadratic)

#___________________________________________________3. Placebo Test (Fake Cutoffs)
a3=rdrobust(y = df$MI_Event, x = df$QRISK, c = 8)
summary(a3)

a4=rdrobust(y = df$MI_Event, x = df$QRISK, c = 12)
summary(a4)

# RDD Plot at fake cutoff = 8
rdplot(y = df$MI_Event, x = df$QRISK_Score, c = 8,
       title = "Placebo Test at Cutoff 8",
       x.label = "QRISK", y.label = "MI Event")

# RDD Plot at fake cutoff = 12
rdplot(y = df$MI_Event, x = df$QRISK_Score, c = 12,
       title = "Placebo Test at Cutoff 12",
       x.label = "QRISK", y.label = "MI Event")

#__________________________________________________4. Covariate Balance Test
# Example for Age (replace with your variable)
a1=rdrobust(y = df$Age, x = df$QRISK, c = 10)
summary(a1)

# Covariate Balance Test for SEX (Binary: 0/1)
df$Sex_numeric <- ifelse(df$Sex == "Male", 1, 0)
a2=rdrobust(y = df$Sex_numeric, x = df$QRISK, c = 10)
summary(a2)

# _____________________Visualizing Covariate Balance: Age

library(ggplot2)
ggplot(df, aes(x = QRISK_Score, y = Age)) +
  geom_point(alpha = 0.5) +
  geom_vline(xintercept = 10, linetype = "dashed", color = "red") +
  geom_smooth(data = df[df$QRISK < 10, ], method = "lm", se = FALSE, color = "blue") +
  geom_smooth(data = df[df$QRISK >= 10, ], method = "lm", se = FALSE, color = "green") +
  labs(title = "Covariate Balance Check – Age by QRISK",
       x = "QRISK Score", y = "Age")

#_____________________ Visualizing Covariate Balance: Gender

library(dplyr)
# Step 1: Create a variable indicating Left or Right of Threshold
df$QRISK_Group <- ifelse(df$QRISK_Score< 10, "Left of Cutoff", "Right of Cutoff")

# Step 2: Calculate proportion of males in each group
sex_prop <- df %>%
  group_by(QRISK_Group) %>%
  summarise(Proportion_Male = mean(Sex_numeric, na.rm = TRUE))

# Step 3: Barplot of male proportion on each side of the cutoff
ggplot(sex_prop, aes(x = QRISK_Group, y = Proportion_Male, fill = QRISK_Group)) +
  geom_col(width = 0.5) +
  ylim(0, 1) +
  labs(title = "Proportion of Males on Either Side of QRISK Threshold",
       x = "QRISK Group (Cutoff at 10)",
       y = "Proportion Male") +
  theme_minimal() +
  theme(legend.position = "none")

#____________________________________________________5. McCrary density test
# install.packages("rddensity")

library(rddensity)

cutoff <- 10

# McCrary density test
dens_test <- rddensity(X = df$QRISK_Score, c = cutoff)

# Summary
summary(dens_test)

# Density plot (correct usage)
rdplotdensity(rdd = dens_test, X = df$QRISK_Score)

