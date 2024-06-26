#! /bin/sh

pip install -r requirements-test.txt

export OUTPUT_FOLDER="/data/$REPORTS_FOLDER"
mkdir -p $OUTPUT_FOLDER

echo "-------------------------------------------------------------------"
echo
echo "Running pylint"
echo
pylint -v $PYLINT_ARGS --load-plugins=pylint_json2html --output-format=jsonextended factors_flask.py > pylint.json
pylint-json2html -f jsonextended -o $OUTPUT_FOLDER/pylint.html pylint.json
echo "-------------------------------------------------------------------"
echo
echo "Running pytest"
echo
pytest -v --html=$OUTPUT_FOLDER/pytest_report.html --cov=factors_flask --cov-report annotate --cov-report html --disable-warnings
cp -r htmlcov $OUTPUT_FOLDER
