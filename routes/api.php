<?php
use Illuminate\Support\Facades\Route;

// Esta ruta no requiere auth, el catálogo la consumirá
Route::get('/productos-catalogo', function () {
    return response()->json(session()->get('products', []));
});
