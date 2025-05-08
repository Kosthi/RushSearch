cd python_bindings
rm -rf build
python setup.py bdist_wheel
pip uninstall glassppy -y
cd dist
ls | xargs pip install
