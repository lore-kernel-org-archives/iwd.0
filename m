Content-Type: multipart/mixed; boundary="===============5971928005622765046=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 4/5] doc: Clarify settings in iwd.ap(5)
Date: Mon, 26 Apr 2021 18:05:26 +0200
Message-ID: <CAOq732JyYXZrd_2HHSB2iXQtRzrTTC9BhC4=FQhuABjv4ygqYg@mail.gmail.com>
In-Reply-To: <850b3814-6625-fc1f-4b6b-fd45b77c13e3@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5971928005622765046==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Mon, 26 Apr 2021 at 17:53, Denis Kenzior <denkenz@gmail.com> wrote:
> > -The group ``[IPv4]`` contains settings for IWD's built in DHCP server.=
 All
> > -settings are optional.
> > +The group ``[IPv4]`` contains settings for IWD's built-in DHCP server.=
 All
> > +settings are optional.  They're used if network configuration was enab=
led as
> > +described in ``iwd.config(5)``.  Omitting the ``[IPv4]`` group disables
> > +network configuration and the DHCP server for this access point.
> >
>
> Hmm.. If 'all settings are optional', then how do you know whether 'IPv4'=
 group
> was omitted on purpose or not?

Well, you have to assume everything in the config file is done on
purpose.  I think this is the only place IWD looks at whether a group
is present but this is the current behavior AFAIK.

Best regards
--===============5971928005622765046==--

