<%!
    title_ = 'Automation script for VACC jobs'
    date_ = '2024-07-12'
    enable_codesnippets_ = True
    enable_lang_bash_ = True
%>
<%inherit file="article.mako" />
<%namespace name="bflib" file="bflib.mako" />
<%block name="summary">
    I wrote a script called <code>vaccjob</code> to automate the transfer, submission, monitoring, and output retrieval of jobs on UVM's in-house supercomputing cluster.
</%block>
<%block name="article">
    <h2>Password authentication</h2>
    <p>The VACC does not support public key authentication, only password authentication. One workaround to prompting for the UVM NetID password mid-script is to put the password in a local file and use the <code>sshpass</code> utility to feed the password to <code>ssh</code> or <code>scp</code>. Install <code>ssh</code> and <code>sshpass</code> if not installed already using the appropriate operating system specific process.</p>
    <%bflib:codesnippet lang="bash">
# Optionally create a directory for passwords
mkdir ~/.sshpasswds

# Put password in a file
vim ~/.sshpasswds/uvm

# Optionally lock down access somewhat
chmod 400 ~/.sshpasswds/uvm

# Install utilities (Arch Linux)
sudo pacman -S openssh sshpass
    </%bflib:codesnippet>

    <h2>Workflow</h2>
    <p>Bob the developer has UVM NetID <i>bobsnetid</i>, and a password saved in <code>~/.sshpasswds/uvm</code>. Bob writes a program he wants run on <code>bluemoon</code> on the VACC. The program and associated files are in the <code>~/src/vj</code> directory locally. The job script including any necesssary SLURM directives is <code>~/src/vj/job.sh</code> locally. Bob designed the program to save output files in the <code>~/remoteout</code> directory. Bob wants the to have any output in the <code>~/localout</code> directory locally when the job finishes. Bob runs</p>
    <%bflib:codesnippet lang="bash">
vaccjob bobsnetid ~/.sshpasswds/uvm ~/src/vj vj/job.sh remoteout ~/localout
    </%bflib:codesnippet>
    <p>Due to its length and cumbersome parameters, Bob may choose to save this line as a script of its own for easy reuse. In the happy path, <code>vaccjob</code> will</p>
    <ol>
    <li>Recursively copy <code>~/vj</code> to Bob's home directory on the VACC
    <li>Submit the job by running <code>~/vj/job.sh</code>
    <li>Create a file <code>~/.vaccjobid</code> locally containing the job ID
    <li>Poll the job status every 10 minutes until the job completes
    <li>Recursively copy <code>~/remoteout</code> from the VACC to <code>~/localout</code> on Bob's computer
    <li>Delete <code>~/.vaccjobid</code>
    </ol>
    <p>Bob may need to turn his computer off before his job finishes. Bob can then run <code>vaccjob</code> again later, whereupon <code>vaccjob</code> will notice that <code>~/.vaccjobid</code> already exists and skip straight to polling. If at any point an error occurs, <code>vaccjob</code> terminates immediately with a message.</p>

    <h2>Script</h2>
    <p>Here is the full <code>vaccjob</code> script in its current form. As always please exercise caution with code that interacts with third party systems, and with code that can potentially modify or delete data.</p>
    <%bflib:codesnippet title="vaccjob" lang="bash" file="code/vacc-script/vaccjob"/>

    <h2>Shortcomings</h2>
    <p>Sometimes a harmless error message about an undefined job id appears at the end. I think this happens when the job has been terminated long enough for the SLURM to forget what its id was. Also <code>vaccjob</code> is unaware of whether the job finished successfully or not. It tries to retrieve the output either way.</p>

</%block>
<%block name="references">
    <%bflib:reference title="Understanding the batch job system" url="https://www.uvm.edu/vacc/kb/knowledge-base/understand-batch-system/">How to connect to the VACC, write job scripts, install software dependencies, submit jobs, monitor jobs, and retrieve output. Contains links to pages that detail each step.</%bflib:reference>
    <%bflib:reference title="Non-interactive password authentication" url="https://www.cyberciti.biz/faq/noninteractive-shell-script-ssh-password-provider/">Detailed instructions on how to use <code>sshpass</code>, including examples. How to install <code>sshpass</code> on many operating systems.</%bflib:reference>
    <%bflib:reference title="SCP tutorial" url="https://snapshooter.com/learn/linux/copy-files-scp">At a high level, how to use <code>scp</code> and some of its switches.</%bflib:reference>
    <%bflib:reference title="Arguments in bash scripts" url="https://www.redhat.com/sysadmin/arguments-options-bash-scripts">Good practices for writing and structuring <code>bash</code> scripts. How to support command line switches and argments in <code>bash</code> scripts, including examples.</%bflib:reference>
</%block>