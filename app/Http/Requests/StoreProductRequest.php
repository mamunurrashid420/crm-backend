<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreProductRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    
    public function authorize(): bool
    {
        return true;
    }
            

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'name' => ['required', 'string'],
            'description' => ['nullable', 'string'],
            'image' => ['nullable', 'file', 'image', 'mimes:jpg,jpeg,png', 'max:2048'],
            'sku' => ['required', 'string'],
            'quantity' => ['required', 'integer'],
            'category_id' => ['nullable', 'integer'],
            'brand_id' => ['nullable', 'integer'],
            'vendor_id' => ['nullable', 'integer'],
            'tags' => ['nullable', 'json'],
            'regular_price' => ['required', 'numeric'],
            'sale_price' => ['required', 'numeric'],
            'is_description_shown_in_invoices' => ['required', 'integer'],
            'has_related_products' => ['required', 'integer'],
            'is_active' => ['required', 'integer'],
        ];
    }
}
