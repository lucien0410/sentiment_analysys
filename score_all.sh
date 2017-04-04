###
### Description: Scoring script for all results for SemEval-2017 Task 4
### Author: Preslav Nakov
### Last modified: February 17, 2017
###

echo ...Scoring subtask A English...
find . -name "*-A-english.output" \
	 -exec perl _scripts/SemEval2017_task4_test_scorer_subtaskA.pl _scripts/SemEval2017_task4_subtaskA_test_english_gold.txt {} \; \
     | perl -p -e 's/^.+\/([^\/]+)\/[^\/]+\.output/$1/g' \
     | sort -r -n -k2 > _results/results-A-english.txt

cat _results/results-A-english.txt


echo ...Scoring subtask A Arabic...
find . -name "*-A-arabic.output" \
	 -exec perl _scripts/SemEval2017_task4_test_scorer_subtaskA.pl _scripts/SemEval2017_task4_subtaskA_test_arabic_gold.txt {} \; \
     | perl -p -e 's/^.+\/([^\/]+)\/[^\/]+\.output/$1/g' \
     | sort -r -n -k2 > _results/results-A-arabic.txt

cat _results/results-A-arabic.txt


echo ...Scoring subtask B English...
find . -name "*-B-english.output" \
	 -exec perl _scripts/SemEval2017_task4_test_scorer_subtaskB.pl _scripts/SemEval2017_task4_subtaskB_test_english_gold.txt {} \; \
     | perl -p -e 's/^.+\/([^\/]+)\/[^\/]+\.output/$1/g' \
     | sort -r -n -k2 > _results/results-B-english.txt

cat _results/results-B-english.txt


echo ...Scoring subtask B Arabic...
find . -name "*-B-arabic.output" \
	 -exec perl _scripts/SemEval2017_task4_test_scorer_subtaskB.pl _scripts/SemEval2017_task4_subtaskB_test_arabic_gold.txt {} \; \
     | perl -p -e 's/^.+\/([^\/]+)\/[^\/]+\.output/$1/g' \
     | sort -r -n -k2 > _results/results-B-arabic.txt

cat _results/results-B-arabic.txt


echo ...Scoring subtask C English...
find . -name "*-C-english.output" \
	 -exec perl _scripts/SemEval2017_task4_test_scorer_subtaskC.pl _scripts/SemEval2017_task4_subtaskC_test_english_gold.txt {} \; \
     | perl -p -e 's/^.+\/([^\/]+)\/[^\/]+\.output/$1/g' \
     | sort -n -k2 > _results/results-C-english.txt

cat _results/results-C-english.txt



echo ...Scoring subtask C Arabic...
find . -name "*-C-arabic.output" \
	 -exec perl _scripts/SemEval2017_task4_test_scorer_subtaskC.pl _scripts/SemEval2017_task4_subtaskC_test_arabic_gold.txt {} \; \
     | perl -p -e 's/^.+\/([^\/]+)\/[^\/]+\.output/$1/g' \
     | sort -n -k2 > _results/results-C-arabic.txt

cat _results/results-C-arabic.txt


echo ...Scoring subtask D English...
find . -name "*-D-english.output" \
	 -exec perl _scripts/SemEval2017_task4_test_scorer_subtaskD.pl _scripts/SemEval2017_task4_subtaskD_test_english_gold.txt {} \; \
     | perl -p -e 's/^.+\/([^\/]+)\/[^\/]+\.output/$1/g' \
     | sort -n -k2 > _results/results-D-english.txt

cat _results/results-D-english.txt


echo ...Scoring subtask D Arabic...
find . -name "*-D-arabic.output" \
	 -exec perl _scripts/SemEval2017_task4_test_scorer_subtaskD.pl _scripts/SemEval2017_task4_subtaskD_test_arabic_gold.txt {} \; \
     | perl -p -e 's/^.+\/([^\/]+)\/[^\/]+\.output/$1/g' \
     | sort -n -k2 > _results/results-D-arabic.txt

cat _results/results-D-arabic.txt


echo ...Scoring subtask E English...
find . -name "*-E-english.output" \
	 -exec perl _scripts/SemEval2017_task4_test_scorer_subtaskE.pl _scripts/SemEval2017_task4_subtaskE_test_english_gold.txt {} \; \
     | perl -p -e 's/^.+\/([^\/]+)\/[^\/]+\.output/$1/g' \
     | sort -n -k2 > _results/results-E-english.txt

cat _results/results-E-english.txt


