<!DOCTYPE html>
<html lang="es">
<head><script src="https://cdn.tailwindcss.com"></script></head>
<body class="bg-gray-100 p-10">
    <div class="max-w-2xl mx-auto bg-white p-6 rounded shadow">
        <h1 class="text-2xl font-bold mb-4">Editar Producto</h1>
        <form action="{{ route('products.update', $product['codigo']) }}" method="POST" class="grid gap-4">
            @csrf @method('PUT')
            <input type="text" name="codigo" value="{{ $product['codigo'] }}" readonly class="border p-2 bg-gray-200">
            <input type="text" name="nombre" value="{{ $product['nombre'] }}" class="border p-2" required>
            <input type="number" name="precio" value="{{ $product['precio'] }}" class="border p-2" required>
            <input type="number" name="cantidad" value="{{ $product['cantidad'] }}" class="border p-2" required>
            <select name="categoria" class="border p-2" required>
                @foreach(['Computador', 'RAM', 'Disco', 'Monitor', 'Accesorios'] as $cat)
                    <option value="{{ $cat }}" {{ $product['categoria'] == $cat ? 'selected' : '' }}>{{ $cat }}</option>
                @endforeach
            </select>
            <button class="bg-blue-600 text-white p-2 rounded">Actualizar</button>
        </form>
    </div>
</body>
</html>