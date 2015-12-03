# .profile
# =============================================================================
# PATHs and HOMEs must be set here
# Everything that concern interactive console must be set in .bashrc
# =============================================================================

# user specific env variable
export TOOLS_HOME=/slpafrcdz0001/apps/dew/tools
export JAVA_HOME=/tmp/java_home
#export JAVA_HOME=$TOOLS_HOME/java/default
export HADOOP_PREFIX=/tmp/hadoop-2.4.0
export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib"
export HBASE_HOME=/tmp/hbase-0.98.3-hadoop2
export HBASE_CONF_DIR=/tmp/conf

export PATH=$JAVA_HOME/bin:$HOME/.local/bin:$HOME/.gem/ruby/1.8/bin:/slpafrcdz0001/apps/dew/nodejs/bin/:/slpafrcdz0001/apps/dew/nodejs/node_modules/.bin/:$PATH
