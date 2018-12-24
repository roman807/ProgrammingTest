# Roman Moser, 12/23/18
# Command line tools programming test
# run with: bash ngrams.sh

cat corpus.txt | tr -s ' ' '\n' | sort | uniq -c | sort -n -r | head -n 50 | awk '{ print $2 }'
cat corpus.txt | tr -s ' ' '\n' | awk -- ' { print prev, $0 } { prev = $0 }' | sort |\
uniq -c | sort -n -r | head -n 50 | awk '{ print $2, $3}'

