/*
** EPITECH PROJECT, 2019
** render_window
** File description:
** render_window
*/

#include "lua_include.h"
#include <SFML/Graphics.h>
#include <SFML/Window.h>

int win_get_size(lua_State *L)
{
    sfRenderWindow *window = 0;
    sfVector2u vector = {0, 0};

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (Window)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        window = USERDATA_POINTER(L, 1, sfRenderWindow);
        vector = sfWindow_getSize((sfWindow *)window);
        lua_pushnumber(L, vector.x);
        lua_pushnumber(L, vector.y);
    } else {
        luaL_error(L, "Expected (Window)");
        return (0);
    }
    return (2);
}

int win_set_framerate_limit(lua_State *L)
{
    sfRenderWindow *window = 0;
    int fps = 0;

    if (lua_gettop(L) < 2) {
        luaL_error(L, "Expected (Window, Number)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isinteger(L, 2)) {
        window = USERDATA_POINTER(L, 1, sfRenderWindow);
        fps = lua_tointeger(L, 2);
        sfRenderWindow_setFramerateLimit(window, fps);
    } else {
        luaL_error(L, "Expected (Window, Number)");
        return (0);
    }
    return (0);
}

int win_set_mouse_cursor_grabbed(lua_State *L)
{
    sfRenderWindow *window = 0;

    if (lua_gettop(L) < 2) {
        luaL_error(L, "Expected (Window, Boolean)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isboolean(L, 2)) {
        window = USERDATA_POINTER(L, 1, sfRenderWindow);
        sfRenderWindow_setMouseCursorGrabbed(window, lua_toboolean(L, 2));
    } else {
        luaL_error(L, "Expected (Window, Boolean)");
        return (0);
    }
    return (0);
}