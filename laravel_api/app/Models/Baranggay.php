<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Baranggay extends Model
{
    protected $table = 'baranggay';

    protected $fillable = ['name'];

    public function establishments()
    {
        return $this->hasMany(Establishment::class, 'brgy_id');
    }
}

