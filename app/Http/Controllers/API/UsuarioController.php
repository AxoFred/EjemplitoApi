<?php
namespace App\Http\Controllers\API;

use App\Models\Usuario;
use App\Models\UsuarioRol;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class UsuarioController extends Controller
{
    // LISTAR TODOS
    public function index()
    {
        return response()->json(Usuario::with('roles')->get(), 200);
    }

    // CREAR
    public function store(Request $request)
    {
        $usuario = Usuario::create($request->all());

        return response()->json([
            'message' => 'Usuario creado',
            'data' => $usuario
        ], 201);
    }

    // MOSTRAR 
    public function show($id)
    {
        return response()->json(
            Usuario::with('roles')->findOrFail($id)
        );
    }

    // ACTUALIZAR
    public function update(Request $request, $id)
    {
        $usuario = Usuario::findOrFail($id);
        $usuario->update($request->all());

        return response()->json([
            'message' => 'Usuario actualizado'
        ]);
    }

    // ELIMINAR
    public function destroy($id)
    {
        UsuarioRol::where('usuario_id', $id)->delete();

        $usuario = Usuario::findOrFail($id);
        $usuario->delete();

        return response()->json([
            'message' => 'Usuario eliminado'
        ]);
    }
}
