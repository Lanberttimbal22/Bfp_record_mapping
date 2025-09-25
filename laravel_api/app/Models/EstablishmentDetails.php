<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class EstablishmentDetail extends Model
{
    use HasFactory;

    protected $table = 'establishment_details';

    protected $fillable = [
        'establishment_id',
        'owner',
        'brgy_id',
        'address',
        'business_type_id',
        'application_type_id',
    ];

    public function establishment()
    {
        return $this->belongsTo(Establishment::class);
    }

    public function barangay()
    {
        return $this->belongsTo(Baranggay::class, 'brgy_id');
    }

    public function businessType()
    {
        return $this->belongsTo(BusinessType::class, 'business_type_id');
    }

    public function applicationType()
    {
        return $this->belongsTo(ApplicationType::class, 'application_type_id');
    }
}
