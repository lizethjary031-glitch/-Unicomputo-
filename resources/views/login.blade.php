<!DOCTYPE html>
<html lang="es">
<head>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 flex items-center justify-center h-screen">
    <div class="bg-white p-8 rounded shadow-md w-96">
        <h2 class="text-2xl font-bold mb-6 text-center">Login Unicomputo</h2>
        
        <form action="/login" method="POST" class="space-y-4">
            @csrf
            <input type="text" name="email" placeholder="Usuario" class="w-full border p-2 rounded" required autocomplete="off">
            <input type="password" id="password" name="password" placeholder="Contraseña" class="w-full border p-2 rounded" required>
            
            <div class="flex items-center gap-2">
                <input type="checkbox" id="showPassword" onclick="togglePassword()">
                <label for="showPassword" class="text-sm text-gray-600 cursor-pointer">Mostrar contraseña</label>
            </div>
            
            <button class="w-full bg-blue-600 text-white p-2 rounded font-bold hover:bg-blue-700 transition">Ingresar</button>
        </form>

        <div class="mt-4 text-center">
            <a href="/" class="text-sm text-gray-500 hover:text-blue-600 underline">← Regresar al catálogo</a>
        </div>
    </div>

    <script>
        function togglePassword() {
            var passField = document.getElementById("password");
            if (passField.type === "password") {
                passField.type = "text";
            } else {
                passField.type = "password";
            }
        }
    </script>
</body>
</html>