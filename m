Content-Type: multipart/mixed; boundary="===============7330833567477447610=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [PATCH 2/5] storage: add storage_get_ap_path
Date: Fri, 30 Oct 2020 11:48:55 -0700
Message-ID: <fedf9f52e015a2d323fd07b798c43a30b445e96a.camel@gmail.com>
In-Reply-To: <aac22e4c-862a-57f5-5f28-7afad5aa9296@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7330833567477447610==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> >   =

> > +char *storage_get_ap_path(const char *format, ...)
> > +{
> > +	va_list args;
> > +	char *fmt, *str;
> > +
> > +	if (!format)
> > +		return l_strdup(storage_ap_path);
> > +
> > +	fmt =3D l_strdup_printf("%s/%s", storage_ap_path, format);
> > +
> > +	va_start(args, format);
> > +	str =3D l_strdup_vprintf(fmt, args);
> > +	va_end(args);
> > +
> > +	l_free(fmt);
> > +	return str;
> > +}
> > +
> =

> I think this really isn't necessary, you could use storage_get_path
> for this =

> just as well.  Or just return storage_ap_path which is all you're
> using this for.
> =

> The more useful thing might be to actually obtain the AP path given
> an SSID...

Yeah I was just copying the way network/hotspot did it. But yes your
right, its rather complex for the one or two places it would be used.
And even getting the AP path + SSID should be easy enough:

path =3D storage_get_path("ap/%s", ssid);

I could also refactor hotspot to do this as well at some point.

> =

> >   char *storage_get_network_file_path(enum security type, const
> > char *ssid)
> >   {
> >   	char *path;
> > diff --git a/src/storage.h b/src/storage.h
> > index d9b17c7f..a6076d63 100644
> > --- a/src/storage.h
> > +++ b/src/storage.h
> > @@ -36,6 +36,7 @@ bool storage_create_dirs(void);
> >   void storage_cleanup_dirs(void);
> >   char *storage_get_path(const char *format, ...);
> >   char *storage_get_hotspot_path(const char *format, ...);
> > +char *storage_get_ap_path(const char *format, ...);
> >   =

> >   const char *storage_network_filename_from_path(const char *path);
> >   const char *storage_network_ssid_from_path(const char *path,
> > =

> =

> Regards,
> -Denis

--===============7330833567477447610==--

