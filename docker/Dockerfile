from python:3.12-alpine

RUN apk add --no-cache postgresql-dev gcc libc-dev gcc g++ make libffi-dev python3-dev build-base

RUN pip install --upgrade pip==26.0.1
RUN pip install gunicorn==25.0.3

WORKDIR /app

COPY docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .

WORKDIR /app/decide

ENTRYPOINT ["/entrypoint.sh"]
