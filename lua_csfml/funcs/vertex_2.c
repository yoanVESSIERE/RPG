/*
** EPITECH PROJECT, 2019
** vertex
** File description:
** vertex
*/

#include "lua_include.h"
#include "utility.h"
#include <SFML/Graphics.h>
#include <SFML/Window.h>

int vertex_set_ty(lua_State *L)
{
    sfVertex *vertex = 0;

    if (lua_gettop(L) < 2) {
        luaL_error(L, "Expected (Vertex, TextureY)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isnumber(L, 2)) {
        vertex = USERDATA_POINTER(L, 1, sfVertex);
        vertex->texCoords.y = lua_tonumber(L, 2);
    } else {
        luaL_error(L, "Expected (Vertex, Number)");
        return (0);
    }
    return (0);
}

int vertex_set_r(lua_State *L)
{
    sfVertex *vertex = 0;

    if (lua_gettop(L) < 2) {
        luaL_error(L, "Expected (Vertex, ColorChannelR)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isinteger(L, 2)) {
        vertex = USERDATA_POINTER(L, 1, sfVertex);
        vertex->color.r = lua_tointeger(L, 2);
    } else {
        luaL_error(L, "Expected (Vertex, Number)");
        return (0);
    }
    return (0);
}

int vertex_set_g(lua_State *L)
{
    sfVertex *vertex = 0;

    if (lua_gettop(L) < 2) {
        luaL_error(L, "Expected (Vertex, ColorChannelG)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isinteger(L, 2)) {
        vertex = USERDATA_POINTER(L, 1, sfVertex);
        vertex->color.g = lua_tointeger(L, 2);
    } else {
        luaL_error(L, "Expected (Vertex, Number)");
        return (0);
    }
    return (0);
}

int vertex_set_b(lua_State *L)
{
    sfVertex *vertex = 0;

    if (lua_gettop(L) < 2) {
        luaL_error(L, "Expected (Vertex, ColorChannelB)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isinteger(L, 2)) {
        vertex = USERDATA_POINTER(L, 1, sfVertex);
        vertex->color.b = lua_tointeger(L, 2);
    } else {
        luaL_error(L, "Expected (Vertex, Number)");
        return (0);
    }
    return (0);
}

int vertex_set_a(lua_State *L)
{
    sfVertex *vertex = 0;

    if (lua_gettop(L) < 2) {
        luaL_error(L, "Expected (Vertex, ColorChannelA)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isinteger(L, 2)) {
        vertex = USERDATA_POINTER(L, 1, sfVertex);
        vertex->color.a = lua_tointeger(L, 2);
    } else {
        luaL_error(L, "Expected (Vertex, Number)");
        return (0);
    }
    return (0);
}