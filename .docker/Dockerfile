FROM python:3

RUN useradd -s /bin/bash -m vscode
RUN groupadd docker && usermod -aG docker vscode

USER vscode

RUN python3 -m venv env

RUN source env/bin/activate

#RUN pip install --no-cache-dir -r requirements.txt

#COPY . .

ENTRYPOINT ["sleep", "infinity"]