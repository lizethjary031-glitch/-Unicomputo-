<?php

namespace App\Http\Controllers;

// Esta clase es la que provee la funcionalidad de los controladores
abstract class Controller
{
    use \Illuminate\Foundation\Auth\Access\AuthorizesRequests, 
        \Illuminate\Foundation\Validation\ValidatesRequests;
}