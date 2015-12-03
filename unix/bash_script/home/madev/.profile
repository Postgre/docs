# .profile

# User specific environment and startup programs
export TOOLS_HOME=/export/tools
export APPS_HOME=/export/apps

export JAVA_HOME=$TOOLS_HOME/java/default
export ANT_HOME=$TOOLS_HOME/ant/default

export PATH=$JAVA_HOME/bin:$ANT_HOME/bin:$APPS_HOME/iamapi-server:$PATH
