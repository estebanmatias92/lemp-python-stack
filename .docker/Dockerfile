FROM python:3

RUN python3 -m venv env

RUN source env/bin/activate

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

#COPY . .

CMD [ "sleep", "infinity" ]