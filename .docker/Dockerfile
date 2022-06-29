FROM python:3.8-slim-bullseye

RUN useradd -s /bin/bash -m vscode
RUN groupadd docker && usermod -aG docker vscode

USER vscode

ENTRYPOINT ["sleep", "infinity"]