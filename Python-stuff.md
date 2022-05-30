# Python page

While technically not Linux, I will commit this page to my Python tips and ticks anyway...

## Python Virtual environments

Check if python virtual environment is installed: ``virtualenv --version``

Install it: ``pip3 install virtualenv``

### Create a virtual environment

```
mkdir pythonscript
cd pythonscript
virtualenv venv
```

Start environment: 

```
source venv/bin/activate
```

Stop environment: `deactivate`

Environment packages will be installed in: ``pythonscript/venv/lib/python3.7/site-packages``

## Python Code distribution

### Share a project

To share your project so that others can work on it, take the following steps:

Call ``pip freeze > requirements.txt``. This command creates a requirements.txt file with all the packages that the program needs.

Create a ``.gitignore`` file, and check in your application code and requirements.txt.

Check in the code to GitHub.

### Consume a project

To consume a project as a contributor (a fellow developer), take the following steps:

- Fetch the project from GitHub.
- Create a virtual environment and place yourself in it.
- Restore the project by using ``pip install -r requirements.txt``. It will look for requirements.txt and fetch and install the packages listed for that file.
- Run your app.

## Clean up unused packages

### Clean up unused packages

Sometimes, you might realize that you no longer need a certain Python package and you want to remove it. For such a case, you can use pip uninstall:

Bash

```
Copy
pip uninstall python-dateutil
```

However, if you run pip freeze, you see how the preceding command removed only the python-dateutil library. This can be problematic, because your project now might contain many unused libraries that take up space. To clear out everything that this package depended on, you can use both commands like this:

Python

``` 
Copy
pip freeze > requirements.txt
pip uninstall -r requirements.txt -y
```

A better approach is to use the autoremove command:

Bash

```
Copy
pip install pip-autoremove
pip-autoremove python-dateutil -y
```

Now if you run pip freeze, you see that it contains only the following output:

Output

```
Copy
pip-autoremove==0.10.0
```
