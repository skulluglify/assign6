FROM docker.io/python:slim

RUN mkdir /app
WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    FLASK_DEBUG=0

COPY requirements.txt /app/
COPY wait-for-it.sh /app/
COPY app/*.py /app/

RUN chmod a+x /app/wait-for-it.sh 
RUN pip install -r requirements.txt

CMD [ "/app/wait-for-it.sh", "$POSTGRES_HOST:$POSTGRES_PORT", "--", "python", "-m", "flask", "-A", "/app/app", "--no-debug", "run", "--host", "0.0.0.0" ]

EXPOSE 5000
