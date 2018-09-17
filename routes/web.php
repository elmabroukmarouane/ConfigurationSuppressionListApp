<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

/* ------------------ Global APP ------------------- */
Route::get('/', function () {
    return view('app');
});
/* ------------------ Global APP ------------------- */

/* ------------------ Suplist ------------------- */
// SuplistController
Route::resource('suplist', 'SuplistController');
Route::post('suplist-upload', 'SuplistController@suplist_upload')->name('suplist-upload');
Route::get('get-offers/{id_Sponsor_Offer}', 'SuplistController@getOffers')->name('get-offers');
/* ------------------ Suplist ------------------- */

/* ------------------ Serverautomaticconfiguration ------------------- */
// ServerautomaticconfigurationController
Route::resource('server-automatic-configuration', 'ServerautomaticconfigurationController');
Route::post('automatic-config-server', 'ServerautomaticconfigurationController@automatic_config_server')->name('automatic-config-server');
/* ------------------ Serverautomaticconfiguration ------------------- */

/* ------------------ Users ------------------- */
// Users Management
Route::resource('users', 'UsersController');
/* ------------------ Users ------------------- */

/* ------------------ Login ------------------- */
Route::post('login', 'Auth\LoginController@login');
Route::get('logout', 'Auth\LoginController@logout');

/* ------------------ Login ------------------- */

/* ------------------ Ckech Auth ------------------- */
// Check Loging
Route::get('is-logged', function(){
    if (Auth::check()) {
        return response()->json([
                'name_user' => Auth::user()->name,
                'auth_check' => true
            ], 200);
    }
    return response()->json([
            'auth_check' => false
        ], 200);
});
/* ------------------ Ckech Auth ------------------- */
