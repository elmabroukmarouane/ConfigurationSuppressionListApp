<?php

namespace App\Http\Controllers\Auth;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Auth;
use App\User;

class LoginController extends Controller
{
    public function __construct() {
        $this->middleware('guest', ['except' => ['logout']]);
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */

    public function index()
    {
        return view('auth.login');
    }

    public function login(Request $request)
    {
        $email = $request->email;
        $password = $request->password;

        if (Auth::attempt(['email' => $email, 'password' => $password]))
        {
            return response()->json([
                'msg' => 'Welcome  ' . Auth::user()->name . ' !'
            ], 200);
        }
        return response()->json([
                'msg' => 'Wrong email or password !'
            ], 500);
    }

    public function logout()
    {
        Auth::logout();
    }
}
