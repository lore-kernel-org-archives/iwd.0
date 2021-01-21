Content-Type: multipart/mixed; boundary="===============1402241015440611678=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [PATCH v2 3/5] client: implement display_dictionary
Date: Thu, 21 Jan 2021 11:58:04 -0800
Message-ID: <4bd022dbbb2500365a6bd6e16883ff551fa6ac02.camel@gmail.com>
In-Reply-To: <a31fa910-e676-2190-a7f9-0fd4bd3d54f5@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1402241015440611678==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> > +/*
> > + * Maps dictionary keys to types/units. 'type' should be a valid
> > DBus type, or
> > + * zero for displaying in a custom fashion. When the display needs
> > to be
> > + * customized 'units' should point to a custom display function of
> > the form
> > + * display_dict_custom_func_t which should display the entire
> > value as well
> > + * as any units required.
> > + */
> > +struct display_dict_mapping {
> > +	const char *key;
> > +	char type;
> > +	void *units;
> =

> Can we use a union here to cut down on the casting?  Something like
> =

> union {
> 	const char *units;
> 	display_dict_custom_func_t custom;
> };

Sure. This is much more intuative as well.

Thanks,
James
> =

> > +};
> >   =

> Regards,
> -Denis

--===============1402241015440611678==--

