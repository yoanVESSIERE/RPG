/*
** EPITECH PROJECT, 2019
** shader
** File description:
** shader
*/

#include "lua_include.h"
#include <SFML/Graphics.h>
#include <SFML/Window.h>

int lua_iscolor(lua_State *L, int index)
{
    lua_pushinteger(L, 1);
    lua_gettable(L, index);
    if (!lua_isinteger(L, -1)) return (0);
    lua_pushinteger(L, 2);
    lua_gettable(L, index);
    if (!lua_isinteger(L, -1)) return (0);
    lua_pushinteger(L, 3);
    lua_gettable(L, index);
    if (!lua_isinteger(L, -1)) return (0);
    lua_pushinteger(L, 4);
    lua_gettable(L, index);
    if (!lua_isinteger(L, -1)) return (0);
    return (1);
}

sfColor lua_tocolor(lua_State *L, int index)
{
    sfColor color;

    lua_pushinteger(L, 1);
    lua_gettable(L, index);
    color.r = lua_tointeger(L, -1);
    lua_pushinteger(L, 2);
    lua_gettable(L, index);
    color.g = lua_tointeger(L, -1);
    lua_pushinteger(L, 3);
    lua_gettable(L, index);
    color.b = lua_tointeger(L, -1);
    lua_pushinteger(L, 4);
    lua_gettable(L, index);
    color.a = lua_tointeger(L, -1);
    return (color);
}

int shader_set_color_parameter(lua_State *L)
{
    sfShader *shader = 0;

    if (lua_gettop(L) < 3) {
        luaL_error(L, "Expected (Shader, Name, Color)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isstring(L, 2) &&
        lua_istable(L, 3) && lua_iscolor(L, 3)) {
        shader = USERDATA_POINTER(L, 1, sfShader);
        sfShader_setColorParameter(shader, lua_tostring(L, 2),
        lua_tocolor(L, 3));
    } else {
        luaL_error(L, "Expected (Shader, String, Color)");
        return (0);
    }
    return (0);
}

int shader_set_texture_parameter(lua_State *L)
{
    sfShader *shader = 0;
    sfTexture *texture = 0;

    if (lua_gettop(L) < 3) {
        luaL_error(L, "Expected (Shader, Name, Texture)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isstring(L, 2) && lua_isuserdata(L, 3)) {
        shader = USERDATA_POINTER(L, 1, sfShader);
        texture = USERDATA_POINTER(L, 2, sfTexture);
        sfShader_setTextureParameter(shader, lua_tostring(L, 2),
        texture);
    } else {
        luaL_error(L, "Expected (Shader, String, Texture)");
        return (0);
    }
    return (0);
}

int shader_set_float2_parameter(lua_State *L)
{
    sfShader *shader = 0;

    if (lua_gettop(L) < 4) {
        luaL_error(L, "Expected (Shader, Name, x, y)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isstring(L, 2) &&
        lua_isnumber(L, 3) && lua_isnumber(L, 4)) {
        shader = USERDATA_POINTER(L, 1, sfShader);
        sfShader_setFloat2Parameter(shader, lua_tostring(L, 2),
        lua_tonumber(L, 3), lua_tonumber(L, 4));
    } else {
        luaL_error(L, "Expected (Shader, String, Number, Number)");
        return (0);
    }
    return (0);
}