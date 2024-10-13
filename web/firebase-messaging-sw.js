importScripts("https://www.gstatic.com/firebasejs/10.11.1/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/10.11.1/firebase-messaging-compat.js");

firebase.initializeApp({
      apiKey: 'AIzaSyDBh7ripfS9Y5XLUVrgkd5H0XdvvvpPvSo',
      appId: '1:181961421151:web:a1f1bbf70cfadc49dfc6ea',
      messagingSenderId: '181961421151',
      projectId: 'gymday-ee08c',
      authDomain: 'gymday-ee08c.firebaseapp.com',
      databaseURL: 'https://gymday-ee08c.firebaseio.com',
      storageBucket: 'gymday-ee08c.appspot.com',
      measurementId: 'G-NQZVD6LYCB',
});

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});
