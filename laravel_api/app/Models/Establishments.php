<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Establishment extends Model
{
    use HasFactory;

    protected $fillable = [
        'business_name',
        'status',
    ];

    public function detail()
    {
        return $this->hasOne(EstablishmentDetail::class);
    }
}
