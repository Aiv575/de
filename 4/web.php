<?php

use App\Http\Controllers\ApiTesterController;
use Illuminate\Support\Facades\Route;

Route::get('/', [ApiTesterController::class,'view'])->name('test');
Route::get('/get',[ApiTesterController::class,'get'])->name('test.get');
Route::post('/check',[ApiTesterController::class,'check'])->name('test.check');
