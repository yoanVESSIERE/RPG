/*
** EPITECH PROJECT, 2019
** render_window
** File description:
** render_window
*/

#include "lua_include.h"
#include <SFML/Graphics.h>
#include <SFML/Window.h>

int win_clear(lua_State *L)
{
    sfRenderWindow *window = 0;

    if (lua_gettop(L) < 4) {
        luaL_error(L, "Expected (Window, Number, Number, Number)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isinteger(L, 2) &&
        lua_isinteger(L, 3) && lua_isinteger(L, 4)) {
        window = USERDATA_POINTER(L, 1, sfRenderWindow);
        sfRenderWindow_clear(window,
        (sfColor){lua_tointeger(L, 2), lua_tointeger(L, 3),
        lua_tointeger(L, 4), 255});
    } else {
        luaL_error(L, "Expected (Window, Number, Number, Number)");
        return (0);
    }
    return (0);
}

int win_cursor_visible(lua_State *L)
{
    sfRenderWindow *window = 0;

    if (lua_gettop(L) < 2) {
        luaL_error(L, "Expected (Window, Boolean)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isboolean(L, 2)) {
        window = USERDATA_POINTER(L, 1, sfRenderWindow);
        sfRenderWindow_setMouseCursorVisible(window, lua_toboolean(L, 2));
    } else {
        luaL_error(L, "Expected (Window, Boolean)");
        return (0);
    }
    return (0);
}

int win_close(lua_State *L)
{
    sfRenderWindow *window = 0;

    if (lua_gettop(L) < 1) {
        luaL_error(L, "Expected (Window)");
        return (0);
    }
    if (lua_isuserdata(L, 1)) {
        window = USERDATA_POINTER(L, 1, sfRenderWindow);
        sfRenderWindow_close(window);
    } else {
        luaL_error(L, "Expected (Window)");
        return (0);
    }
    return (0);
}

int win_draw_circle_shape(lua_State *L)
{
    sfRenderWindow *window = 0;
    sfCircleShape *circle = 0;
    sfRenderStates *state = 0;

    if (lua_gettop(L) < 3) {
        luaL_error(L, "Expected (Window, CircleShape, RenderStates)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isuserdata(L, 2) &&
        (lua_isnil(L, 3) || lua_isuserdata(L, 3))) {
        window = USERDATA_POINTER(L, 1, sfRenderWindow);
        circle = USERDATA_POINTER(L, 2, sfCircleShape);
        state = lua_isnil(L, 3) ? 0 : USERDATA_POINTER(L, 3, sfRenderStates);
        sfRenderWindow_drawCircleShape(window, circle, state);
    } else {
        luaL_error(L, "Expected (Window, CircleShape, RenderStates)");
        return (0);
    }
    return (0);
}

int win_draw_convex_shape(lua_State *L)
{
    sfRenderWindow *window = 0;
    sfConvexShape *convex = 0;
    sfRenderStates *state = 0;

    if (lua_gettop(L) < 3) {
        luaL_error(L, "Expected (Window, ConvexShape, RenderStates)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isuserdata(L, 2) &&
        (lua_isnil(L, 3) || lua_isuserdata(L, 3))) {
        window = USERDATA_POINTER(L, 1, sfRenderWindow);
        convex = USERDATA_POINTER(L, 2, sfConvexShape);
        state = lua_isnil(L, 3) ? 0 : USERDATA_POINTER(L, 3, sfRenderStates);
        sfRenderWindow_drawConvexShape(window, convex, state);
    } else {
        luaL_error(L, "Expected (Window, ConvexShape, RenderStates)");
        return (0);
    }
    return (0);
}