<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Establishment;
use App\Models\EstablishmentDetail;
use Illuminate\Support\Facades\Validator;

class EstablishmentController extends Controller
{
    public function index()
    {
        // Return all establishments with their details & relations
        $data = Establishment::with(['detail', 'detail.barangay', 'detail.businessType', 'detail.applicationType'])
                    ->get();

        return response()->json($data);
    }

    public function show($id)
    {
        $est = Establishment::with('detail')->find($id);
        if (!$est) {
            return response()->json(['message' => 'Not found'], 404);
        }
        return response()->json($est);
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'business_name' => 'required|string|unique:establishments,business_name',
            'owner' => 'required|string|max:100',
            'brgy_id' => 'required|integer|exists:baranggay,id',
            'address' => 'required|string|max:200',
            'business_type_id' => 'required|integer|exists:business_types,id',
            'application_type_id' => 'required|integer|exists:application_types,id',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        // Create establishment
        $est = Establishment::create([
            'business_name' => $request->business_name,
            'status' => $request->status ?? 'PENDING',
        ]);

        // Create detail
        $detail = EstablishmentDetail::create([
            'establishment_id' => $est->id,
            'owner' => $request->owner,
            'brgy_id' => $request->brgy_id,
            'address' => $request->address,
            'business_type_id' => $request->business_type_id,
            'application_type_id' => $request->application_type_id,
        ]);

        return response()->json([
            'message' => 'Created',
            'data' => $est->load('detail'),
        ], 201);
    }

    public function update(Request $request, $id)
    {
        $est = Establishment::find($id);
        if (!$est) {
            return response()->json(['message' => 'Not found'], 404);
        }

        $validator = Validator::make($request->all(), [
            'business_name' => "required|string|unique:establishments,business_name,{$id}",
            'owner' => 'required|string|max:100',
            'brgy_id' => 'required|integer|exists:baranggay,id',
            'address' => 'required|string|max:200',
            'business_type_id' => 'required|integer|exists:business_types,id',
            'application_type_id' => 'required|integer|exists:application_types,id',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $est->business_name = $request->business_name;
        $est->status = $request->status ?? $est->status;
        $est->save();

        // Update detail
        $detail = $est->detail;
        if ($detail) {
            $detail->owner = $request->owner;
            $detail->brgy_id = $request->brgy_id;
            $detail->address = $request->address;
            $detail->business_type_id = $request->business_type_id;
            $detail->application_type_id = $request->application_type_id;
            $detail->save();
        } else {
            // If detail doesn't exist, create it
            EstablishmentDetail::create([
                'establishment_id' => $est->id,
                'owner' => $request->owner,
                'brgy_id' => $request->brgy_id,
                'address' => $request->address,
                'business_type_id' => $request->business_type_id,
                'application_type_id' => $request->application_type_id,
            ]);
        }

        return response()->json([
            'message' => 'Updated',
            'data' => $est->load('detail'),
        ]);
    }

    public function destroy($id)
    {
        $est = Establishment::find($id);
        if (!$est) {
            return response()->json(['message' => 'Not found'], 404);
        }

        $est->delete();

        return response()->json(['message' => 'Deleted']);
    }
}
