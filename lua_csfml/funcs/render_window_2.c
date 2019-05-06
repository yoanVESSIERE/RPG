/*
** EPITECH PROJECT, 2019
** render_window_2
** File description:
** render_window_2
*/

#include "lua_include.h"
#include <SFML/Graphics.h>
#include <SFML/Window.h>

int win_draw_vertex_array(lua_State *L)
{
    sfRenderWindow *window = 0;
    sfVertexArray *vertexs = 0;
    sfRenderStates *state = 0;

    if (lua_gettop(L) < 3) {
        luaL_error(L, "Expected (Window, VertexArray, RenderStates)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isuserdata(L, 2) &&
        (lua_isnil(L, 3) || lua_isuserdata(L, 3))) {
        window = USERDATA_POINTER(L, 1, sfRenderWindow);
        vertexs = USERDATA_POINTER(L, 2, sfVertexArray);
        state = lua_isnil(L, 3) ? 0 : USERDATA_POINTER(L, 3, sfRenderStates);
        sfRenderWindow_drawVertexArray(window, vertexs, state);
    } else {
        luaL_error(L, "Expected (Window, VertexArray, RenderStates)");
        return (0);
    }
    return (0);
}

int win_draw_rectangle_shape(lua_State *L)
{
    sfRenderWindow *window = 0;
    sfRectangleShape *rect = 0;
    sfRenderStates *state = 0;

    if (lua_gettop(L) < 3) {
        luaL_error(L, "Expected (Window, RectangleShape, RenderStates)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isuserdata(L, 2) &&
        (lua_isnil(L, 3) || lua_isuserdata(L, 3))) {
        window = USERDATA_POINTER(L, 1, sfRenderWindow);
        rect = USERDATA_POINTER(L, 2, sfRectangleShape);
        state = lua_isnil(L, 3) ? 0 : USERDATA_POINTER(L, 3, sfRenderStates);
        sfRenderWindow_drawRectangleShape(window, rect, state);
    } else {
        luaL_error(L, "Expected (Window, RectangleShape, RenderStates)");
        return (0);
    }
    return (0);
}

int win_draw_shape(lua_State *L)
{
    sfRenderWindow *window = 0;
    sfShape *shape = 0;
    sfRenderStates *state = 0;

    if (lua_gettop(L) < 3) {
        luaL_error(L, "Expected (Window, Shape, RenderStates)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isuserdata(L, 2) &&
        (lua_isnil(L, 3) || lua_isuserdata(L, 3))) {
        window = USERDATA_POINTER(L, 1, sfRenderWindow);
        shape = USERDATA_POINTER(L, 2, sfShape);
        state = lua_isnil(L, 3) ? 0 : USERDATA_POINTER(L, 3, sfRenderStates);
        sfRenderWindow_drawShape(window, shape, state);
    } else {
        luaL_error(L, "Expected (Window, Shape, RenderStates)");
        return (0);
    }
    return (0);
}

int win_draw_sprite(lua_State *L)
{
    sfRenderWindow *window = 0;
    sfSprite *sprite = 0;
    sfRenderStates *state = 0;

    if (lua_gettop(L) < 3) {
        luaL_error(L, "Expected (Window, Sprite, RenderStates)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isuserdata(L, 2) &&
        (lua_isnil(L, 3) || lua_isuserdata(L, 3))) {
        window = USERDATA_POINTER(L, 1, sfRenderWindow);
        sprite = USERDATA_POINTER(L, 2, sfSprite);
        state = lua_isnil(L, 3) ? 0 : USERDATA_POINTER(L, 3, sfRenderStates);
        sfRenderWindow_drawSprite(window, sprite, state);
    } else {
        luaL_error(L, "Expected (Window, Sprite, RenderStates)");
        return (0);
    }
    return (0);
}

int win_draw_text(lua_State *L)
{
    sfRenderWindow *window = 0;
    sfText *text = 0;
    sfRenderStates *state = 0;

    if (lua_gettop(L) < 3) {
        luaL_error(L, "Expected (Window, Text, RenderStates)");
        return (0);
    }
    if (lua_isuserdata(L, 1) && lua_isuserdata(L, 2) &&
        (lua_isnil(L, 3) || lua_isuserdata(L, 3))) {
        window = USERDATA_POINTER(L, 1, sfRenderWindow);
        text = USERDATA_POINTER(L, 2, sfText);
        state = lua_isnil(L, 3) ? 0 : USERDATA_POINTER(L, 3, sfRenderStates);
        sfRenderWindow_drawText(window, text, state);
    } else {
        luaL_error(L, "Expected (Window, Text, RenderStates)");
        return (0);
    }
    return (0);
}