<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Redis;

class ApiTesterController extends Controller
{
    public function view(Request $request)
    {
        return view('welcome');
    }

    public function get()
    {
        $data = file_get_contents('http://localhost:8000/api/fullName');

        if ($data)
        {
            $data = json_decode($data) -> value;
        }

        return redirect()->route('test')->with('value', $data);
    }

    public function check(Request $request)
    {
        $value = $request->input('value');

        if(preg_match('/^[А-Яа-яЁё]+ [А-Яа-яЁё]+ [А-Яа-яЁё]+$/u', $value))
        {
            return redirect()->route('test')->with('value', $value)->with('message', 'ФИО корректно');
        }
        else
        {
            return redirect()->route('test')->with('value', $value)->with('message', 'ФИО содержит запрещенные символы');
        }
    }
}
