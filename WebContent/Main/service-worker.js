self.addEventListener('push', event => {
    const data = event.data.json();
    self.registration.showNotification(data.title, {
        body: data.message,
        icon: '/icon.png',
        vibrate: [200, 100, 200]
    });
});

self.addEventListener('notificationclick', event => {
    event.notification.close();
    event.waitUntil(clients.openWindow('/news.jsp'));
});
