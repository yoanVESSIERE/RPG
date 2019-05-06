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

int get_event(lua_State *L, sfEvent *event)
{
    switch (event->type)
    {
        case sfEvtClosed: return event_close(L, event);
        case sfEvtLostFocus: return event_lost_focus(L, event);
        case sfEvtGainedFocus: return event_gained_focus(L, event);
        case sfEvtTextEntered: return event_text_entered(L, event);
        case sfEvtKeyPressed: return event_keypressed(L, event);
        case sfEvtKeyReleased: return event_keyreleased(L, event);
        case sfEvtMouseWheelScrolled: return event_mouse_scroll(L, event);
        case sfEvtMouseButtonPressed: return event_button_pressed(L, event);
        case sfEvtMouseButtonReleased: return event_button_released(L, event);
        case sfEvtMouseMoved: return event_mouse_move(L, event);
        case sfEvtMouseEntered: return event_mouse_entered(L, event);
        case sfEvtMouseLeft: return event_mouse_left(L, event);
        default: return (0);
    }
}