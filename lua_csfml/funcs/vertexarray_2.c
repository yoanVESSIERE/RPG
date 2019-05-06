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

int vertexarray_get_bounds(lua_State *L)
{
    sfVertexArray *varray = 0;

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (VertexArray)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        varray = USERDATA_POINTER(L, 1, sfVertexArray);
        sfFloatRect rect = sfVertexArray_getBounds(varray);
        lua_pushnumber(L, rect.left);
        lua_pushnumber(L, rect.top);
        lua_pushnumber(L, rect.width);
        lua_pushnumber(L, rect.height);
    } else {
        luaL_error(L, "Expected (VertexArray)");
        return (0);
    }
    return (4);
}

char *primitive_type_to_char(sfPrimitiveType type)
{
    switch (type)
    {
        case sfLines: return "Lines";
        case sfQuads: return "Quads";
        case sfPoints: return "Points";
        case sfLinesStrip: return "LinesStrip";
        case sfTriangles: return "Triangles";
        case sfTrianglesStrip: return "TrianglesStrip";
        case sfTriangleFan: return "TriangleFan";
        default: return "";
    }
}

int vertexarray_get_primitive_type(lua_State *L)
{
    sfVertexArray *varray = 0;

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (VertexArray)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        varray = USERDATA_POINTER(L, 1, sfVertexArray);
        sfPrimitiveType type = sfVertexArray_getPrimitiveType(varray);
        lua_pushstring(L, primitive_type_to_char(type));
    } else {
        luaL_error(L, "Expected (VertexArray)");
        return (0);
    }
    return (1);
}

int vertexarray_get_vertex(lua_State *L)
{
    sfVertexArray *varray = 0;
    sfVertex **vertex = 0;

    if (lua_gettop(L) < 2) {
        luaL_error(L, "Expected (VertexArray, Index)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isinteger(L, 2)) {
        varray = USERDATA_POINTER(L, 1, sfVertexArray);
        if (lua_tointeger(L, 2) >= (int)sfVertexArray_getVertexCount(varray))
            return (0);
        vertex = (sfVertex **)lua_newuserdata(L, sizeof(sfVertex **));
        *vertex = sfVertexArray_getVertex(varray, lua_tointeger(L, 2));
    } else {
        luaL_error(L, "Expected (VertexArray, Number)");
        return (0);
    }
    return (1);
}

int vertexarray_get_vertex_count(lua_State *L)
{
    sfVertexArray *varray = 0;

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (VertexArray)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        varray = USERDATA_POINTER(L, 1, sfVertexArray);
        lua_pushinteger(L, sfVertexArray_getVertexCount(varray));
    } else {
        luaL_error(L, "Expected (VertexArray)");
        return (0);
    }
    return (1);
}