# Base image
FROM node:14 AS op-chain

# Set working directory
WORKDIR /app

# Clone the repository
RUN git clone https://github.com/celestiaorg/optimism.git .

# Install dependencies
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash && \
    export NVM_DIR="$HOME/.nvm" && \
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
    nvm install && \
    nvm use && \
    yarn install && \
    yarn build

# Expose the necessary port(s). Replace 3000 with the port number(s) your app runs on.
# EXPOSE 3000

# CMD to run your application. This example assumes a package.json script "start" is defined.
# CMD ["/bin/bash", "devnet-up.sh"]
