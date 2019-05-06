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

int text_get_scale(lua_State *L)
{
    sfText *text = 0;
    sfVector2f vector = {0, 0};

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (Text)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        text = USERDATA_POINTER(L, 1, sfText);
        vector = sfText_getPosition(text);
        lua_pushnumber(L, vector.x);
        lua_pushnumber(L, vector.y);
    } else {
        luaL_error(L, "Expected (Text)");
        return (0);
    }
    return (2);
}

int text_set_origin(lua_State *L)
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
        sfText_setOrigin(text, vector);
    } else {
        luaL_error(L, "Expected (Text, Table)");
        return (0);
    }
    return (0);
}

int text_get_rotation(lua_State *L)
{
    sfText *text = 0;
    double nb = 0.0;

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (Text)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        text = USERDATA_POINTER(L, 1, sfText);
        nb = sfText_getRotation(text);
        lua_pushnumber(L, nb);
    } else {
        luaL_error(L, "Expected (Text)");
        return (0);
    }
    return (1);
}

int text_set_string(lua_State *L)
{
    sfText *text = 0;
    const char *str = NULL;

    if (lua_gettop(L) < 2) {
        luaL_error(L, "Expected (Text, String)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isstring(L, 2)) {
        text = USERDATA_POINTER(L, 1, sfText);
        str = lua_tostring(L, 2);
        sfText_setString(text, str);
    } else {
        luaL_error(L, "Expected (Text, String)");
        return (0);
    }
    return (0);
}

int text_set_font(lua_State *L)
{
    sfText *text = 0;
    sfFont *font = 0;

    if (lua_gettop(L) < 2) {
        luaL_error(L, "Expected (Text, Font)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isuserdata(L, 2)) {
        text = USERDATA_POINTER(L, 1, sfText);
        font = USERDATA_POINTER(L, 2, sfFont);
        sfText_setFont(text, font);
    } else {
        luaL_error(L, "Expected (Text, Font)");
        return (0);
    }
    return (0);
}