/*
** EPITECH PROJECT, 2019
** event_function
** File description:
** event_function
*/

#include "lsfml.h"
#include <SFML/Window.h>
#include <SFML/Graphics.h>
#include <SFML/System.h>

int event_close(lua_State *L, sfEvent *event UNUSED)
{
    lua_pushstring(L, "close");
    return (1);
}

int event_lost_focus(lua_State *L, sfEvent *event UNUSED)
{
    lua_pushstring(L, "lost_focus");
    return (1);
}

int event_gained_focus(lua_State *L, sfEvent *event UNUSED)
{
    lua_pushstring(L, "gained_focus");
    return (1);
}

int event_text_entered(lua_State *L, sfEvent *event)
{
    const char txt[2] = {event->text.unicode, 0};

    lua_pushstring(L, "char");
    lua_pushstring(L, txt);
    return (2);
}

int event_keypressed(lua_State *L, sfEvent *event)
{
    lua_pushstring(L, "key_pressed");
    lua_pushinteger(L, event->key.code);
    lua_pushboolean(L, event->key.control);
    lua_pushboolean(L, event->key.shift);
    lua_pushboolean(L, event->key.alt);
    lua_pushboolean(L, event->key.system);
    return (6);
}