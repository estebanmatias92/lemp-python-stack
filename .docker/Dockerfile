FROM python:3.8-bullseye

RUN useradd -s /bin/bash -m vscode
RUN groupadd docker && usermod -aG docker vscode

USER vscode

RUN sudo python3 -m venv env

RUN sudo source env/bin/activate

#RUN pip install --no-cache-dir -r requirements.txt

#COPY . .

ENTRYPOINT ["sleep", "infinity"]