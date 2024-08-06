<%!
    title_ = 'Starting a python project'
    date_ = '2024-07-31'
    enable_codesnippets_ = True
    enable_lang_bash_ = True
    enable_lang_python_ = True
%>
<%inherit file="article.mako" />
<%namespace name="bflib" file="bflib.mako" />
<%block name="summary">
    Unable to find a suitable alternative ecosystem despite searching very hard, I started a new python project. I navigated choices around package management, directory structure, and unit testing.
</%block>
<%block name="article">
    <p>I documented my process setting up the project <code>myproject</code> as a sequence of instructions. Note though that many different or better choices may exist at each step.</p>

    <h2>Installation and virtual environment</h2>
    <p>For PopOS, install python-related packages with <code>apt</code> if necessary. To avoid conflicts with other locally run python projects that may require different versions of the same PyPI dependencies, set up a virtual environment.</p>
    <%bflib:codesnippet lang="bash">
# Install python
sudo apt install python3-pip

# Support starting python with the 'python' command
sudo apt install python-is-python3

# Python dependency manager
sudo apt install python3-pip

# Python virtual environment management tool
sudo apt install python3-venv

# Optionally make a new directory
mkdir ~/.venvs

# Create a virtual environment for the project
python -m venv ~/.venvs/myproject
    </%bflib:codesnippet>
    <p>Before working with <code>myproject</code> activate the project's virtual envornmnent. The appearance of the name of the virtual environment in the prompt indicates that subsequent commands will run in the context of the virtual environment. After working with <code>myproject</code> deactivate its virtual environment.</p>
    <%bflib:codesnippet lang="bash">
# Activate the virtual environment
source ~/.venvs/myproject/bin/activate

# Deactivate the virtual environment
deactivate
    </%bflib:codesnippet>
    <p>Activate the virtual environment if not already activated.</p>

    <h2>PyPI dependencies</h2>
    <p>Create a directory to house <code>myproject</code> and navigate there. Optionally make the directory a <code>git</code> repository. List all the <code>myproject</code> dependencies and their versions in a file called <code>requirements.txt</code> in the top level of the repository.</p>
    <%bflib:codesnippet title="myproject/requirements.txt" lang="text" file="code/python-project/requirements"/>
    <p>Note the <code>pytest</code> dependency. Be sure to include <code>pytest</code> to follow along with the unit testing section. All the other dependencies are for example purposes. Install the dependencies all at once into the virtual environment using <code>pip</code>. This approach allows others to easily start using <code>myproject</code> too.</p>
    <%bflib:codesnippet lang="bash">
python -m pip install -r requirements.txt
    </%bflib:codesnippet>

    <h2>Directory structure</h2>
    <p>Create a directory called <code>myproject</code> to house the project's source code - even if the project directory is already called <code>myproject</code> create another <code>myproject</code> directory inside it. Naming this new directory <code>myproject</code> will cause the <code>pip</code> package to be named after the project too. Thus the imports will be more intuitive, especially in the unit tests which live externally to the package. Add <code>demo.py</code> to the new <code>myproject</code> directory.</p>
    <%bflib:codesnippet title="myproject/myproject/demo.py" lang="python" file="code/python-project/demo"/>
    <p>Back in the top level directory create a directory called <code>tests</code>. Inside the new directory create a file called <code>test_demo.py</code>. Note at this stage the import is broken because <code>tests</code> can only see subpackages.</p>
    <%bflib:codesnippet title="myproject/tests/test_demo.py" lang="python" file="code/python-project/testdemo"/>
    <p>Back in the top level directory create a file called <code>setup.py</code>. This file helps <code>pip</code> make <code>myproject</code> into a package.</p>
    <%bflib:codesnippet title="myproject/setup.py" lang="python" file="code/python-project/setup"/>
    <p>Install <code>myproject</code> into the virtual environment as a package with <code>pip</code>. Subsequent changes to the source code of <code>myproject</code> automatically propagate to the installed package without needing to run <code>pip</code> again.</p>
    <%bflib:codesnippet lang="bash">
pip install -e .
    </%bflib:codesnippet>

    <h2>Useful commands</h2>
    <p>That completes the setup of the demo project. Optionally interact with the project using any of these commands from the top level directory.</p>
    <%bflib:codesnippet lang="bash">
# Activate the virtual environment
source ~/.venvs/myproject/bin/activate

# Run the demo project
python ./myproject/demo.py

# Run the test suite
pytest ./tests

# Deactivate the virtual environment
deactivate
    </%bflib:codesnippet>

    <h2>Linter</h2>
    <p>I abandoned the idea of integrating a linter into the build process. It adds complication, and I expect only minimal participation by others. VSCode offers practical on-the-fly linter options intead.</p>
</%block>
<%block name="references">
    <%bflib:reference title="Joshua Phuong Le's guide to python project structure" url="https://python.plainenglish.io/a-practical-guide-to-python-project-structure-and-packaging-90c7f7a04f95">Recommendations about directory structure, packaging the project, and installing it as a package. Explains some available options at each step.</%bflib:reference>
    <%bflib:reference title="Reddit virtual environment discussion" url="https://www.reddit.com/r/pop_os/comments/1aj8uk0/installing_virtualenv_for_popos/">Thoughts on virtual environment packages and configuration in PopOS. Some reports of version-specific issues.</%bflib:reference>
    <%bflib:reference title="Martin Breuss's virtual environment primer" url="https://realpython.com/python-virtual-environments-a-primer/">How to work with virtual environments. Motivations for using virtual environments. Technical details about the internals of virtual environments.</%bflib:reference>
    <%bflib:reference title="VSCode Marketplace linters" url="https://code.visualstudio.com/docs/python/linting">Explains how python linters work in VSCode. Lists several Microsoft provided linters and several community provided linters to try.</%bflib:reference>
</%block>