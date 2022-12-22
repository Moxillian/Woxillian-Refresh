name = "Woxillian the Bunny!"
description = "A magical being with tricks up his sleeve!"
author = "CarlosBraw, CripCropp, Spirit, Lavu & Moxillian"
version = "0.38"

api_version = 10

dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = false
all_clients_require_mod = true
forge_compatible = false

icon_atlas = "modicon.xml"
icon = "modicon.tex"

priority = -15

server_filter_tags = {"characters"}

configuration_options =
{
    {
        name = "WOXHEALTH",
        label = "Woxillian's health",
        options = {
            {description = "100", data = 100},
            {description = "125", data = 125},
			{description = "150", data = 150},
        },
        default = 125,
    },
    {
        name = "WOXHUNGER",
        label = "Woxillian's hunger",
        options = {
            {description = "150", data = 150},
            {description = "175", data = 175},
			{description = "200", data = 200},
        },
        default = 175,
    },
    {
        name = "WOXSANITY",
        label = "Woxillian's health",
        options = {
            {description = "150", data = 150},
            {description = "200", data = 200},
			{description = "250", data = 250},
        },
        default = 200,
    },
    {
        name = "WOXDAMAGE",
        label = "Woxillian's shadow damage",
        options = {
			{description = "125%", data = 1.25},
            {description = "150%", data = 1.5},
            {description = "175%", data = 1.75},
        },
        default = 1.5,
    },
    {
        name = "WOXEFFECIENCY",
        label = "Woxillian's weapon efficiency",
        options = {
			{description = "67%", data = 2/3},
            {description = "100%", data = 1},
            {description = "133%", data = 4/3},
        },
        default = 2/3,
    },
    {
        name = "WOXWANDA",
        label = "Woxillian can use Wanda's clocks",
        options = {
            {description = "Yes", data = true},
            {description = "No", data = false},
        },
        default = false,
    },
}