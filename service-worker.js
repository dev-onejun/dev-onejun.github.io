// service worker for your GitHub blog
const cacheName = 'v1';
const cacheFiles = [
  '/',
];

// install service worker
self.addEventListener('install', event => {
  console.log('Service worker installed');
  event.waitUntil(
    caches.open(cacheName)
      .then(cache => {
        console.log('Caching files');
        cache.addAll(cacheFiles);
      })
  );
});

// fetch service worker
self.addEventListener('fetch', event => {
  console.log('Fetch event for ', event.request.url);
  event.respondWith(
    caches.match(event.request)
      .then(response => {
        if (response) {
          console.log(event.request.url, ' returned from cache');
          return response;
        }
        console.log(event.request.url, ' not found in cache, fetching from network');
        return fetch(event.request);
      })
  );
});

