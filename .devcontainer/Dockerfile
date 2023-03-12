FROM node:16

# Install Python and pip
RUN apt-get update && apt-get install -y python3 python3-pip
# Install the Checkov tool
RUN pip3 install --upgrade pip && pip3 install --upgrade setuptools && \
    pip3 install checkov


# Set the working directory to /app
WORKDIR /app

# Copy the package.json and yarn.lock files to the working directory
COPY package.json /app
COPY yarn.lock /app

# Install the Node.js dependencies using Yarn
RUN yarn install

# Copy the rest of the application files to the working directory
COPY . .

# Expose port 3000 for the application
EXPOSE 3000

# Start the application using the "start" script defined in the package.json file
CMD ["yarn", "start"]
