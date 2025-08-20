FROM python:3.13-slim

# Install dependencies required to run Instant Client
RUN apt-get update && \
    apt-get install -y libaio1t64 unzip

# Copy and unzip the Oracle Instant Client ZIP
COPY lib/instantclient-basiclite-linux.x64-23.9.0.25.07.zip ./tmp

RUN mkdir -p /opt/oracle/instantclient && \
    unzip /tmp/instantclient-basiclite-linux.x64-23.9.0.25.07.zip -d /opt/oracle/ && \
    mv /opt/oracle/instantclient_*/* /opt/oracle/instantclient && \
    ln -s /usr/lib/x86_64-linux-gnu/libaio.so.1t64.0.2 /opt/oracle/instantclient/libaio.so.1

# Set environment variables for thick mode
ENV LD_LIBRARY_PATH=/opt/oracle/instantclient

# Copy python files and install packages
COPY main.py .
COPY requirements.txt .
RUN pip install -r requirements.txt

# Run Python script at container startup
CMD ["python", "main.py"]
