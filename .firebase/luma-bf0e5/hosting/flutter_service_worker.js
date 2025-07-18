'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "1f5d1e1f682b21df0d3d9cf178185319",
"assets/AssetManifest.bin.json": "777127391d63a36a97a3b5c1a40279a3",
"assets/AssetManifest.json": "e6f9dce69fef06ae2dde2c885a4f3055",
"assets/assets/fonts/ARIAL.TTF": "fa3228aadde0db988e1822c2f736c131",
"assets/assets/images/adidas_image.png": "d8a5951fde23e51bb5c3db647fc88f2b",
"assets/assets/images/adidas_items/1043854.webp": "94bb832e72a0b3f4116ea46d876a73fe",
"assets/assets/images/adidas_items/1043857.webp": "f4a881176b0cf77d3cb0307d7161a0f1",
"assets/assets/images/adidas_items/1043869.webp": "9c102839b272cfc33cddd50aa6c55036",
"assets/assets/images/adidas_items/1211248.webp": "ba17c13c5ae764d635855b83e014702c",
"assets/assets/images/adidas_items/1211251.webp": "614dad7e5919cc148776a24017bba662",
"assets/assets/images/adidas_items/1211263.webp": "14aed75625246fb5cb94bcfc4ac5259d",
"assets/assets/images/adidas_items/53178-full_product.webp": "0003574c78eadbd999f194bdd7cdcfa0",
"assets/assets/images/adidas_items/53179.webp": "6c644b9e978c012533fa06932c75a83d",
"assets/assets/images/adidas_items/53180.webp": "9345a6598f8817e03e4d90a9462818c5",
"assets/assets/images/adidas_logo.jpg": "63142fa5382035b00fd4914c5600fe86",
"assets/assets/images/avatar.jpg": "b62ca69fac191df49e08bb258f55550a",
"assets/assets/images/balenciaga_image.jpg": "bc98c61e310f8b3acf883ef739fc5bc2",
"assets/assets/images/balenciaga_items/183e93db4b133e0761e80bcfdeb9e7a8.webp": "f2934c68b9cd37b45c4dae846c316eab",
"assets/assets/images/balenciaga_items/2dda30341ee71d98d0e075a7d84bc79f.webp": "e6406b30ce5a82741a9c4cf02f666aff",
"assets/assets/images/balenciaga_items/4290721.jpg": "5075fc876e2ef9aa776fe9a56cdf66e7",
"assets/assets/images/balenciaga_items/94316601e393248cf27a3626872e9331.webp": "081d97b81556c3b4b976a43f786ad023",
"assets/assets/images/balenciaga_items/ee145ca9300bf2797e92fd25ea4bb766.webp": "13a3faa12b608d7057f881603cd50b41",
"assets/assets/images/balenciaga_items/f37c2fb24d870feadc49f58f5e583013.webp": "de7e7a58c3bc949ccf382a91fcc34ccc",
"assets/assets/images/balenciaga_items/image27284873.jpg": "93b5341d08378dc9852235cb84ad6ae6",
"assets/assets/images/balenciaga_items/P00493698.webp": "ed03fecdfec21a665f630f1c3e4d657f",
"assets/assets/images/balenciaga_items/P00493698_b1.webp": "a86955299d96a9926bf3b7d117935d5a",
"assets/assets/images/balenciaga_items/P00493698_d1.webp": "afadcaefd00838f4a26b59f6a294579b",
"assets/assets/images/balenciaga_logo.png": "47f87cc81d2317d158c858bb78db592f",
"assets/assets/images/luma.png": "946ce18399103bed42d6cbb3d5932ffc",
"assets/assets/images/prada_image.avif": "8ee031bb1fbf997ea2635d4dec4576d4",
"assets/assets/images/prada_items/black-other-prada-sunglasses-57041024-1_2.webp": "55a180e26b505fe8207884dd5e13b3e9",
"assets/assets/images/prada_items/black-other-prada-sunglasses-57041024-2_2.webp": "de283afbedebdfa5c4aa300982e0bd34",
"assets/assets/images/prada_items/black-other-prada-sunglasses-57041024-5_2.webp": "ef31d3f9f600d69cace78fbb71d17b0c",
"assets/assets/images/prada_items/brown-leather-prada-handbag-57051102-1_2.webp": "f6d47604b669f85b8e31c0d84fd36a4b",
"assets/assets/images/prada_items/brown-leather-prada-handbag-57051102-3_2.webp": "3a00b0bb97608cba44fd397c2e74194c",
"assets/assets/images/prada_items/pink-leather-double-prada-handbag-57040028-1_2.webp": "2e5d175ec1e1d82130d54d6f0e777158",
"assets/assets/images/prada_items/pink-leather-double-prada-handbag-57040028-3_2.webp": "7b83198077cec88b42d1dbd82ec138dc",
"assets/assets/images/prada_items/pink-leather-double-prada-handbag-57040028-6_2.webp": "1456ed4edacdf6cb2376150277dae275",
"assets/assets/images/prada_items/white-cotton-prada-top-57023904-1_2.webp": "c18a864d2c8fcf5e93658a4bf95e4656",
"assets/assets/images/prada_items/white-cotton-prada-top-57023904-2_2.webp": "72978ff8b8184e3a2fa49c7443b51983",
"assets/assets/images/prada_logo.webp": "b42d6106df6516ab39b1ee9c8ffbd53a",
"assets/assets/videos/adidas.mp4": "69a3f149529c529638654306827f438a",
"assets/assets/videos/balenciaga.mp4": "02b89b8aa2ce247e6e5da5b65b95b93d",
"assets/assets/videos/prada.mp4": "9abf6a10b06568d720717fe460e99885",
"assets/FontManifest.json": "e9c0a9a23e756d171160340c4eefbc94",
"assets/fonts/MaterialIcons-Regular.otf": "e90f6e3cb531b2bc24c081a61167ca81",
"assets/NOTICES": "1368209fc99facdfc5a602aa48365978",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"flutter_bootstrap.js": "3692fdb0c0f7e0b9bb20134dae5a68cc",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "113296555ef10b7e4eccec32d0371452",
"/": "113296555ef10b7e4eccec32d0371452",
"main.dart.js": "1daff73c47198c45a01c35209db2735e",
"manifest.json": "304dd79496d33b01761846954b279471",
"version.json": "c951381d2eda280857b10bd0f106617d"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
