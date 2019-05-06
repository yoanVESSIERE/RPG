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

int vertexarray_append(lua_State *L)
{
    sfVertexArray *varray = 0;

    if (lua_gettop(L) < 2) {
        luaL_error(L, "Expected (VertexArray, Vertex)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_istable(L, 2) && lua_isvertex(L, 2)) {
        varray = USERDATA_POINTER(L, 1, sfVertexArray);
        sfVertexArray_append(varray, lua_tovertex(L, 2));
    } else {
        luaL_error(L, "Expected (VertexArray, Table)");
        return (0);
    }
    return (0);
}

int vertexarray_clear(lua_State *L)
{
    sfVertexArray *varray = 0;

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (VertexArray)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        varray = USERDATA_POINTER(L, 1, sfVertexArray);
        sfVertexArray_clear(varray);
    } else {
        luaL_error(L, "Expected (VertexArray)");
        return (0);
    }
    return (0);
}

int vertexarray_copy(lua_State *L)
{
    sfVertexArray *varray = 0;
    sfVertexArray **new = 0;

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (VertexArray)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        varray = USERDATA_POINTER(L, 1, sfVertexArray);
        new = (sfVertexArray **)lua_newuserdata(L, sizeof(sfVertexArray **));
        *new = sfVertexArray_copy(varray);
    } else {
        luaL_error(L, "Expected (VertexArray)");
        return (0);
    }
    return (1);
}

int vertexarray_create(lua_State *L)
{
    sfVertexArray **new = 0;

    new = (sfVertexArray **)lua_newuserdata(L, sizeof(sfVertexArray **));
    *new = sfVertexArray_create();
    return (1);
}

int vertexarray_destroy(lua_State *L)
{
    sfVertexArray *varray = 0;

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (VertexArray)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        varray = USERDATA_POINTER(L, 1, sfVertexArray);
        sfVertexArray_destroy(varray);
    } else {
        luaL_error(L, "Expected (VertexArray)");
        return (0);
    }
    return (0);
}
