<%!
    title_ = 'Maven project with cvc5 dependency'
    date_ = '2024-07-22'
    enable_codesnippets_ = True
    enable_lang_bash_ = True
    enable_lang_xml_ = True
%>
<%inherit file="article.mako" />
<%namespace name="bflib" file="bflib.mako" />
<%block name="summary">
    I built the latest stable <code>cvc5</code> from source on Ubuntu and added the Java API jar from that build to a maven project using a local maven repository.
</%block>
<%block name="article">
    <p>Ideally, one would install the latest <code>cvc5</code> libraries and binaries using their operating system's package manager. They would then add the latest <code>cvc5</code> Java API maven artifact from Maven Central as a dependency in their <code>pom.xml</code>. However the latest Linux packages and the latest maven artifact currently lag significantly behind. A less ideal manual process can bridge the gap.</p>

    <h2>Building the cvc5 libraries and Java API</h2>
    <p>I get errors when I try to build <code>cvc5</code> with the latest version of Java. Probably worth trying again after time has passed, but meanwhile install an older version of Java and temporarily point <code>$JAVA_HOME</code> at it. Then follow the official build instructions.</p>
    <%bflib:codesnippet lang="bash">
# Install some build tools
sudo apt install cmake m4

# Install an old JDK compatible with cmake or cvc5 or whatever
sudo apt install openjdk-8-jdk

# Use this JDK for the cvc5 build process
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64

# Navigate to a parent directory into which to clone the repo
# Mostly doing this for clarity later on
cd /home/bob

# Clone the cvc5 repo from github
git clone https://github.com/cvc5/cvc5
cd cvc5

# Switch to latest stable branch
# Replace the version number if needed
git checkout cvc5-1.1.2

# Build the project and java bindings
./configure.sh production --java-bindings --auto-download --prefix=build/install
cd build
make
make install
    </%bflib:codesnippet>

    <h2>Including the Java API in a maven project</h2>
    <p>Assuming the existence of a maven project where the <code>package</code> goal is working, the next step is to create a local maven repository inside the project. If the project is a git repository, the local maven repository and the <code>cvc5</code> Java API jar it will contain will live alongside the project's source code in the git repository.</p>
    <p>Create the very precise directory structure the local maven repository requires to house the jar. Adjust the version number of the directory if necessary to match that of the jar. Copy the Java API deep inside the local repository. Add a <code>pom.xml</code> file alongside it. Paste into the <code>pom.xml</code> file the contents of the <b>Maven POM File</b> for <code>cvc5</code> from <a href="https://central.sonatype.com/artifact/io.github.p-org.solvers/cvc5">Maven Central</a>.</p>
    <%bflib:codesnippet lang="bash">
# Navigate to the maven project's directory
cd /home/bob/mvnprj

# Create directory structure to house jar in local repo
# Replace the version number if needed
mkdir -p libs/io/github/p-org/solvers/cvc5/1.1.2

# Copy the jar to the local repo
# Replace the version number if needed
cp /home/bob/cvc5/build/install/share/java/cvc5/cvc5-1.1.2.jar /home/bob/mvnprj/libs/io/github/p-org/solvers/cvc5/1.1.2

# Paste content from Maven Central into this file
vim ~/mvnprj/libs/io/github/p-org/solvers/cvc5/1.1.2/pom.xml
    </%bflib:codesnippet>
    <p>The remaining work happens in the <code>pom.xml</code> file of the <i>project</i>. Tell maven about the new local repository by adding a <code>repository</code> block. Only include the enclosing <code>repositories</code> block if the project does not already contain one.</p>
    <%bflib:codesnippet lang="xml" file="code/cvc5-mvn-project/repository"/>
    <p>Add the new artifact to the project's dependencies by adding a <code>dependency</code> block. Only include the enclosing <code>dependencies</code> block of the project does not already contain one.</p>
    <%bflib:codesnippet lang="xml" file="code/cvc5-mvn-project/dependency"/>
    <p>At this point, the project should build. If it does, try pasting one of the <code>cvc5</code> examples into the main program and building again.</p>

    <h2>Running the project</h2>
    <p>The challenge around running the project is that the <code>cvc5</code> build process leaves the libraries that the Java API needs to link to in a place where Java can't see them. Those libraries currently live in <code>/home/bob/cvc5/build/install/lib</code>. Two options here:</p>
    <ol>
    <li>Copy the libraries to a standard location such as <code>/usr/lib</code> and run the project as usual. I have not tried this approach.
    <li>Leave the libraries alone but tell Java where they are.
    </ol>
    <%bflib:codesnippet lang="bash">
# If the libraries have been moved to a standard location
java -jar target/MyProject-1.0-SNAPSHOT-jar-with-dependencies.jar

# If the libraries have not been moved
java -Djava.library.path="/home/bob/src/cvc5/build/install/lib" -jar target/MyProject-1.0-SNAPSHOT-jar-with-dependencies.jar
    </%bflib:codesnippet>
    <p>Be sure to replace the path to the project jar appropriately. The <code>java.library.path</code> must be an absolute path.</p>
    <h2>Onboarding other developers</h2>
    <p>The process is much simpler for other developers who want to work on the project. They only need the <code>cvc5</code> library files. They can build <code>cvc5</code> without the <code>--java-bindings</code> switch, without installing an older version of Java for compatibility. It might be possible to copy the compiled libraries to other machines and bypass building <code>cvc5</code> altogether, but I have not tried.</p>
</%block>
<%block name="references">
    <%bflib:reference title="Github repository for cvc5" url="https://github.com/cvc5/cvc5">High level overview of what <code>cvc5</code> is and does. Includes links to documentation, installation instructions, and the official website.</%bflib:reference>
    <%bflib:reference title="Building the Java API" url="https://cvc5.github.io/docs/cvc5-1.1.2/api/java/java.html">Official instructions on building the Java API from source and using it. This process deviates from the instructions after the install step.</%bflib:reference>
    <%bflib:reference title="Adding jars without maven artifacts" url="https://stackoverflow.com/questions/364114/can-i-add-jars-to-maven-2-build-classpath-without-installing-them">Members of stackoverflow discuss workarounds to adding jars to maven projects when the jars do not have associated maven artifacts.</%bflib:reference>
    <%bflib:reference title="Debian package for cvc5" url="https://packages.ubuntu.com/source/mantic/cvc5">Example of a <code>cvc5</code> package for a major Linux distribution, currently quite outdated.</%bflib:reference>
    <%bflib:reference title="Maven artifact for cvc5" url="https://central.sonatype.com/artifact/io.github.p-org.solvers/cvc5">Page for <code>cvc5</code> on the Maven Central Repository. The artifact currently lags behind the latest release unfortunately.</%bflib:reference>
    <%bflib:reference title="Overriding the Java library path" url="https://stackoverflow.com/questions/1734207/how-to-set-java-library-path-for-processing">Members of stackoverflow discuss how to override locations that Java checks for the libraries that bytecode needs to link to at runtime.</%bflib:reference>
</%block>