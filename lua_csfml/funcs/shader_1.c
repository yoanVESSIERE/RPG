/*
** EPITECH PROJECT, 2019
** shader
** File description:
** shader
*/

#include "lua_include.h"
#include <SFML/Graphics.h>
#include <SFML/Window.h>

int shader_bind(lua_State *L)
{
    sfShader *shader = 0;

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (Shader)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        shader = USERDATA_POINTER(L, 1, sfShader);
        sfShader_bind(shader);
    } else {
        luaL_error(L, "Expected (Shader)");
        return (0);
    }
    return (0);
}

int shader_create_from_file(lua_State *L)
{
    sfShader *shader = 0;
    sfShader **mshader = 0;

    if (lua_gettop(L) < 2) {
        luaL_error(L, "Expected (VertexShader, FragmentShader)");
        return (0);
    }
    if (lua_isstring(L, 1) && lua_isstring(L, 2)) {
        shader = sfShader_createFromFile(lua_tostring(L, 1),
        0, lua_tostring(L, 2));
        mshader = (sfShader **)lua_newuserdata(L, sizeof(sfShader **));
        *mshader = shader;
    } else {
        luaL_error(L, "Expected (String, String)");
        return (0);
    }
    return (0);
}

int shader_create_from_memory(lua_State *L)
{
    sfShader *shader = 0;
    sfShader **mshader = 0;

    if (lua_gettop(L) < 2) {
        luaL_error(L, "Expected (VertexShader, FragmentShader)");
        return (0);
    }
    if (lua_isstring(L, 1) && lua_isstring(L, 2)) {
        shader = sfShader_createFromMemory(lua_tostring(L, 1),
        0, lua_tostring(L, 2));
        mshader = (sfShader **)lua_newuserdata(L, sizeof(sfShader **));
        *mshader = shader;
    } else {
        luaL_error(L, "Expected (String, String)");
        return (0);
    }
    return (1);
}

int shader_destroy(lua_State *L)
{
    sfShader *shader = 0;

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (Shader)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        shader = USERDATA_POINTER(L, 1, sfShader);
        sfShader_destroy(shader);
    } else {
        luaL_error(L, "Expected (Shader)");
        return (0);
    }
    return (0);
}

int shader_is_available(lua_State *L)
{
    lua_pushboolean(L, sfShader_isAvailable());
    return (1);
}
