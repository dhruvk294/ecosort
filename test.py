import tensorflow as tf

# Load your trained model
model = tf.keras.models.load_model('waste_classifier.h5')

# Convert to TFLite format
converter = tf.lite.TFLiteConverter.from_keras_model(model)
tflite_model = converter.convert()

# Save the TFLite model
with open('waste_classifier.tflite', 'wb') as f:
    f.write(tflite_model)