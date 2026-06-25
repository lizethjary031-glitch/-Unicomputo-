<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class ProductController extends Controller
{
    private function checkAuth() {
        if (!session()->has('user_logged_in')) {
            return redirect('/login')->send();
        }
    }

    public function index() {
        $this->checkAuth();
        return view('products.index', ['products' => session()->get('products', [])]);
    }

    public function store(Request $request) {
        $this->checkAuth();
        $products = session()->get('products', []);
        $products[] = $request->only(['codigo', 'nombre', 'precio', 'cantidad', 'categoria']);
        session()->put('products', $products);
        return redirect()->route('products.index');
    }

    public function edit($codigo) {
        $this->checkAuth();
        $products = session()->get('products', []);
        $product = collect($products)->firstWhere('codigo', $codigo);
        return view('products.edit', ['product' => $product]);
    }

    public function update(Request $request, $codigo) {
        $this->checkAuth();
        $products = session()->get('products', []);
        foreach ($products as &$p) {
            if ($p['codigo'] == $codigo) {
                $p = $request->only(['codigo', 'nombre', 'precio', 'cantidad', 'categoria']);
            }
        }
        session()->put('products', $products);
        return redirect()->route('products.index');
    }

    public function destroy($codigo) {
        $this->checkAuth();
        $products = collect(session()->get('products', []))->reject(fn($p) => $p['codigo'] == $codigo)->values()->toArray();
        session()->put('products', $products);
        return redirect()->route('products.index');
    }
}