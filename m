Content-Type: multipart/mixed; boundary="===============8069010596825641456=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 4/5] doc: Clarify settings in iwd.ap(5)
Date: Mon, 26 Apr 2021 20:19:34 +0200
Message-ID: <CAOq732LPQBs18angEpbP3NpbE=vCJYCnt8G2gmHXwth4HNCugg@mail.gmail.com>
In-Reply-To: <1ef9b4de-7f23-204b-aaf8-2b283266fc19@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8069010596825641456==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 26 Apr 2021 at 18:22, Denis Kenzior <denkenz@gmail.com> wrote:
> On 4/26/21 11:05 AM, Andrew Zaborowski wrote:
> > Hi Denis,
> >
> > On Mon, 26 Apr 2021 at 17:53, Denis Kenzior <denkenz@gmail.com> wrote:
> >>> -The group ``[IPv4]`` contains settings for IWD's built in DHCP serve=
r. All
> >>> -settings are optional.
> >>> +The group ``[IPv4]`` contains settings for IWD's built-in DHCP serve=
r. All
> >>> +settings are optional.  They're used if network configuration was en=
abled as
> >>> +described in ``iwd.config(5)``.  Omitting the ``[IPv4]`` group disab=
les
> >>> +network configuration and the DHCP server for this access point.
> >>>
> >>
> >> Hmm.. If 'all settings are optional', then how do you know whether 'IP=
v4' group
> >> was omitted on purpose or not?
> >
> > Well, you have to assume everything in the config file is done on
> > purpose.  I think this is the only place IWD looks at whether a group
> > is present but this is the current behavior AFAIK.
> >
>
> So your intent is to have an empty [IPV4] group (i.e. '[IPv4]' line with =
nothing
> afterward)?

Yes, I think that was the intent of the current code,
e1b3e73c2b3b8864e8a4288a5a0d95b990a2321f mentions that we look at
whether the section is present although the meaning has changed since
then it seems.

>  This is a bit confusing since a user would simply omit the '[IPv4]'
> line as well if all the options were the defaults...

They will be told not to do so by the docs, but yes, I guess it can be
confusing like anything else when it's the first time you see it.

>
> Maybe mention the need for this line in the docs?

Ok.

>  Or alternatively... Do we
> even need the ability to turn of dhcp per profile?  Isn't
> EnableNetworkConfiguration enough?

I don't know, I'd leave that option in (in some form), I'm not sure if
the whole profile thing was motivated by an existing request or an
expectation of future use cases.

Best regards
--===============8069010596825641456==--

