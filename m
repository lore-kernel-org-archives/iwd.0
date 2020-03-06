Content-Type: multipart/mixed; boundary="===============8621456025037361032=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [PATCH 3/4] agent: enforce a maximum passphrase length
Date: Fri, 06 Mar 2020 10:46:00 -0800
Message-ID: <1879405e9590b4bb759bc52c5a0a383c72e80ecf.camel@gmail.com>
In-Reply-To: <c2094193-46d1-7419-0f78-e76252b39c35@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8621456025037361032==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-03-06 at 12:27 -0600, Denis Kenzior wrote:
> Hi James,
> =

> On 3/6/20 11:48 AM, James Prestwood wrote:
> > ---
> >   src/agent.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> > =

> > diff --git a/src/agent.c b/src/agent.c
> > index d213f3cd..44039a89 100644
> > --- a/src/agent.c
> > +++ b/src/agent.c
> > @@ -159,6 +159,9 @@ static void passphrase_reply(struct
> > l_dbus_message *reply,
> >   	if (!l_dbus_message_get_arguments(reply, "s", &passphrase))
> >   		goto done;
> >   =

> > +	if (strlen(passphrase) > IWD_MAX_PASSPHRASE_LEN)
> > +		goto done;
> > +
> =

> This callback is used for three things from what I remember:
> 	1. The passphrase for decrypting private keys
> 	2. The passphrase for PSK networks.
> 	3. The password for EAP methods.
> =

> This checking should only apply to 3, no?

Well, we should probably have a maximum on all three... The private key
passphrase is sent to the kernel, so we probably don't want that to be
huge seems like we could put the same limitation on both 1 and 3. In
addition for PSK passphrases we should probably enforce 8-63 byte
lengths if we don't already somewhere else.

> =

> >   	result =3D AGENT_RESULT_OK;
> >   =

> >   done:
> > @@ -181,6 +184,9 @@ static void user_name_passwd_reply(struct
> > l_dbus_message *reply,
> >   	if (!l_dbus_message_get_arguments(reply, "ss", &username,
> > &passwd))
> >   		goto done;
> >   =

> > +	if (strlen(passwd) > IWD_MAX_PASSPHRASE_LEN)
> > +		goto done;
> > +
> >   	result =3D AGENT_RESULT_OK;
> >   =

> >   done:
> > =

> =

> Regards,
> -Denis
> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org

--===============8621456025037361032==--

