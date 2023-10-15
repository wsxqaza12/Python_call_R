Use docker to build an image that works for python and R. Use python to call R scripts.

```
sudo docker build -t python_call_r_image .
sudo docker run -it --name python_call_r python_call_r_image

root@5987d9003d74:/app# python3 preprocess.py
df_result           Country  Temperature(degree fahrenheit)
8   United States     NaN
14  United States     NaN
15  United States    82.0
32  United States     NaN
34  United States    31.0
35  United States    36.0
68  United States     NaN
74  United States    22.0
81  United States    47.0
88  United States    40.0
99  United States    48.0
root@5987d9003d74:/app# exit

sudo docker rm python_call_r
```

# Reference

[Calling R from Python | Magic of rpy2](https://medium.com/analytics-vidhya/calling-r-from-python-magic-of-rpy2-d8cbbf991571)
[How can I create a Docker image to run both Python and R?](https://stackoverflow.com/questions/54437030/how-can-i-create-a-docker-image-to-run-both-python-and-r)
[from-pandas-to-r](https://rpy2.github.io/doc/v3.4.x/html/generated_rst/pandas.html#from-pandas-to-r)

Call MMM R packages in python

```
# 依照docker-compose.yml和Dockerfile建立映象檔
sudo docker-compose build

# 透過映象檔，建立一個容器
sudo docker-compose up -d

# 透過command line進入到容器當中
sudo docker exec -it pythoncallr_backend_1 bash

# 切換到dependent資料夾，並且安裝MMM函式庫
cd /dependent/
R CMD INSTALL MMM_0.1.0.tar.gz

# 切換到app資料夾，並且執行app.py
cd /app
python3 app.py

# 使用完畢，把容器關閉
sudo docker-compose down
```
