FROM python:3

RUN useradd -s /bin/bash -m vscode
RUN groupadd docker && usermod -aG docker vscode

USER vscode

RUN apt-get update -y && apt-get upgrade -y

#RUN python3 -m venv env

#RUN bash -c source env/bin/activate

#RUN pip install --no-cache-dir -r requirements.txt

#COPY . .

ENTRYPOINT ["sleep", "infinity"]

