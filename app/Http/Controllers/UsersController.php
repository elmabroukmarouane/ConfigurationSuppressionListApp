<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\User;

class UsersController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $users = User::orderBy('id', 'DESC')->get();
        return response()->json([
            'users'    => $users,
        ], 200);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $rules = [
            'name' => 'required',
            'email' => 'required|email',
            'password' => 'required|min:6',
        ];

        $customMessages = [
            'required' => 'Entrer :attribute !',
            'email' => 'Email n\'est pas valide !',
            'min' => 'Le mot de passe doit être supérieur ou égal à 6 caractères !'
        ];

        $this->validate($request, $rules, $customMessages);

        $user_valid_email = User::where('email', $request->email)->first();

        if(!$user_valid_email) 
        {
            $user = new User();
            $user->name = $request->name;
            $user->email = $request->email;
            $user->password = bcrypt($request->password);
            $result_user = $user->saveOrFail();
            if($result_user){
                return response()->json([
                    'user'       => $user,
                    'message'        => 'Success'
                ], 200);
            }else{
                return response()->json([
                    'msg'       => 'Add Action Failed !',
                    'message'        => 'error'
                ], 500);
            }
        }
        else
        {
            return response()->json([
                'msg'       => 'This email is already taken, please choose another email !',
                'message'        => 'error'
            ], 500);
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $user = User::find($id);
        return response()->json([
            'user'       => $user,
            'message'        => 'Success'
        ], 200);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  User  $user
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, User $user)
    {
        $rules = [
            'name' => 'required',
            'email' => 'required|email'
        ];

        $customMessages = [
            'required' => 'Enter :attribute !',
            'email' => "Please enter a valid email !"
        ];

        $this->validate($request, $rules, $customMessages);

        $user_valid_email = User::where('email', $request->email)
        ->where('id', '<>', $user->id)
        ->first();

        if(!$user_valid_email) 
        {
            $user->name = $request->name;
            $user->email = $request->email;
            if(isset($request->password))
            {
                $user->password = bcrypt($request->password);
            }
            $result_user = $user->saveOrFail();
            if($result_user){
                return response()->json([
                    'user'       => $user,
                    'message'        => 'Success'
                ], 200);
            }else{
                return response()->json([
                    'msg'       => 'Update Action Failed !',
                    'message'        => 'error'
                ], 500);
            }
        }
        else
        {
            return response()->json([
                'msg'       => 'This email is already taken, please choose another email !',
                'message'        => 'error'
            ], 500);
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $result = User::where('id','=', $id)->delete();
        if($result){
            return response()->json([
                'msg' => 'User deleted successfully !'
            ], 200);
        }else{
            return response()->json([
                'msg' => 'Action failed  !'
            ], 500);
        }
    }
}
