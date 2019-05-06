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

int vertex_destroy(lua_State *L)
{
    sfVertex *vertex = 0;

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (Vertex)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        vertex = USERDATA_POINTER(L, 1, sfVertex);
        free(vertex);
    } else {
        luaL_error(L, "Expected (Vertex)");
        return (0);
    }
    return (0);
}

int vertex_create(lua_State *L)
{
    sfVertex **vertex = 0;

    vertex = (sfVertex **)lua_newuserdata(L, sizeof(sfVertex **));
    *vertex = malloc(sizeof(vertex));
    (*vertex)->texCoords = (sfVector2f){0, 0};
    (*vertex)->position = (sfVector2f){0, 0};
    (*vertex)->color = (sfColor){0, 0, 0, 0};
    return (1);
}

int vertex_set_x(lua_State *L)
{
    sfVertex *vertex = 0;

    if (lua_gettop(L) < 2) {
        luaL_error(L, "Expected (Vertex, x)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isnumber(L, 2)) {
        vertex = USERDATA_POINTER(L, 1, sfVertex);
        vertex->position.x = lua_tonumber(L, 2);
    } else {
        luaL_error(L, "Expected (Vertex, Number)");
        return (0);
    }
    return (0);
}

int vertex_set_y(lua_State *L)
{
    sfVertex *vertex = 0;

    if (lua_gettop(L) < 2) {
        luaL_error(L, "Expected (Vertex, y)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isnumber(L, 2)) {
        vertex = USERDATA_POINTER(L, 1, sfVertex);
        vertex->position.y = lua_tonumber(L, 2);
    } else {
        luaL_error(L, "Expected (Vertex, Number)");
        return (0);
    }
    return (0);
}

int vertex_set_tx(lua_State *L)
{
    sfVertex *vertex = 0;

    if (lua_gettop(L) < 2) {
        luaL_error(L, "Expected (Vertex, TextureX)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isnumber(L, 2)) {
        vertex = USERDATA_POINTER(L, 1, sfVertex);
        vertex->texCoords.x = lua_tonumber(L, 2);
    } else {
        luaL_error(L, "Expected (Vertex, Number)");
        return (0);
    }
    return (0);
}