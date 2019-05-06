/*
** EPITECH PROJECT, 2019
** event
** File description:
** event
*/

#include "lsfml.h"
#include <SFML/Window.h>
#include <SFML/Graphics.h>
#include <SFML/System.h>
#include "engine.h"

int event_mouse_scroll(lua_State *L, sfEvent *event)
{
    lua_pushstring(L, "mouse_scroll");
    lua_pushinteger(L, event->mouseWheelScroll.x);
    lua_pushinteger(L, event->mouseWheelScroll.y);
    lua_pushnumber(L, event->mouseWheelScroll.delta);
    return (4);
}

int event_button_pressed(lua_State *L, sfEvent *event)
{
    lua_pushstring(L, "mouse_pressed");
    lua_pushinteger(L, event->mouseButton.x);
    lua_pushinteger(L, event->mouseButton.y);
    lua_pushinteger(L, event->mouseButton.button);
    return (4);
}

int event_button_released(lua_State *L, sfEvent *event)
{
    lua_pushstring(L, "mouse_released");
    lua_pushinteger(L, event->mouseButton.x);
    lua_pushinteger(L, event->mouseButton.y);
    lua_pushinteger(L, event->mouseButton.button);
    return (4);
}

int event_mouse_move(lua_State *L, sfEvent *event)
{
    lua_pushstring(L, "mouse_move");
    lua_pushinteger(L, event->mouseMove.x);
    lua_pushinteger(L, event->mouseMove.y);
    return (3);
}

int event_mouse_entered(lua_State *L, sfEvent *event UNUSED)
{
    lua_pushstring(L, "mouse_entered");
    return (1);
}