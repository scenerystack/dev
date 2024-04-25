# Use the official Node.js image as a parent image
FROM node:latest

# Set the working directory inside the container
WORKDIR /sim-dev

# Install Git, necessary for cloning repositories
RUN apt-get update && apt-get install -y git

# Install global npm packages that are needed
RUN npm install -g grunt-cli http-server

# Configure npm to not generate a package-lock.json and to not save packages by default
RUN npm config set package-lock false && npm config set save false

# Clone the perennial repository to setup the environment
# Note: Using git directly avoids any path issues across operating systems
RUN git clone https://github.com/phetsims/perennial.git /sim-dev/perennial

# Run the script to clone all necessary repositories
RUN cd /sim-dev/perennial && ./bin/clone-missing-repos.sh

# Install npm dependencies in the required directories
# This pattern avoids path issues by ensuring commands run in the intended directories
RUN cd /sim-dev/perennial && npm install
RUN cd /sim-dev/perennial-alias && npm install
RUN cd /sim-dev/chipper && npm install
RUN perennial/bin/for-each.sh perennial/data/active-repos "rm .git/hooks/pre-commit; git init --template=../phet-info/git-template-dir"

# Set environment variable for Node to watch changes
ENV NODE_ENV=development

# Expose the HTTP server port
EXPOSE 8080

# The CMD command runs both the HTTP server and the TypeScript transpiler in parallel
# This ensures that file changes are watched, and the server is refreshed sim-devropriately
CMD ["sh", "-c", "cd /sim-dev/chipper && node js/scripts/transpile.js --watch & http-server -p 8080 -c-1 /sim-dev"]