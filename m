Content-Type: multipart/mixed; boundary="===============6479924198374876104=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 3/5] client: implement display_dictionary
Date: Thu, 21 Jan 2021 13:55:23 -0600
Message-ID: <a31fa910-e676-2190-a7f9-0fd4bd3d54f5@gmail.com>
In-Reply-To: <20210121181113.572092-3-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6479924198374876104==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 1/21/21 12:11 PM, James Prestwood wrote:
> This takes a Dbus iterator which has been entered into a
> dictionary and prints out each key and value. It requires
> a mapping which maps keys to types and units. For simple
> cases the mapping will consist of a dbus type character
> and a units string, e.g. dBm, Kbit/s etc. For more complex
> printing which requires processing the value the 'units'
> void* cant be set to a function which can be custom written
> to handle the value.
> ---
>   client/display.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++++
>   client/display.h | 22 ++++++++++++
>   2 files changed, 116 insertions(+)
> =

> v2:
>   * Generalized the printing of DBus dictionaries.
> =


<snip>

This looks good to me.  Question:

> +/*
> + * Maps dictionary keys to types/units. 'type' should be a valid DBus ty=
pe, or
> + * zero for displaying in a custom fashion. When the display needs to be
> + * customized 'units' should point to a custom display function of the f=
orm
> + * display_dict_custom_func_t which should display the entire value as w=
ell
> + * as any units required.
> + */
> +struct display_dict_mapping {
> +	const char *key;
> +	char type;
> +	void *units;

Can we use a union here to cut down on the casting?  Something like

union {
	const char *units;
	display_dict_custom_func_t custom;
};

> +};
>   =

Regards,
-Denis
--===============6479924198374876104==--

