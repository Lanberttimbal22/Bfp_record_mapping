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
        Schema::create('establishment_details', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('establishment_id');
            $table->string('owner', 100);
            $table->unsignedBigInteger('brgy_id');
            $table->string('address', 200);
            $table->unsignedBigInteger('business_type_id');
            $table->unsignedBigInteger('application_type_id');
            $table->timestamps();

            // Foreign keys
            $table->foreign('establishment_id')
                  ->references('id')
                  ->on('establishments')
                  ->onDelete('cascade');
            $table->foreign('brgy_id')
                  ->references('id')
                  ->on('baranggay')
                  ->onDelete('cascade');
            $table->foreign('business_type_id')
                  ->references('id')
                  ->on('business_type')
                  ->onDelete('cascade');
            $table->foreign('application_type_id')
                  ->references('id')
                  ->on('application_type')
                  ->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('establishment_details');
    }
};
