FROM python:3.9-slim

ENV PYTHONUNBUFFERED=1

WORKDIR /app

RUN apt-get update && \
    apt-get install -y swi-prolog git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set environment variables for SWI-Prolog
ENV PATH="/usr/lib/swi-prolog/bin:${PATH}"
ENV SWI_HOME_DIR="/usr/lib/swi-prolog"

RUN swipl --version

COPY requirements.txt /app/

RUN pip install --no-cache-dir -r requirements.txt

RUN pip freeze

COPY src/ /app/

RUN ls -la /app

EXPOSE 5000

CMD ["python", "app.py"]
