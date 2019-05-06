/*
** EPITECH PROJECT, 2019
** sprite
** File description:
** sprite
*/

#include "lua_include.h"
#include <SFML/Graphics.h>
#include <SFML/Window.h>

int get_vector_2f(lua_State *L, sfVector2f *vector, int index)
{
    lua_pushstring(L, "x");
    lua_gettable(L, index);
    if (!lua_isnumber(L, -1)) {
        luaL_error(L, "x must be a number");
        return (0);
    }
    vector->x = lua_tonumber(L, -1);
    lua_pushstring(L, "y");
    lua_gettable(L, index);
    if (!lua_isnumber(L, -1)) {
        luaL_error(L, "y must be a number");
        return (0);
    }
    vector->y = lua_tonumber(L, -1);
    return (1);
}

int get_int_rect_2(lua_State *L, sfIntRect *rect, int index)
{
    lua_pushstring(L, "width");
    lua_gettable(L, index);
    if (!lua_isinteger(L, -1)) {
        luaL_error(L, "width must be a number");
        return (0);
    }
    rect->width = lua_tointeger(L, -1);
    lua_pushstring(L, "height");
    lua_gettable(L, index);
    if (!lua_isinteger(L, -1)) {
        luaL_error(L, "height must be a number");
        return (0);
    }
    rect->height = lua_tointeger(L, -1);
    return (1);
}

int get_int_rect(lua_State *L, sfIntRect *rect, int index)
{
    lua_pushstring(L, "x");
    lua_gettable(L, index);
    if (!lua_isinteger(L, -1)) {
        luaL_error(L, "x must be a number");
        return (0);
    }
    rect->left = lua_tointeger(L, -1);
    lua_pushstring(L, "y");
    lua_gettable(L, index);
    if (!lua_isinteger(L, -1)) {
        luaL_error(L, "y must be a number");
        return (0);
    }
    rect->top = lua_tointeger(L, -1);
    return (get_int_rect_2(L, rect, index));
}

int get_vector_3f(lua_State *L, sfVector3f *vector, int index)
{
    sfVector2f vec = {0, 0};

    get_vector_2f(L, &vec, index);
    vector->x = vec.x;
    vector->y = vec.y;
    lua_pushstring(L, "z");
    lua_gettable(L, index);
    if (lua_isnumber(L, -1)) {
        luaL_error(L, "z must be a number");
        return (0);
    }
    vector->z = lua_tonumber(L, -1);
    return (1);
}