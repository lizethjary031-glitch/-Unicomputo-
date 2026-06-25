<!DOCTYPE html>
<html lang="es">
<head>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 p-10">
    <div class="max-w-5xl mx-auto bg-white p-6 rounded shadow">
        <h1 class="text-2xl font-bold mb-4">Gestión de Productos</h1>
        
        <form action="{{ route('products.store') }}" method="POST" class="grid grid-cols-2 gap-4 mb-8 border-b pb-6">
            @csrf
            <input type="text" name="codigo" placeholder="Código (Ej: 001)" class="border p-2" required>
            <input type="text" name="nombre" placeholder="Nombre" class="border p-2" required>
            <input type="number" name="precio" placeholder="Precio" class="border p-2" required>
            <input type="number" name="cantidad" placeholder="Cantidad" class="border p-2" required>
            
            <select name="categoria" class="border p-2 col-span-2" required>
                <option value="" disabled selected>Selecciona una categoría</option>
                <option value="Computador">Computador</option>
                <option value="RAM">RAM</option>
                <option value="Disco">Disco</option>
                <option value="Monitor">Monitor</option>
                <option value="Accesorios">Accesorios</option>
            </select>
            
            <button class="bg-green-600 text-white p-2 col-span-2 rounded font-bold">Guardar Producto</button>
        </form>

        <table class="w-full border text-left">
            <thead class="bg-gray-200">
                <tr>
                    <th class="p-2">Código</th>
                    <th class="p-2">Nombre</th>
                    <th class="p-2">Categoría</th>
                    <th class="p-2">Precio</th>
                    <th class="p-2">Acciones</th>
                </tr>
            </thead>
            <tbody>
                @foreach($products as $p)
                <tr class="border-b">
                    <td class="p-2">{{ $p['codigo'] }}</td>
                    <td class="p-2">{{ $p['nombre'] }}</td>
                    <td class="p-2 italic">{{ $p['categoria'] }}</td>
                    <td class="p-2">${{ number_format($p['precio']) }}</td>
                    
                    <td class="p-2 flex gap-4">
                        <a href="{{ route('products.edit', $p['codigo']) }}" class="text-blue-600 font-bold hover:underline">
                            Editar
                        </a>
                        
                        <form action="{{ route('products.destroy', $p['codigo']) }}" method="POST">
                            @csrf @method('DELETE')
                            <button class="text-red-600 font-bold hover:underline">Eliminar</button>
                        </form>
                    </td>
                </tr>
                @endforeach
            </tbody>
        </table>
        
        <a href="/logout" class="text-blue-500 mt-6 inline-block hover:underline">Cerrar Sesión</a>
    </div>
</body>
</html>