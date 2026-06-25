<?php
use Illuminate\Support\Facades\Route;
use Illuminate\Http\Request;
use App\Http\Controllers\ProductController;

Route::get('/', function () { return view('catalogo'); });
Route::get('/login', function () { return view('login'); })->name('login');

Route::post('/login', function (Request $request) {
    if ($request->email == 'Jary' && $request->password == '12345') {
        session(['user_logged_in' => true]);
        return redirect('/products');
    }
    return back()->withErrors(['email' => 'Credenciales incorrectas']);
});

Route::resource('products', ProductController::class);
Route::put('/products/{codigo}', [ProductController::class, 'update'])->name('products.update');
Route::get('/logout', function () { session()->forget('user_logged_in'); return redirect('/login'); });