/*
** EPITECH PROJECT, 2019
** mouse
** File description:
** mouse
*/

#include "lua_include.h"
#include "utility.h"
#include <SFML/Graphics.h>
#include <SFML/Window.h>

int mouse_get_position(lua_State *L)
{
    sfRenderWindow *window = 0;
    sfVector2i pos;

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (Window)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        window = USERDATA_POINTER(L, 1, sfRenderWindow);
        pos = sfMouse_getPositionRenderWindow(window);
        lua_pushinteger(L, pos.x);
        lua_pushinteger(L, pos.y);
    } else {
        luaL_error(L, "Expected (Window)");
        return (0);
    }
    return (2);
}

int mouse_set_position(lua_State *L)
{
    sfRenderWindow *window = 0;

    if (lua_gettop(L) < 3) {
        luaL_error(L, "Expected (Window, x, y)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isinteger(L, 2) && lua_isinteger(L, 3)) {
        window = USERDATA_POINTER(L, 1, sfRenderWindow);
        sfMouse_setPositionRenderWindow((sfVector2i){lua_tointeger(L, 2),
        lua_tointeger(L, 3)}, window);
    } else {
        luaL_error(L, "Expected (Window, Number, Number)");
        return (0);
    }
    return (0);
}

int mouse_is_button_pressed(lua_State *L)
{
    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (MouseButton)");
        return (0);
    }
    if (lua_isinteger(L, 1)) {
        lua_pushboolean(L, sfMouse_isButtonPressed(lua_tointeger(L, 1)));
    } else {
        luaL_error(L, "Expected (Number)");
        return (0);
    }
    return (1);
}
