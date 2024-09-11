<?php

namespace App\Models;

use App\Http\Traits\OrganizationScopedTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Product extends Model
{
    use HasFactory;
    use SoftDeletes;
    use OrganizationScopedTrait;


    protected $fillable = ['name', 'description', 'image', 'sku','quantity', 'category_id', 'brand_id', 'vendor_id', 'tags', 'is_description_shown_in_invoices', 'has_related_products', 'is_active', 'created_by', 'organization_id'];


    protected $casts = [
        'is_description_shown_in_invoices' => 'boolean',
        'has_related_products' => 'boolean',
        'is_active' => 'boolean',
    ];



    public function category()
    {

        return $this->belongsTo(Category::class)->select(['id', 'name','image', 'description', 'parent_id', 'is_active']);
    }


    public function brand()
    {
        return $this->belongsTo(Brand::class)->select(['id', 'name','image', 'description', 'is_active']);
    }

    public function vendor()
    {
        return $this->belongsTo(Vendor::class)->select(['id','company_name', 'email', 'number', 'image', 'name', 'website', 'description', 'address', 'is_active']);
    }

}
