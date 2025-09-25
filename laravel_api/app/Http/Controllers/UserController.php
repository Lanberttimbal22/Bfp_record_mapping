<?php

namespace App\Http\Controllers; 
use Illuminate\Http\Request;
use App\Models\User; 
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class UserController extends Controller
{
    public function register(Request $request)
    {
        try {
            $validator = Validator::make($request->all(),[ 
                'full_name' => 'required|string|max:255',
                'birthday' => 'required|date',
                'gender_id' => 'required|integer|in:1,2',
                'image' => 'required|string|max:255',
                'contact_no' => 'required|string|max:20',
                'address' => 'required|string|max:255',
                'password' => 'required|string|min:8|max:50',
                'role_id' => 'required|integer|in:1,2',
                'status_id' => 'required|integer|in:0,1',
            ]);

            if ($validator->fails()) {
                Log::error('Validation failed', ['errors' => $validator->errors()->all()]);
                return response()->json(['errors' => $validator->errors()], 422);
            }

            // Check if user already exists by contact number
            $existingUser = User::where('contact_no', $request->contact_no)->first();

            if ($existingUser) {
                return response()->json(['msg' => 'User already exists', 'status' => 'failed'], 200);
            }


            User::create([
                'full_name' => $request->full_name,
                'birthday' => $request->birthday,
                'gender_id' => $request->gender_id,
                'image' => $request->image,
                'contact_no' => $request->contact_no,
                'address' => $request->address,
                'password' => Hash::make($request->password),
                'role_id' => $request->role_id,
                'status_id' => $request->status_id,
            ]);
 

            return response()->json(['msg' => 'Successfully created','status' => 'Success'], 200);
        } catch (\Exception $e) {
            Log::error('Registration exception', ['error' => $e->getMessage()]);
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }

    //get user 
    public function getAllUser()
    {
       $users = User::select(
                'users.full_name',
                'users.birthday',
                'users.gender_id',
                'users.image',
                'users.contact_no', 
                'users.address',
                'users.role_id',
                'users.status_id',
                'roles.role_name' // if roles table has a `name` column
            )
            ->leftJoin('roles', 'users.role_id', '=', 'roles.id')
            ->get();
        

        return response()->json($users);
    }
}
