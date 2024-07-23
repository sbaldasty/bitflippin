<%!
    title_ = 'Maven project with cvc5 dependency'
    date_ = '2024-07-22'
    enable_codesnippets_ = True
%>
<%inherit file="article.mako" />
<%namespace name="bflib" file="bflib.mako" />
<%block name="summary">
    I built the latest stable <code>cvc5</code> from source on Ubuntu and added the Java API jar from that build to a maven project using a local maven repository.
</%block>
<%block name="article">
    <p>Ideally, one would install the latest <code>cvc5</code> libraries and binaries using their operating system's package manager. They would then add the latest <code>cvc5</code> Java API maven artifact from Maven Central as a dependency in their <code>pom.xml</code>. However the latest Linux packages and the latest maven artifact currently lag significantly behind. A less ideal manual process can bridge the gap.</p>

    <h2>References</h2>
    <ul>
    <li>
    <div><b><a href="https://github.com/AdaCore/cvc5">Github repository for cvc5</a></b></div>
    <div>High level overview of what <code>cvc5</code> is and does. Includes links to documentation, installation instructions, and the official website.</div>
    <li>
    <div><b><a href="https://cvc5.github.io/docs/cvc5-1.1.2/api/java/java.html">Building the Java API</a></b></div>
    <div>Official instructions on building the Java API from source and using it. This process deviates from the instructions after the install step.</div>
    <li>
    <div><b><a href="https://stackoverflow.com/questions/364114/can-i-add-jars-to-maven-2-build-classpath-without-installing-them">Adding jars without maven artifacts</a></b></div>
    <div>Members of stackoverflow discuss workarounds to adding jars to maven projects when the jars do not have associated maven artifacts.</div>
    <li>
    <div><b><a href="https://packages.ubuntu.com/source/mantic/cvc5">Debian package for cvc5</a></b></div>
    <div>Example of a <code>cvc5</code> package for a major Linux distribution, currently quite outdated.</div>
    <li>
    <div><b><a href="https://central.sonatype.com/artifact/io.github.p-org.solvers/cvc5">Maven artifact for cvc5</a></b></div>
    <div>Page for <code>cvc5</code> on the Maven Central Repository. The artifact currently lags behind the latest release unfortunately.</div>
    <li>
    <div><b><a href="https://stackoverflow.com/questions/1734207/how-to-set-java-library-path-for-processing">Overriding the Java library path</a></b></div>
    <div>Members of stackoverflow discuss how to override locations that Java checks for the libraries that bytecode needs to link to at runtime.</div>
    </ul>

    <h2>Building the cvc5 libraries and Java API</h2>
    <p>I get errors when I try to build <code>cvc5</code> with the latest version of Java. Probably worth trying again after time has passed, but meanwhile install an older version of Java and temporarily point <code>$JAVA_HOME</code> at it. Then follow the official build instructions.</p>
    <%bflib:codesnippet lang="bash">
# Install an old JDK compatible with cmake or cvc5 or whatever
sudo apt install openjdk-8-jdk

# Use this JDK for the cvc5 build process
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64

# Navigate to a parent directory into which to clone the repo
# Mostly doing this for clarity later on
cd ~/src

# Clone the cvc5 repo from github and build
git clone https://github.com/cvc5/cvc5
cd cvc5
./configure.sh production --java-bindings --auto-download --prefix=build/install
cd build
make
make install
    </%bflib:codesnippet>

    <h2>Including the Java API in a maven project</h2>
    <p>Assuming the existence of a maven project where the <code>package</code> goal is working, the next step is to create a local maven repository inside the project. If the project is a git repository, the local maven repository and the <code>cvc5</code> Java API jar it will contain will live alongside the project's source code in the git repository.</p>
    <p>Create the very precise directory structure the local maven repository requires to house the jar. Adjust the version number of the directory if necessary to match that of the jar. Copy the Java API deep inside the local repository. Add a <code>pom.xml</code> file alongside it. Paste into the <code>pom.xml</code> file the contents of the <b>Maven POM File</b> for <code>cvc5</code> from <a href="https://central.sonatype.com/artifact/io.github.p-org.solvers/cvc5">Maven Central</a>.</p>
    <%bflib:codesnippet lang="bash">
# Note the version number of the cvc5 artifact
ls ~/src/cvc5/build/install/share/java/cvc5

# Navigate to the maven project's directory
cd ~/mvnprj

# Create directory structure to house jar in local repo
mkdir -p libs/io/github/p-org/solvers/cvc5/1.1.0

# Copy the jar to the local repo
cp ~/src/cvc5/build/install/share/java/cvc5/cvc5-1.1.0.jar ~/mvnprj/libs/io/github/p-org/solvers/cvc5/1.1.0

# Paste content from Maven Central into this file
vim ~/mvnprj/libs/io/github/p-org/solvers/cvc5/1.1.0/pom.xml
    </%bflib:codesnippet>
    <p>The remaining work happens in the <code>pom.xml</code> file of the <i>project</i>. Tell maven about the new local repository by adding a <code>repository</code> block. Only include the enclosing <code>repositories</code> block if the project does not already contain one.</p>
    <%bflib:codesnippet lang="xml" file="code/cvc5-mvn-project/repository"/>
    <p>Add the new artifact to the project's dependencies by adding a <code>dependency</code> block. Only include the enclosing <code>dependencies</code> block of the project does not already contain one.</p>
    <%bflib:codesnippet lang="xml" file="code/cvc5-mvn-project/dependency"/>
    <p>At this point, the project should build. If it does, try pasting one of the <code>cvc5</code> examples into the main program and building again.</p>

    <h2>Running the project</h2>
    <p>The challenge around running the project is that the <code>cvc5</code> build process leaves the libraries that the Java API needs to link to in a place where Java can't see them. Find those libraries by navigating to <code>~/src/cvc5/build/install/lib</code>. Two options here:</p>
    <ol>
    <li>Copy the libraries to a standard location such as <code>/usr/lib</code> and run the project as usual. I have not tried this approach.
    <li>Leave the libraries alone but tell Java where they are.
    </ol>
    <%bflib:codesnippet lang="bash">
# If the libraries have been moved to a standard location
java -jar target/MyProject-1.0-SNAPSHOT-jar-with-dependencies.jar

# If the libraries have not been moved
java -Djava.library.path="/[Placeholder]/src/cvc5/build/install/lib" -jar target/MyProject-1.0-SNAPSHOT-jar-with-dependencies.jar
    </%bflib:codesnippet>
    <p>Be sure to replace the path to the project jar and the placeholder in the new library path appropriately. The library path must be an absolute path.</p>
</%block>