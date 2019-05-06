/*
** EPITECH PROJECT, 2019
** shader
** File description:
** shader
*/

#include "lua_include.h"
#include <SFML/Graphics.h>
#include <SFML/Window.h>

int shader_set_float3_parameter(lua_State *L)
{
    sfShader *shader = 0;

    if (lua_gettop(L) < 5) {
        luaL_error(L, "Expected (Shader, Name, x, y, z)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isstring(L, 2) &&
        lua_isnumber(L, 3) && lua_isnumber(L, 4) && lua_isnumber(L, 5)) {
        shader = USERDATA_POINTER(L, 1, sfShader);
        sfShader_setFloat3Parameter(shader, lua_tostring(L, 2),
        lua_tonumber(L, 3), lua_tonumber(L, 4), lua_tonumber(L, 5));
    } else {
        luaL_error(L, "Expected (Shader, String, Number, Number, Number)");
        return (0);
    }
    return (0);
}

int shader_set_float4_parameter(lua_State *L)
{
    sfShader *shader = 0;

    if (lua_gettop(L) < 6) {
        luaL_error(L, "Expected (Shader, Name, x, y, z, w)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isstring(L, 2) &&
        lua_isnumber(L, 3) && lua_isnumber(L, 4) && lua_isnumber(L, 5) &&
        lua_isnumber(L, 6)) {
        shader = USERDATA_POINTER(L, 1, sfShader);
        sfShader_setFloat4Parameter(shader, lua_tostring(L, 2),
        lua_tonumber(L, 3), lua_tonumber(L, 4), lua_tonumber(L, 5),
        lua_tonumber(L, 6));
    } else {
        luaL_error(L, "Expected (Shader, String, %s, %s, %s, %s)",
        "Number", "Number", "Number", "Number");
        return (0);
    }
    return (0);
}

int shader_set_float_parameter(lua_State *L)
{
    sfShader *shader = 0;

    if (lua_gettop(L) < 3) {
        luaL_error(L, "Expected (Shader, Name, Value)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isstring(L, 2) && lua_isnumber(L, 3)) {
        shader = USERDATA_POINTER(L, 1, sfShader);
        sfShader_setFloatParameter(shader, lua_tostring(L, 2),
        lua_tonumber(L, 3));
    } else {
        luaL_error(L, "Expected (Shader, String, Number)");
        return (0);
    }
    return (0);
}

int shader_setcurrenttextureparameter(lua_State *L)
{
    sfShader *shader = 0;

    if (lua_gettop(L) < 2) {
        luaL_error(L, "Expected (Shader, Name)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isstring(L, 2)) {
        shader = USERDATA_POINTER(L, 1, sfShader);
        sfShader_setCurrentTextureParameter(shader, lua_tostring(L, 2));
    } else {
        luaL_error(L, "Expected (Shader, String)");
        return (0);
    }
    return (0);
}

int shader_set_transform_parameter(lua_State *L)
{
    sfShader *shader = 0;
    sfTransform *transform = 0;

    if (lua_gettop(L) < 3) {
        luaL_error(L, "Expected (Shader, Name, Transform)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isstring(L, 2) && lua_isnumber(L, 3)) {
        shader = USERDATA_POINTER(L, 1, sfShader);
        transform = USERDATA_POINTER(L, 3, sfTransform);
        sfShader_setTransformParameter(shader, lua_tostring(L, 2),
        *transform);
    } else {
        luaL_error(L, "Expected (Shader, String, Transform)");
        return (0);
    }
    return (0);
}