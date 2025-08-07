FROM python:3.13-slim

# Install dependencies required to run Instant Client
RUN apt-get update && apt-get install -y \
    libaio1 \
    libnsl-dev \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Create working directory
WORKDIR /opt/oracle

# Copy and unzip the Oracle Instant Client ZIP
COPY lib/instantclient-basiclite-linux.x64-23.9.0.25.07.zip ./

RUN mkdir -p /opt/oracle/instantclient/lib && \
    unzip -q instantclient-basiclite-linux.x64-23.9.0.25.07.zip -d /opt/oracle/instantclient/lib && \
    mv /opt/oracle/instantclient/lib/instantclient_*/* /opt/oracle/instantclient/lib/ && \
    rm -rf /opt/oracle/instantclient/lib/instantclient_*

    # Set environment variables for thick mode
ENV LD_LIBRARY_PATH=/opt/oracle/instantclient
ENV ORACLE_HOME=/opt/oracle/instantclient
ENV PATH=$ORACLE_HOME:$PATH

# Copy python files and install packages
COPY main.py .
COPY requirements.txt .
RUN pip install -r requirements.txt

# Run Python script at container startup
CMD ["python", "main.py"]
