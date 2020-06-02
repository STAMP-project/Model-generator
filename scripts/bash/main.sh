INPUT=inputs/inputs.csv
OLDIFS=$IFS
IFS=,
[ ! -f $INPUT ] && { echo "$INPUT file not found"; }
LIMIT=15

while read application package
do
	echo "application : $application"
	echo "package : $package"


  java -d64 -Xmx10000m -jar libs/model-generation.jar -project_cp "bins/$application" -project_prefix "$package" -out_dir "models/$application" > "logs/$application-out.txt" 2> "logs/$application-err.txt" &

  while (( $(pgrep -l java | wc -l) >= $LIMIT ))
    do
                sleep 1
    done
done < $INPUT