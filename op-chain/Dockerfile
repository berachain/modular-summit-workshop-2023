# Start with an Alpine base image
FROM alpine AS op-chain

# Set the working directory
WORKDIR /app

# Install git, Node.js, and other potential dependencies
RUN apk add --no-cache git nodejs npm

# Upgrade npm to the desired version
RUN npm install -g npm@9.6.5

# Check npm version to verify
RUN npm -v

# Clone the optimism repository
RUN git clone https://github.com/celestiaorg/optimism.git .

# Optionally, continue with any other steps you want
