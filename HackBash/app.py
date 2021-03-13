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

app = Flask(__name__)


global sess
sess = tf.compat.v1.Session()
tf.compat.v1.keras.backend.set_session(sess)
global model
model = load_model(r'D:\Coding\HackBash\GarbageClassifier_Xce.h5')
global graph
graph = tf.compat.v1.get_default_graph()


@app.route('/predict', methods=['POST'])
def prediction():

    file = request.files['file']
    print(file)
    file.save(r'D:\Coding\HackBash\test.jpg')
    # Step 1
    # my_image = plt.imread(os.path.join('/content/drive/My Drive/flask/uploads', filename))

    # Step 2
    my_image = plt.imread(r'D:\Coding\HackBash\test.jpg')
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
    os.remove(r'D:\Coding\HackBash\test.jpg')
    return jsonify(msg)


if __name__ == '__main__':
    app.run(debug=True, host='192.168.140.1', port=5000)
