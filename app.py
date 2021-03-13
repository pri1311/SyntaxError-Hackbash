from flask import Flask, request, jsonify, render_template
import os
#import cv2 as cv
import pandas as pd
from tensorflow import keras
import tensorflow as tf
#import tensorflow.compat.v1.keras.backend as tb
import matplotlib.pyplot as plt
from keras.models import load_model
from skimage.transform import resize
import numpy as np
from news import news
from recyclingCentres import query4

app = Flask(__name__)


global sess
sess = tf.compat.v1.Session()
tf.compat.v1.keras.backend.set_session(sess)
global model
model = load_model(r'app/GarbageClassifier_Xce.h5')
global graph
graph = tf.compat.v1.get_default_graph()


@app.route('/predict', methods=['POST'])
def prediction():

    file = request.files['file']
    print(file)
    file.save(r'test.jpg')
    # Step 1
    # my_image = plt.imread(os.path.join('/content/drive/My Drive/flask/uploads', filename))

    # Step 2
    my_image = plt.imread(r'test.jpg')
    my_image_re = resize(my_image, (150, 150))

    x = np.expand_dims(my_image_re, axis=0)

    pro = model.predict(x)
    pro = pro * 100

    mat = ['cardboard', 'glass', 'metal', 'paper', 'plastic', 'trash']
    mat_annos = pd.DataFrame(mat)

    ll = []

    for i, mat in enumerate(list(mat_annos.iloc[:, 0])):
        element = {"mat": mat, "prob": pro[0][i]}
        ll.append(element)

    save = sorted(ll, key=lambda i: i['prob'], reverse=True)
    class1 = save[0]["mat"]
    pro = {
        "class1": save[0]["mat"],
        "prob1": save[0]["prob"],
    }
    msg = {'class': class1}
    os.remove(r'test.jpg')
    return jsonify(msg)


data1 = {}


@app.route('/news', methods=['POST'])
def scrape():
    global data1
    msg = ""
    html = news.make_request()
    data = news.parse_content(html)
    if data:
        data1 = {'data': data}
        msg = {"status": {"type": "success", "data": 0, "message": data}}
    else:
        msg = {"status": {"type": "failure", "message": "Missing Data"}}
    return jsonify(msg)


@app.route('/recyclingCentres', methods=['POST'])
def web():
    global data1
    msg = ""

    html = query4.make_request()
    data = query4.parse_content(html)
    if data:
        data1 = {'data': data}
        msg = {"status": {"type": "success", "data": 4, "message": data}}
    else:
        msg = {"status": {"type": "failure", "message": "Missing Data"}}
    return jsonify(msg)


if __name__ == '__main__':
    app.run(debug=True)
