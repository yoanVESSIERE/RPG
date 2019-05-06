/*
** EPITECH PROJECT, 2019
** vertexarray
** File description:
** vertexarray
*/

#include "lua_include.h"
#include "utility.h"
#include <SFML/Graphics.h>
#include <SFML/Window.h>

int vertexarray_resize(lua_State *L)
{
    sfVertexArray *varray = 0;

    if (lua_gettop(L) < 2) {
        luaL_error(L, "Expected (VertexArray, Count)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isinteger(L, 2)) {
        varray = USERDATA_POINTER(L, 1, sfVertexArray);
        sfVertexArray_resize(varray, lua_tointeger(L, 2));
    } else {
        luaL_error(L, "Expected (VertexArray, Number)");
        return (0);
    }
    return (0);
}

int vertexarray_set_primitive_type(lua_State *L)
{
    sfVertexArray *varray = 0;

    if (lua_gettop(L) < 2) {
        luaL_error(L, "Expected (VertexArray, PrimitiveType)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isinteger(L, 2)) {
        varray = USERDATA_POINTER(L, 1, sfVertexArray);
        sfVertexArray_setPrimitiveType(varray, lua_tointeger(L, 2));
    } else {
        luaL_error(L, "Expected (VertexArray, String)");
        return (0);
    }
    return (0);
}