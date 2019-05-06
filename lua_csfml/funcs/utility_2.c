/*
** EPITECH PROJECT, 2019
** utility_2
** File description:
** utility_2
*/

#include "lua_include.h"
#include <SFML/Graphics.h>
#include <SFML/Window.h>
#include "utility.h"

int lua_checktype(int (*func)(lua_State *, int), lua_State *L, int id)
{
    int state = func(L, id);

    lua_pop(L, 1);
    return (state);
}

int lua_isvertex2(lua_State *L, int index)
{
    lua_pushstring(L, "r");
    lua_gettable(L, index);
    if (!lua_checktype(lua_isinteger, L, -1)) return (0);
    lua_pushstring(L, "g");
    lua_gettable(L, index);
    if (!lua_checktype(lua_isinteger, L, -1)) return (0);
    lua_pushstring(L, "b");
    lua_gettable(L, index);
    if (!lua_checktype(lua_isinteger, L, -1)) return (0);
    lua_pushstring(L, "a");
    lua_gettable(L, index);
    if (!lua_checktype(lua_isinteger, L, -1)) return (0);
    return (1);
}

int lua_isvertex(lua_State *L, int index)
{
    lua_pushstring(L, "x");
    lua_gettable(L, index);
    if (!lua_checktype(lua_isnumber, L, -1)) return (0);
    lua_pushstring(L, "y");
    lua_gettable(L, index);
    if (!lua_checktype(lua_isnumber, L, -1)) return (0);
    lua_pushstring(L, "tx");
    lua_gettable(L, index);
    if (!lua_checktype(lua_isnumber, L, -1)) return (0);
    lua_pushstring(L, "ty");
    lua_gettable(L, index);
    if (!lua_checktype(lua_isnumber, L, -1)) return (0);
    return (lua_isvertex2(L, index));
}

void lua_tovertex2(lua_State *L, int index, sfVertex *vertex)
{

    lua_pushstring(L, "r");
    lua_gettable(L, index);
    vertex->color.r = lua_tointeger(L, -1);
    lua_pushstring(L, "g");
    lua_gettable(L, index);
    vertex->color.g = lua_tointeger(L, -2);
    lua_pushstring(L, "b");
    lua_gettable(L, index);
    vertex->color.b = lua_tointeger(L, -1);
    lua_pushstring(L, "a");
    lua_gettable(L, index);
    vertex->color.a = lua_tointeger(L, -2);
}

sfVertex lua_tovertex(lua_State *L, int index)
{
    sfVertex vertex;

    lua_pushstring(L, "x");
    lua_gettable(L, index);
    vertex.position.x = lua_tonumber(L, -1);
    lua_pushstring(L, "y");
    lua_gettable(L, index);
    vertex.position.y = lua_tonumber(L, -1);
    lua_pushstring(L, "tx");
    lua_gettable(L, index);
    vertex.texCoords.x = lua_tonumber(L, -1);
    lua_pushstring(L, "ty");
    lua_gettable(L, index);
    vertex.texCoords.x = lua_tonumber(L, -1);
    lua_tovertex2(L, index, &vertex);
    return (vertex);
}