<!DOCTYPE html>
<html lang="es">
<head>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">
    <nav class="bg-white p-4 shadow flex justify-between items-center px-10">
        <h1 class="text-xl font-bold">Unicomputo - Catálogo Tech</h1>
        <a href="/login" class="bg-blue-600 text-white px-4 py-2 rounded">Iniciar Sesión</a>
    </nav>

    <div class="container mx-auto p-6">
        <h2 class="text-2xl font-semibold mb-6">Dispositivos Disponibles</h2>
        <div id="tech-container" class="grid grid-cols-1 md:grid-cols-3 lg:grid-cols-4 gap-6">
            <p class="text-gray-500">Cargando productos...</p>
        </div>
    </div>

    <script>
        // API que contiene electrónica, celulares y computadores
        const url = 'https://fakestoreapi.com/products/category/electronics';

        fetch(url)
            .then(res => res.json())
            .then(data => {
                const container = document.getElementById('tech-container');
                container.innerHTML = ''; 

                data.forEach(item => {
                    container.innerHTML += `
                        <div class="bg-white p-4 rounded shadow hover:shadow-xl transition flex flex-col">
                            <img src="${item.image}" class="h-40 object-contain mb-4">
                            <h3 class="font-bold text-md mb-2 h-12 overflow-hidden">${item.title}</h3>
                            <p class="text-green-700 font-bold text-lg mb-2">$${item.price}</p>
                            <p class="text-xs text-gray-500 mb-4 flex-grow">${item.description.substring(0, 80)}...</p>
                            <button class="w-full bg-gray-800 text-white p-2 rounded">Ver Detalles</button>
                        </div>
                    `;
                });
            })
            .catch(err => console.error('Error:', err));
    </script>
</body>
</html>