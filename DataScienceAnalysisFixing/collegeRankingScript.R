TIMES_SCORE = read.csv("TIMES_SCORE.csv", encoding="UTF-8")
CWUR_SCORE = read.csv("CWUR_SCORE.csv", encoding="UTF-8")
TIMES_SCORE_CLEAN <- subset(TIMES_SCORE, CONTROL == "Public")
CWUR_SCORE_CLEAN <- subset(CWUR_SCORE, CONTROL == "Public")
require(ggplot2)
qplot(TIMES_SCORE_CLEAN$female_male_ratio, TIMES_SCORE_CLEAN$ADM_RATE_ALL)
qplot(CWUR_SCORE_CLEAN$national_rank, CWUR_SCORE_CLEAN$ADM_RATE_ALL)

reg = lm(CWUR_SCORE_CLEAN$ADM_RATE_ALL ~ CWUR_SCORE_CLEAN$world_rank)
plot(CWUR_SCORE_CLEAN$world_rank, CWUR_SCORE_CLEAN$ADM_RATE_ALL)
abline(v = 194, col = "red")
abline(h = 0.7861, col = "red")
abline(reg)

reg = lm(CWUR_SCORE_CLEAN$ADM_RATE_ALL, CWUR_SCORE_CLEAN$national_rank)
plot(CWUR_SCORE_CLEAN$national_rank, CWUR_SCORE_CLEAN$ADM_RATE_ALL)
abline(reg)

reg = lm(CWUR_SCORE_CLEAN$NPT4_PUB ~ CWUR_SCORE_CLEAN$world_rank)
plot(CWUR_SCORE_CLEAN$world_rank, CWUR_SCORE_CLEAN$NPT4_PUB)
abline(reg)

reg = lm(CWUR_SCORE_CLEAN$RET_FT4 ~ CWUR_SCORE_CLEAN$world_rank)
plot(CWUR_SCORE_CLEAN$world_rank, CWUR_SCORE_CLEAN$RET_FT4)
abline(reg)

#CWUR_SCORE$gt_25k_p6 = as.numeric(CWUR_SCORE$gt_25k_p6)
reg = lm(CWUR_SCORE_CLEAN$SATVR75 ~ CWUR_SCORE_CLEAN$world_rank)
plot(CWUR_SCORE_CLEAN$world_rank, CWUR_SCORE_CLEAN$SATVR75)
abline(reg)

reg = lm(CWUR_SCORE_CLEAN$SATVR75 ~ CWUR_SCORE_CLEAN$world_rank)
plot(CWUR_SCORE_CLEAN$world_rank, CWUR_SCORE_CLEAN$SATVR75)
abline(reg)

smoothScatter(CWUR_SCORE_CLEAN$national_rank, CWUR_SCORE_CLEAN$ADM_RATE_ALL)