p=$1
echo $p
paste test.id $1 > $p.out
perl _scripts/SemEval2017_task4_test_scorer_subtaskA.pl _scripts/SemEval2017_task4_subtaskA_test_english_gold.txt $p.out
