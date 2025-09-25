<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('users', function (Blueprint $table) {
            $table->id();

            $table->string('full_name', 255);          // Matches max:255

            $table->date('birthday');                  // Matches date validation

            $table->unsignedTinyInteger('gender_id');     // Matches integer in:1,2

            $table->string('image', 255);              // Matches max:255

            $table->string('contact_no', 20);          // Not a true integer, but stored as string to support +, -, or leading 0s

            $table->string('address', 255);            // Matches max:255

            $table->string('password', 255);           // Password hashes need 60+ chars

            $table->unsignedTinyInteger('role_id');       // Matches integer in:1,2

            $table->unsignedTinyInteger('status_id');     // Matches integer in:0,1 (active/inactive)

            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('users');
    }
};
