TIMES_SCORE = read.csv("TIMES_SCORE.csv", encoding="UTF-8")
CWUR_SCORE = read.csv("CWUR_SCORE.csv", encoding="UTF-8")
require(ggplot2)
qplot(TIMES_SCORE$female_male_ratio, TIMES_SCORE$ADM_RATE_ALL)
qplot(CWUR_SCORE$national_rank, CWUR_SCORE$ADM_RATE_ALL)

reg = lm(CWUR_SCORE$ADM_RATE_ALL ~ CWUR_SCORE$world_rank)
plot(CWUR_SCORE$world_rank, CWUR_SCORE$ADM_RATE_ALL)
abline(v = 194, col = "red")
abline(h = 0.7861, col = "red")
abline(reg)

reg = lm(CWUR_SCORE$ADM_RATE_ALL, CWUR_SCORE$national_rank)
plot(CWUR_SCORE$national_rank, CWUR_SCORE$ADM_RATE_ALL)
abline(reg)

reg = lm(CWUR_SCORE$NPT4_PUB ~ CWUR_SCORE$world_rank)
plot(CWUR_SCORE$world_rank, CWUR_SCORE$NPT4_PUB)
abline(reg)

reg = lm(CWUR_SCORE$RET_FT4 ~ CWUR_SCORE$world_rank)
plot(CWUR_SCORE$world_rank, CWUR_SCORE$RET_FT4)
abline(reg)

#CWUR_SCORE$gt_25k_p6 = as.numeric(CWUR_SCORE$gt_25k_p6)
reg = lm(CWUR_SCORE$ACTCM75 ~ CWUR_SCORE$world_rank)
plot(CWUR_SCORE$world_rank, CWUR_SCORE$ACTCM75)
abline(reg)

smoothScatter(CWUR_SCORE$national_rank, CWUR_SCORE$ADM_RATE_ALL)