echo ...Scoring subtask E Arabic...
find . -name "*-E-arabic.output" \
	 -exec perl _scripts/SemEval2017_task4_test_scorer_subtaskE.pl _scripts/SemEval2017_task4_subtaskE_test_arabic_gold.txt {} \; \
     | perl -p -e 's/^.+\/([^\/]+)\/[^\/]+\.output/$1/g' \
     | sort -n -k2 > _results/results-E-arabic.txt

cat _results/results-E-arabic.txt


cat _results/results-A-english.txt \
	| grep -v _baseline \
    | awk -v OFS='\t' '{ print $1, $2, $3, $4; }' \
	| sort -k4 -n -r | perl _scripts/number_column_k.pl -k 3 \
	| sort -k3 -n -r | perl _scripts/number_column_k.pl -k 2 \
	| sort -k2 -n -r | perl _scripts/number_column_k.pl -k 1 \
	| perl _scripts/make_latex_table_A.pl \
       > _results/results_subtask_A_english.tex

cat _results/results-A-arabic.txt \
	| grep -v _baseline \
    | awk -v OFS='\t' '{ print $1, $2, $3, $4; }' \
	| sort -k4 -n -r | perl _scripts/number_column_k.pl -k 3 \
	| sort -k3 -n -r | perl _scripts/number_column_k.pl -k 2 \
	| sort -k2 -n -r | perl _scripts/number_column_k.pl -k 1 \
	| perl _scripts/make_latex_table_A.pl \
       > _results/results_subtask_A_arabic.tex


cat _results/results-B-english.txt \
	| grep -v _baseline \
	| grep -v late \
    | awk -v OFS='\t' '{ print $1, $2, $3, $4; }' \
	| sort -k4 -n -r | perl _scripts/number_column_k.pl -k 3 \
	| sort -k3 -n -r | perl _scripts/number_column_k.pl -k 2 \
	| sort -k2 -n -r | perl _scripts/number_column_k.pl -k 1 \
	| perl _scripts/make_latex_table_B.pl \
       > _results/results_subtask_B_english.tex

cat _results/results-B-arabic.txt \
	| grep -v _baseline \
	| grep -v late \
    | awk -v OFS='\t' '{ print $1, $2, $3, $4; }' \
	| sort -k4 -n -r | perl _scripts/number_column_k.pl -k 3 \
	| sort -k3 -n -r | perl _scripts/number_column_k.pl -k 2 \
	| sort -k2 -n -r | perl _scripts/number_column_k.pl -k 1 \
	| perl _scripts/make_latex_table_B.pl \
       > _results/results_subtask_B_arabic.tex


cat _results/results-C-english.txt \
	| grep -v _baseline \
	| sort -k3 -n | perl _scripts/number_column_k.pl -k 2 \
	| sort -k2 -n | perl _scripts/number_column_k.pl -k 1 \
	| perl _scripts/make_latex_table_C.pl \
       > _results/results_subtask_C_english.tex

cat _results/results-C-arabic.txt \
	| grep -v _baseline \
	| sort -k3 -n | perl _scripts/number_column_k.pl -k 2 \
	| sort -k2 -n | perl _scripts/number_column_k.pl -k 1 \
	| perl _scripts/make_latex_table_C.pl \
       > _results/results_subtask_C_arabic.tex


cat _results/results-D-english.txt \
	| grep -v _baseline \
	| sort -k4 -n | perl _scripts/number_column_k.pl -k 3 \
	| sort -k3 -n | perl _scripts/number_column_k.pl -k 2 \
	| sort -k2 -n | perl _scripts/number_column_k.pl -k 1 \
	| perl _scripts/make_latex_table_D.pl \
       > _results/results_subtask_D_english.tex

cat _results/results-D-arabic.txt \
	| grep -v _baseline \
	| sort -k4 -n | perl _scripts/number_column_k.pl -k 3 \
	| sort -k3 -n | perl _scripts/number_column_k.pl -k 2 \
	| sort -k2 -n | perl _scripts/number_column_k.pl -k 1 \
	| perl _scripts/make_latex_table_D.pl \
       > _results/results_subtask_D_arabic.tex


cat _results/results-E-english.txt \
	| grep -v _baseline \
	| perl _scripts/make_latex_table_E.pl \
       > _results/results_subtask_E_english.tex

cat _results/results-E-arabic.txt \
	| grep -v _baseline \
	| perl _scripts/make_latex_table_E.pl \
       > _results/results_subtask_E_arabic.tex


find . -type d -exec perl _scripts/generate_bibtex.pl {} \; > _results/systems.bib
