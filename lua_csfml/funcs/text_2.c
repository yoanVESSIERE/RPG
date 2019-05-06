/*
** EPITECH PROJECT, 2019
** text
** File description:
** text
*/

#include "lua_include.h"
#include <SFML/Graphics.h>
#include <SFML/Window.h>
#include "utility.h"

int text_move(lua_State *L)
{
    sfText *text = 0;
    sfVector2f vector = {0, 0};

    if (lua_gettop(L) < 2) {
        luaL_error(L, "Expected (Text, Vector2f)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_istable(L, 2)) {
        text = USERDATA_POINTER(L, 1, sfText);
        if (!get_vector_2f(L, &vector, 2))
            return (0);
        sfText_move(text, vector);
    } else {
        luaL_error(L, "Expected (Text, Table)");
        return (0);
    }
    return (0);
}

int text_rotate(lua_State *L)
{
    sfText *text = 0;
    double nb = 0.0;

    if (lua_gettop(L) < 3) {
        luaL_error(L, "Expected (Text, Rotation)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isnumber(L, 2)) {
        text = USERDATA_POINTER(L, 1, sfText);
        nb = lua_tonumber(L, 3);
        sfText_rotate(text, nb);
    } else {
        luaL_error(L, "Expected (Text, Float)");
        return (0);
    }
    return (0);
}

int text_scale(lua_State *L)
{
    sfText *text = 0;
    sfVector2f vector = {0, 0};

    if (lua_gettop(L) < 2) {
        luaL_error(L, "Expected (Text, Vector2f)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_istable(L, 2)) {
        text = USERDATA_POINTER(L, 1, sfText);
        if (!get_vector_2f(L, &vector, 2))
            return (0);
        sfText_scale(text, vector);
    } else {
        luaL_error(L, "Expected (Text, Table)");
        return (0);
    }
    return (0);
}

int text_set_rotation(lua_State *L)
{
    sfText *text = 0;
    double nb = 0.0;

    if (lua_gettop(L) < 3) {
        luaL_error(L, "Expected (Text, Rotation)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isnumber(L, 2)) {
        text = USERDATA_POINTER(L, 1, sfText);
        nb = lua_tonumber(L, 3);
        sfText_setRotation(text, nb);
    } else {
        luaL_error(L, "Expected (Text, Float)");
        return (0);
    }
    return (0);
}

int text_get_origin(lua_State *L)
{
    sfText *text = 0;
    sfVector2f vector = {0, 0};

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (Text)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        text = USERDATA_POINTER(L, 1, sfText);
        vector = sfText_getOrigin(text);
        lua_pushnumber(L, vector.x);
        lua_pushnumber(L, vector.y);
    } else {
        luaL_error(L, "Expected (Text)");
        return (0);
    }
    return (2);
}