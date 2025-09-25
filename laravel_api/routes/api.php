<?php
  
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route; 
use App\Http\Controllers\UserController; 
use App\Http\Controllers\LoginController; 
use App\Http\Controllers\EstablishmentsController; 
use App\Models\Gender;
use Illuminate\Support\Facades\Log;

/*
|--------------------------------------------------------------------------
| Public Routes (No Auth Needed)
|--------------------------------------------------------------------------
*/

Route::post('/register', [UserController::class, 'register']);
Route::post('/login', [LoginController::class, 'login']);
Route::get('/allUsers', [UserController::class, 'getAllUser']);

Route::get('/gender', function () {
    return response()->json(Gender::all());
});
 

Route::prefix('establishments')->group(function () {
    Route::get('/', [EstablishmentsController::class, 'index']);
    Route::get('/{id}', [EstablishmentsController::class, 'show']);
    Route::post('/', [EstablishmentsController::class, 'store']);
    Route::put('/{id}', [EstablishmentsController::class, 'update']);
    Route::delete('/{id}', [EstablishmentsController::class, 'destroy']);
});



/*
|--------------------------------------------------------------------------
| Protected Routes (Require Sanctum Auth Token)
|--------------------------------------------------------------------------
*/

Route::middleware('auth:sanctum')->group(function () {

    // Get current authenticated user
    Route::get('/users', function (Request $request) {
        return $request->user();
    });
 

});


Route::fallback(function () {
    Log::warning('Fallback route triggered - 404', [
        'url' => request()->fullUrl(),
        'method' => request()->method(),
        'ip' => request()->ip(),
    ]);
    return response()->json(['message' => 'Route not found.'], 404);
});
