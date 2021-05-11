Content-Type: multipart/mixed; boundary="===============1665195539380024571=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 2/2] netdev: Pass a reason code with
 NETDEV_EVENT_DISCONNECT_BY_*
Date: Wed, 12 May 2021 00:57:51 +0200
Message-ID: <CAOq732LWfdibQg8wsRSAoKYY3WZh3874dbyyV8jv6vmD-N81iA@mail.gmail.com>
In-Reply-To: <4b7b601f-2fba-345d-fb96-26b980d1aa13@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1665195539380024571==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 12 May 2021 at 00:34, Denis Kenzior <denkenz@gmail.com> wrote:
> On 5/11/21 4:56 PM, Andrew Zaborowski wrote:
> > On Tue, 11 May 2021 at 18:36, Denis Kenzior <denkenz@gmail.com> wrote:
> >> On 5/10/21 5:12 AM, Andrew Zaborowski wrote:
> >>> Station callbacks expect a reason code (as opposed to status codes) w=
ith
> >>> this event type.  This shouldn't matter a lot because
> >>> station_disconnect_event() only actually looks at the value during
> >>
> >> I'm not sure why station is written this way.  I'm pretty sure that ca=
lling
> >> station_disconnect_event() for NETDEV_EVENT_DISCONNECT_BY_SME() is the=
 wrong
> >> thing to do.
> >
> > That is currently the only use of that function though.
>
> No, we have DISCONNECT_BY_AP and DISCONNECT_BY_SME.  DISCONNECT_BY_SME sh=
ould
> pretty much imply station_disassociated() should be called since we shoul=
d never
> receive this event when we're in the connecting state.

I wouldn't rely on that, if the kernel doesn't pass
NL80211_ATTR_DISCONNECTED_BY_AP it could mean that the AP sent
something that triggered the kernel to disconnect (possibly before
handshake complete).  For us we mainly care that we can't use this BSS
and should try a different one next time.

Best regards
--===============1665195539380024571==--

