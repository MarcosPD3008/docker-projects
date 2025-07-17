FROM n8nio/n8n:latest

USER root

# Install community nodes globally
RUN npm install -g n8n-nodes-google-firebase@latest && \
    npm install -g @n8n/n8n-nodes-google@latest && \
    npm install -g n8n-nodes-openai@latest

# Create the n8n directory and set permissions
RUN mkdir -p /home/node/.n8n && \
    chown -R node:node /home/node/.n8n && \
    chmod -R 755 /home/node/.n8n

# Switch back to node user
USER node

# Default command
CMD ["n8n", "start"]