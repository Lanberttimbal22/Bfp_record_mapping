<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Http\Request;
use App\Models\User;

class LoginController extends Controller
{
    public function login(Request $request)
    {
        try {
            $validator = Validator::make($request->all(), [
                "contact_no" => "required",
                "password" => "required",
            ]);

            if ($validator->fails()) {
                return response()->json(["msg" => $validator->errors()], 422);
            }

            // $user = User::where('contact_no', $request->contact_no)->first();
            $user = User::select('users.*', 'gender.gender as gender')
                        ->leftJoin('gender', 'users.gender_id', '=', 'gender.id')
                        ->where('users.contact_no', $request->contact_no)
                        ->first();

            if (!$user || !Hash::check($request->password, $user->password)) {
                return response()->json(["msg" => "Invalid credentials","status"=>"error"], 401);
            }

            $token = $user->createToken("auth_token")->plainTextToken;

            return response()->json([
                'message' => 'Login successful',
                'access_token' => $token,
                'token_type' => 'Bearer',
                'data' => $user
            ]);

        } catch (\Exception $e) {
            return response()->json(["msg" => $e->getMessage(),"status"=>"error"], 500);
        }
    }
}
