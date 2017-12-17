# The get-login command outputs the "docker login" command you need to execute with a temporary token
# You can run both directly using eval
# The --no-include-email tells get-login not to return the -e option that does not work for all of Docker versions
eval $(aws ecr get-login --no-include-email)
