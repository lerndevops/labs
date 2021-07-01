FROM python:2.7.11-slim
RUN pip install --upgrade pip
RUN pip install requests flask
RUN mkdir mypyapp
COPY myapp.py mypyapp/
WORKDIR mypyapp
EXPOSE 3000
ENTRYPOINT ["python", "myapp.py"]
